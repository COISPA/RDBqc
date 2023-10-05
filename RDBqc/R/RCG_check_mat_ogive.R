#' check_mat_ogive
#'
#' @param data table of detailed data in RCG format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param sex defines the sex of the individuals selected for the analysis ('F' for females, 'M' for males)
#' @param immature_stages vector of maturity stages considered immature
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to check the maturity stages composition estimating the maturity ogives by sex for the selected species, using a selected pool of stages to classify the immature stages in the sample.
#' @return Plot ogive by sex
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @export
#' @examples RCG_check_mat_ogive(data_ex,
#'   MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus",
#'   sex = "F", immature_stages = c("0", "1", "2a")
#' )
#' @importFrom graphics legend lines
#' @importFrom stats binomial coefficients glm predict

RCG_check_mat_ogive <- function(data, MS, GSA, SP, sex, immature_stages = c("0", "1", "2a"), verbose = TRUE) {
  data <- check_cs_header(data)
  pred <- proportion <- Length_class <- Number_at_length <- Maturity_Stage <- Sex <- Stage <- NULL
  data <- data[data$Species %in% SP & data$Area %in% GSA & data$Flag_country %in% MS, ]

  if (any(is.na(data$Length_class))) {
    if (verbose) {
      message(paste0("NA values in the 'Length_class' field will be removed from the analysis"))
    }
    data <- data[!is.na(data$Length_class), ]
  }
  if (any(is.na(data$Number_at_length))) {
    if (verbose) {
      message(paste0("NA values in the 'Number_at_length' field will be removed from the analysis"))
    }
    data <- data[!is.na(data$Number_at_length), ]
  }

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No data for the selected species (", SP, ")"))
    }
  } else if (nrow(data) > 0) {


    # summary table of number of individuals by length class by maturity stage
    # data_sex <- data[!is.na(data$Sex), ]
    # tab_sex <- aggregate(data_sex$Number_at_length, by = list(data_sex$Year, data_sex$Length_class), FUN = "length")
    # colnames(tab_sex) <- c("Year", "Length_class", "nb_sex_measurements")

    # summary table of number of individuals by length class by maturity stage
    data_mat <- data[!is.na(data$Maturity_Stage), ]
    if (nrow(data_mat)>0) {
    tab_mat <- aggregate(data_mat$Number_at_length, by = list(data_mat$Year, data_mat$Length_class), FUN = "length")
    colnames(tab_mat) <- c("Year", "Length_class", "nb_maturity_stage_measurements")

    # Maturity ogive
    data_mat <- data_mat[(as.character(data_mat$Sex) == "F" | as.character(data_mat$Sex) == "M") & (!is.na(data_mat$Maturity_Stage) & data_mat$Maturity_Stage != 0), ]
    data_mat$Mature[as.character(data_mat$Maturity_Stage) %in% immature_stages] <- 0
    data_mat$Mature[!(as.character(data_mat$Maturity_Stage) %in% immature_stages)] <- 1
    mat <- data_mat[data_mat$Mature == 1, colnames(data_mat) %in% c("Year", "Sex", "Length_class", "Mature", "Number_at_length")]
    immat <- data_mat[data_mat$Mature == 0, colnames(data_mat) %in% c("Year", "Sex", "Length_class", "Mature", "Number_at_length")]
    merge <- merge(mat, immat, by = c("Length_class", "Year", "Sex"), all = TRUE)
    colnames(merge)[4] <- "Mature"
    colnames(merge)[6] <- "Immature"
    merge <- merge[, c(1, 2, 3, 4, 6)]

    if (length(which(is.na(merge$Mature))) > 0) {
      merge[is.na(merge$Mature), ]$Mature <- 0
    }
    if (length(which(is.na(merge$Immature))) > 0) {
      merge[is.na(merge$Immature), ]$Immature <- 0
    }
    merge$Total <- merge$Immature + merge$Immature

    if (sex == "F") {
      # females
      merge_temp <- merge[as.character(merge$Sex) != "M" & as.character(merge$Sex) != "N", ]

      if (nrow(merge_temp)>0){
      years <- paste("(", min(merge_temp$Year), "-", max(merge_temp$Year), ")", sep = "")
      Mat <- aggregate(merge_temp$Mature, by = list(merge_temp$Length_class), FUN = "sum")
      Immat <- aggregate(merge_temp$Immature, by = list(merge_temp$Length_class), FUN = "sum")
      merge_temp <- merge(Mat, Immat, by = c("Group.1"), all = TRUE)
      colnames(merge_temp) <- c("Length_class", "Mature", "Immature")
      merge_temp$Total <- rowSums(data.frame(merge_temp$Mature, merge_temp$Immature))
      suppressWarnings(mod <- glm(cbind(merge_temp$Mature, merge_temp$Immature) ~ merge_temp$Length_class, family = binomial("logit")))
      coeff <- coefficients(mod)
      L50 <- -coeff[1] / coeff[2]
      IFM <- summary(mod)$cov.scaled
      I11 <- IFM[1, 1]
      I12 <- IFM[1, 2]
      I22 <- IFM[2, 2]
      SE_L50 <- sqrt((I11 + 2 * L50 * I12 + (L50^2) * I22) / (coeff[2]^2))
      # inverse of Information Fisher's Matrix
      L75 <- (log(0.75 / 0.25) - coeff[1]) / coeff[2]
      L25 <- (log(0.25 / 0.75) - coeff[1]) / coeff[2]
      MR <- L75 - L25
      SE_MR <- 2 * log(3, exp(1)) / ((coeff[2])^2) * sqrt(I22)

      merge_temp$proportion <- (merge_temp$Mature / merge_temp$Total)
      merge_temp$pred <- predict(mod, new.data = merge_temp$Length_class, type = "response")
      title <- paste(SP, " - Females - ", years, sep = "")
      lab <- paste("L50= ", round(L50, 2), "+/-", round(SE_L50, 2), "\n", "MR= ", round(MR, 3), "+/-", round(SE_MR, 3))
      p <- ggplot(data = merge_temp, aes(x = Length_class, y = proportion)) +
        geom_point(shape = 1, size = 3.5) +
        geom_line(aes(x = Length_class, y = pred), inherit.aes = FALSE, data = merge_temp, col = "deeppink3", size = 1.5) +
        ggtitle(title) +
        xlab("Length (mm)") +
        ylab("Proportion of matures") +
        geom_text(
          data = data.frame(), aes(label = lab, x = Inf, y = -Inf),
          hjust = 1, vjust = 0, size = 4
        ) +
        theme(
          axis.text = element_text(size = 12),
          axis.title = element_text(size = 14, face = "bold")
        )
      } else {
        p = NULL
      }

    } # sex F

    if (sex == "M") {
      # males
      merge_temp <- merge[as.character(merge$Sex) != "F" & as.character(merge$Sex) != "N", ]

      if (nrow(merge_temp)>0){
      years <- paste("(", min(merge_temp$Year), "-", max(merge_temp$Year), ")", sep = "")

      Mat <- aggregate(merge_temp$Mature, by = list(merge_temp$Length_class), FUN = "sum")
      Immat <- aggregate(merge_temp$Immature, by = list(merge_temp$Length_class), FUN = "sum")
      merge_temp <- merge(Mat, Immat, by = c("Group.1"))
      colnames(merge_temp) <- c("Length_class", "Mature", "Immature")
      merge_temp$Total <- rowSums(data.frame(merge_temp$Mature, merge_temp$Immature))
      suppressWarnings(mod <- glm(cbind(merge_temp$Mature, merge_temp$Immature) ~ merge_temp$Length_class, family = binomial("logit")))

      coeff <- coefficients(mod)
      L50 <- -coeff[1] / coeff[2]
      IFM <- summary(mod)$cov.scaled
      I11 <- IFM[1, 1]
      I12 <- IFM[1, 2]
      I22 <- IFM[2, 2]
      SE_L50 <- sqrt((I11 + 2 * L50 * I12 + (L50^2) * I22) / (coeff[2]^2))
      # inverse of Information Fisher's Matrix
      L75 <- (log(0.75 / 0.25) - coeff[1]) / coeff[2]
      L25 <- (log(0.25 / 0.75) - coeff[1]) / coeff[2]
      MR <- L75 - L25
      SE_MR <- 2 * log(3, exp(1)) / ((coeff[2])^2) * sqrt(I22)
      merge_temp$proportion <- (merge_temp$Mature / merge_temp$Total)
      merge_temp$pred <- predict(mod, new.data = merge_temp$Length_class, type = "response")
      title <- paste(SP, " - Males - ", years, sep = "")
      lab <- paste("L50= ", round(L50, 2), "+/-", round(SE_L50, 2), "\n", "MR= ", round(MR, 3), "+/-", round(SE_MR, 3))
      p <- ggplot(data = merge_temp, aes(x = Length_class, y = proportion)) +
        geom_point(shape = 1, size = 3.5) +
        geom_line(aes(x = Length_class, y = pred), inherit.aes = FALSE, data = merge_temp, col = "deepskyblue3", size = 1.5) +
        ggtitle(title) +
        xlab("Length (mm)") +
        ylab("Proportion of matures") +
        geom_text(
          data = data.frame(), aes(label = lab, x = Inf, y = -Inf),
          hjust = 1, vjust = 0, size = 4
        ) +
        theme(
          axis.text = element_text(size = 12),
          axis.title = element_text(size = 14, face = "bold")
        )
      } else {
        p=NULL
      }
    } # sex M

    } else {
      p =NULL
    }
    return(p)
  } # (nrow(data)>0)
}
