#' Check of mean discard weight aggregations by year, gear and fishery
#'
#' @param data data frame containing discards data
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to check consistency of mean discard of a selected species plotting the discards' weight by year, gear and fishery
#' @return The function returns a plot of the mean discards weight by year, gear and fishery aggregation
#' @export MEDBS_disc_mean_weight
#' @examples MEDBS_disc_mean_weight(data = Discard_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables


MEDBS_disc_mean_weight <- function(data, SP, MS, GSA, verbose = TRUE) {
  . <- GEAR <- VESSEL_LENGTH <- MESH_SIZE_RANGE <- DISCARDS <- QUARTER <- MW <- YEAR <- tmp1 <- totW <- totN <- FISHERY <- NULL

  colnames(data) <- toupper(colnames(data))
  land <- data
  land <- land[which(land$AREA == as.character(GSA) & land$COUNTRY == MS & land$SPECIES == SP), ]
  land$DISCARDS[land$DISCARDS == -1] <- 0

  if (nrow(land) > 1) {
    land <- as.data.frame(land)
    var_no_landed <- grep("LENGTHCLASS", names(land), value = TRUE)
    sel_nl <- c(var_no_landed)
    pippo <- (land[, which(names(land) %in% sel_nl)])
    pippo = apply(pippo, 2, function(x) as.numeric(as.character(x)));
    pippo[is.na(pippo)] <- 0
    pippo[pippo == -1] <- 0
    pippo[pippo == ""] <- 0
    landRev <- cbind(land[, c(1:13)], pippo)
    suppressMessages(ck_nbl <- landRev %>% mutate(sum = rowSums(.[14:114])))
    suppressMessages(Wg <- ck_nbl %>% group_by(YEAR, QUARTER, VESSEL_LENGTH, GEAR, MESH_SIZE_RANGE, FISHERY) %>% summarize(totW = sum(DISCARDS) * 1000000))
    suppressMessages(No <- ck_nbl %>% group_by(YEAR, QUARTER, VESSEL_LENGTH, GEAR, MESH_SIZE_RANGE, FISHERY) %>% summarize(totN = sum(sum) * 1000))
    suppressMessages(MWdb <- full_join(Wg, No))

    suppressMessages(MWdb <- MWdb %>% mutate(MW = totW / totN))
    suppressMessages(MWdbpositive <- MWdb %>% filter(MW > 0))
    suppressMessages(MWdbpositive <- MWdbpositive %>% filter(MW != Inf))

    output <- list()
    l <- length(output) + 1
    MWdb <- as.data.frame(MWdb)
    colnames(MWdb)[9] <- "MW(g)"
    MWdb[is.infinite(MWdb$`MW(g)`), "MW(g)"] <- NA
    output[[l]] <- as.data.frame(MWdb)
    names(output)[[l]] <- "summary table"

    if (nrow(MWdbpositive) > 0) {
      plot <- ggplot(as.data.frame(MWdbpositive), aes(x = YEAR, y = MW)) +
        geom_point(col = "red") +
        geom_line() +
        facet_grid(FISHERY ~ GEAR + QUARTER, scales = "free_y") +
        theme(strip.background = element_rect(fill = "white")) +
        scale_x_continuous(breaks = seq(min(MWdbpositive$YEAR), max(MWdbpositive$YEAR), by = 4)) +
        theme(axis.text.x = element_text(angle = 45, size = 8)) +
        ggtitle(paste0(SP, " ", MS, " ", GSA, " Discard Mean weight")) +
        xlab("") +
        ylab("MW (g)")

      l <- length(output) + 1
      output[[l]] <- plot
      names(output)[[l]] <- paste("Disc_MW", SP, MS, GSA, sep = " _ ")
    } else {
      l <- length(output) + 1
      output[[l]] <- NULL
    }
    return(output)
  } else {
    if (verbose) {
      message("No discard data in the subset.\n")
    }
    return(NULL)
  }
}
