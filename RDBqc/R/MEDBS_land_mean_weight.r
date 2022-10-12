#' Mean weight by year, gear and fishery aggregation
#'
#' @param data data frame containing landing data
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to check consistency of mean landing of a selected species plotting the landings' weight by year, gear and fishery
#' @return The function returns a plot of the mean landing weight by year, gear and fishery aggregation, and returns the data frame as well.
#' @export MEDBS_land_mean_weight
#'
#' @examples MEDBS_land_mean_weight(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables


MEDBS_land_mean_weight <- function(data, SP, MS, GSA, verbose = TRUE) {
  if (FALSE) {
    MS <- "ITA"
    GSA <- "GSA 9"
    SP <- "DPS"
    # verbose=TRUE
    data <- Landing_tab_example
    MEDBS_land_mean_weight(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")
  }

  . <- gear <- vessel_length <- mesh_size_range <- landings <- quarter <- MW <- year <- tmp1 <- totW <- totN <- fishery <- NULL

  colnames(data) <- tolower(colnames(data))
  land <- data

  # land$area <- as.numeric(gsub("[^0-9.-]+","\\1",land$area))
  land <- land[which(land$area == as.character(GSA) & land$country == MS & land$species == SP), ]

  if (nrow(land) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else {
    land$landings[land$landings == -1] <- 0

    land <- as.data.frame(land)
    var_no_landed <- grep("lengthclass", names(land), value = TRUE)
    sel_nl <- c(var_no_landed)
    pippo <- (land[, which(names(land) %in% sel_nl)])
    pippo[is.na(pippo)] <- 0
    pippo[pippo == -1] <- 0
    pippo[pippo == ""] <- 0
    landRev <- cbind(land[, c(1:13)], pippo)
    dim(landRev)
    suppressMessages(ck_nbl <- landRev %>% mutate(sum = rowSums(.[14:114])))
    names(ck_nbl)
    suppressMessages(Wg <- ck_nbl %>% group_by(year, quarter, vessel_length, gear, mesh_size_range, fishery) %>% summarize(totW = sum(landings) * 1000000))
    suppressMessages(No <- ck_nbl %>% group_by(year, quarter, vessel_length, gear, mesh_size_range, fishery) %>% summarize(totN = sum(sum) * 1000))
    suppressMessages(MWdb <- full_join(Wg, No))

    suppressMessages(MWdb <- MWdb %>% mutate(MW = totW / totN))
    suppressMessages(MWdbpositive <- MWdb %>% filter(MW > 0))
    suppressMessages(MWdbpositive <- MWdbpositive %>% filter(MW != Inf))

    output <- list()
    l <- length(output) + 1
    output[[l]] <- as.data.frame(MWdb)
    names(output)[[l]] <- "summary table"

    suppressMessages(
    plot <- ggplot(MWdbpositive, aes(x = year, y = MW)) +
      geom_point(col = "red") +
      geom_line() +
      facet_grid(fishery ~ gear + quarter, scales = "free_y") +
      theme(strip.background = element_rect(fill = "white")) +
      scale_x_continuous(breaks = seq(min(MWdbpositive$year), max(MWdbpositive$year), by = 4)) +
      theme(axis.text.x = element_text(angle = 45, size = 8)) +
      ggtitle(paste0(SP, " ", MS, " ", GSA, " Landing Mean weight")) +
      xlab("") +
      ylab("MW (g)")
      )

    l <- length(output) + 1
    output[[l]] <- plot
    names(output)[[l]] <- paste("Land_MW", SP, MS, GSA, sep = " _ ")

    return(output) # as.data.frame(MWdb)
  }
}
