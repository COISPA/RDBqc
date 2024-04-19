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
  data <- data[data$Species %in% SP & data$Area %in% GSA &
    data$Flag_country %in% MS, ]
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
      message(paste0(
        "No data for the selected species (",
        SP, ")"
      ))
    }
  } else if (nrow(data) > 0) {
    data_mat <- data[!is.na(data$Maturity_Stage), ]
    if (nrow(data_mat) > 0) {
      data_mat$Mature[as.character(data_mat$Maturity_Stage) %in% immature_stages] <- 0
      data_mat$Mature[!(as.character(data_mat$Maturity_Stage) %in% immature_stages)] <- 1

      if (sex == "F") {
        merge_temp <- data_mat[as.character(data_mat$Sex) !=
          "M" & as.character(data_mat$Sex) != "N", ]
        if (nrow(merge_temp) > 0) {
          years <- paste("(", min(merge_temp$Year), "-",
            max(merge_temp$Year), ")",
            sep = ""
          )

          merge_tempMat <- merge_temp[as.numeric(merge_temp$Mature) == 1, ]
          Mat <- aggregate(merge_tempMat$Number_at_length,
            by = list(merge_tempMat$Length_class),
            FUN = "sum"
          )
          merge_tempImMat <- merge_temp[as.numeric(merge_temp$Mature) == 0, ]
          Immat <- aggregate(merge_tempImMat$Number_at_length,
            by = list(merge_tempImMat$Length_class),
            FUN = "sum"
          )

          merge_temp <- merge(Mat, Immat,
            by = c("Group.1"),
            all = TRUE
          )

          colnames(merge_temp) <- c(
            "Length_class", "Mature",
            "Immature"
          )

          if (nrow(merge_temp[is.na(merge_temp$Mature), ]) > 0) {
            merge_temp[is.na(merge_temp$Mature), ]$Mature <- 0
          }
          if (nrow(merge_temp[is.na(merge_temp$Immature), ]) > 0) {
            merge_temp[is.na(merge_temp$Immature), ]$Immature <- 0
          }
          merge_temp$Total <- rowSums(data.frame(
            merge_temp$Mature,
            merge_temp$Immature
          ))
          suppressWarnings(mod <- glm(cbind(
            merge_temp$Mature,
            merge_temp$Immature
          ) ~ merge_temp$Length_class,
          family = binomial("logit")
          ))
          coeff <- coefficients(mod)
          L50 <- -coeff[1] / coeff[2]
          IFM <- summary(mod)$cov.scaled
          I11 <- IFM[1, 1]
          I12 <- IFM[1, 2]
          I22 <- IFM[2, 2]
          SE_L50 <- sqrt((I11 + 2 * L50 * I12 + (L50^2) *
            I22) / (coeff[2]^2))
          L75 <- (log(0.75 / 0.25) - coeff[1]) / coeff[2]
          L25 <- (log(0.25 / 0.75) - coeff[1]) / coeff[2]
          MR <- L75 - L25
          SE_MR <- 2 * log(3, exp(1)) / ((coeff[2])^2) *
            sqrt(I22)
          merge_temp$proportion <- (merge_temp$Mature / merge_temp$Total)
          merge_temp$pred <- predict(mod,
            new.data = data.frame(Length_class = merge_temp$Length_class),
            type = "response"
          )
          title <- paste(SP, " - Females - ", years,
            sep = ""
          )
          lab <- paste(
            "L50= ", round(L50, 2), "+/-",
            round(SE_L50, 2), "\n", "MR= ", round(
              MR,
              3
            ), "+/-", round(SE_MR, 3)
          )
          p <- ggplot(data = merge_temp, aes(x = Length_class, y = proportion)) +
            geom_point(shape = 1, size = 3.5) +
            geom_line(aes(x = Length_class, y = pred), data = merge_temp, col = "deeppink3", size = 1.5) +
            ggtitle(title) +
            xlab("Length (mm)") +
            ylab("Proportion of matures") +
            geom_text(data = data.frame(), aes(label = lab, x = Inf, y = -Inf), hjust = 1, vjust = 0, size = 4) +
            theme(axis.text = element_text(size = 12), axis.title = element_text(size = 14, face = "bold"))
        } else {
          p <- NULL
        }
      }
      # rm(merge_temp)

      if (sex == "M") {
        merge_temp <- data_mat[as.character(data_mat$Sex) !=
          "F" & as.character(data_mat$Sex) != "N", ]
        if (nrow(merge_temp) > 0) {
          years <- paste("(", min(merge_temp$Year), "-",
            max(merge_temp$Year), ")",
            sep = ""
          )
          merge_tempMat <- merge_temp[as.numeric(merge_temp$Mature) == 1, ]

          Mat <- aggregate(merge_tempMat$Number_at_length,
            by = list(merge_tempMat$Length_class),
            FUN = "sum"
          )

          merge_tempImMat <- merge_temp[as.numeric(merge_temp$Mature) == 0, ]

          Immat <- aggregate(merge_tempImMat$Number_at_length, by = list(merge_tempImMat$Length_class), FUN = "sum")

          merge_temp <- merge(Mat, Immat, by = c("Group.1"), all = TRUE)
          colnames(merge_temp) <- c(
            "Length_class", "Mature",
            "Immature"
          )
          if (nrow(merge_temp[is.na(merge_temp$Mature), ]) > 0) {
            merge_temp[is.na(merge_temp$Mature), ]$Mature <- 0
          }
          if (nrow(merge_temp[is.na(merge_temp$Immature), ]) > 0) {
            merge_temp[is.na(merge_temp$Immature), ]$Immature <- 0
          }


          merge_temp$Total <- rowSums(data.frame(
            merge_temp$Mature,
            merge_temp$Immature
          ))
          suppressWarnings(mod <- glm(cbind(
            merge_temp$Mature,
            merge_temp$Immature
          ) ~ merge_temp$Length_class,
          family = binomial("logit")
          ))
          coeff <- coefficients(mod)
          L50 <- -coeff[1] / coeff[2]
          IFM <- summary(mod)$cov.scaled
          I11 <- IFM[1, 1]
          I12 <- IFM[1, 2]
          I22 <- IFM[2, 2]
          SE_L50 <- sqrt((I11 + 2 * L50 * I12 + (L50^2) *
            I22) / (coeff[2]^2))
          L75 <- (log(0.75 / 0.25) - coeff[1]) / coeff[2]
          L25 <- (log(0.25 / 0.75) - coeff[1]) / coeff[2]
          MR <- L75 - L25
          SE_MR <- 2 * log(3, exp(1)) / ((coeff[2])^2) *
            sqrt(I22)
          merge_temp$proportion <- (merge_temp$Mature / merge_temp$Total)
          merge_temp$pred <- predict(mod,
            new.data = data.frame(Length_class = merge_temp$Length_class),
            type = "response"
          )
          title <- paste(SP, " - Males - ", years, sep = "")
          lab <- paste(
            "L50= ", round(L50, 2), "+/-",
            round(SE_L50, 2), "\n", "MR= ", round(
              MR,
              3
            ), "+/-", round(SE_MR, 3)
          )
          p <- ggplot(data = merge_temp, aes(
            x = Length_class,
            y = proportion
          )) +
            geom_point(
              shape = 1,
              size = 3.5
            ) +
            geom_line(aes(
              x = Length_class,
              y = pred
            ),
            inherit.aes = FALSE, data = merge_temp,
            col = "deepskyblue3", size = 1.5
            ) +
            ggtitle(title) +
            xlab("Length (mm)") +
            ylab("Proportion of matures") +
            geom_text(
              data = data.frame(), aes(
                label = lab,
                x = Inf, y = -Inf
              ), hjust = 1, vjust = 0,
              size = 4
            ) +
            theme(
              axis.text = element_text(size = 12),
              axis.title = element_text(size = 14, face = "bold")
            )
        } else {
          p <- NULL
        }
      }
    } else {
      p <- NULL
    }
    return(p)
  }
}
