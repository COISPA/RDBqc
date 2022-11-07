#' Check number of record in FDI A table
#'
#' @description The function checks and count the numbers of records data in the given table A grouped by year, GSA, MS, species, vessels length, and fishing techniques for three variables (Total live weight landed (ton), total value of landings (euro), and total discards (ton)). If SP, Vessel length, and fishing technique are not specified by the user the function combines those by default.
#' @param data FDI table A catch
#' @param MS member state code
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format ("COMBINED" values perform the analysis for all species present in data)
#' @param vessel_len vessels length code ("COMBINED" values perform the analysis for all vessels length present in data)
#' @param fishtech selected fishing techniques ("COMBINED" values perform the analysis for all fishing techniques present in data)

#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a list. The first element gives the summary table of records number. From the second to the fourth element gives 3 plots for each variables among: of total live weight landed, total value of landings (euro), and total discards (ton)).
#' @export
#' @author Andrea Pierucci <pierucci@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples FDI_cov_tableA(data = fdi_a_catch, SP = "MUT", MS = "PSP", GSA = "GSA99")
#' FDI_cov_tableA(
#'   data = fdi_a_catch, SP = "MUT", MS = "PSP",
#'   fishtech = unique(fdi_a_catch$fishing_tech), GSA = "GSA99"
#' )
#' FDI_cov_tableA(data = fdi_a_catch, SP = "MUT", MS = "PSP", GSA = "GSA99")
#' @import tidyverse
#' @importFrom tidyr drop_na

FDI_cov_tableA <- function(data, MS, SP = "COMBINED", vessel_len = "COMBINED", fishtech = "COMBINED", GSA, verbose = TRUE) {
  year <- sub_region <- country <- species <- vessel_length <- fishing_tech <- totwghtlandg <- totvallandg <- discards <- NULL

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No data available"))
    }
    output <- NULL
  } else {


  # check of the species, combined vs specific species defined by the user
  if (length(SP) == 1 & SP[1] == "COMBINED") {
    data$SP <- "COMBINED"
  } else {
    data <- data[data$species %in% SP, ]
  }


  # check of the species, combined vs specific species defined by the user
  if (length(vessel_len) == 1 & vessel_len[1] == "COMBINED") {
    data$vessel_length <- "COMBINED"
  } else {
    data <- data[data$vessel_length %in% vessel_len, ]
  }


  # check of the fishtech, all vs specific fishtech defined by the user

  if (length(fishtech) == 1 & fishtech[1] == "COMBINED") {
    data$fishing_tech <- "COMBINED"
  } else {
    data <- data[data$fishing_tech %in% fishtech, ]
  }

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No data available for selected metiers and fishing techniques"))
    }
  } else {
    data[data == "NK"] <- NA
    data[data == "NA"] <- NA

    # Summary Table of records number
    suppressMessages(data1 <- data %>%
      drop_na(year, sub_region, country, species, vessel_length, fishing_tech) %>%
      select(year, sub_region, country, species, vessel_length, fishing_tech, totwghtlandg, totvallandg, discards) %>%
      filter(sub_region %in% GSA & country %in% MS & species %in% SP) %>%
      group_by(year, sub_region, country, species, vessel_length, fishing_tech) %>%
      summarise(totwghtlandg = sum(!is.na(totwghtlandg)), totvallandg = sum(!is.na(totvallandg)), discards = sum(!is.na(discards))))

    if (nrow(data1) == 0) {
      if (verbose) {
        message(paste0("No data available for the selected species (", SP, ")"))
      }
      output <- NULL
    } else {
      data2 <- data
      data2[is.na(data2)] <- 0
      suppressMessages(data3 <- data2 %>%
        drop_na(year, sub_region, country, species, vessel_length, fishing_tech) %>%
        select(year, sub_region, country, species, vessel_length, fishing_tech, totwghtlandg, totvallandg, discards) %>%
        filter(sub_region %in% GSA & country %in% MS & species %in% SP) %>%
        group_by(year, sub_region, country, species, vessel_length, fishing_tech) %>%
        summarise(
          totwghtlandg = sum(as.numeric(totwghtlandg)),
          totvallandg = sum(as.numeric(totvallandg)),
          discards = sum(as.numeric(discards))
        ))

      # Plot of 1=totwghtlandg, 2=totvallandg, and 3=discards

      suppressMessages(plot1 <- data3 %>%
        ggplot(aes(x = year, y = totwghtlandg, col = fishing_tech, linetype = vessel_length)) +
        geom_point() +
        geom_line() +
        scale_x_continuous(breaks = seq(min(data3$year), max(data3$year), 4)) +
        theme(
          axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
          axis.text.y = element_text(size = 15, colour = "black"),
          axis.title = element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 15)
        ) +
        ggtitle(paste(MS, "total live weight of", SP, "landed in", GSA)) +
        ylab("Total live weight landed (ton)") +
        xlab("year") +
        facet_wrap(~vessel_length))


      suppressMessages(plot2 <- data3 %>%
        ggplot(aes(x = year, y = totvallandg, col = fishing_tech, linetype = vessel_length)) +
        geom_point() +
        geom_line() +
        scale_x_continuous(breaks = seq(min(data3$year), max(data3$year), 4)) +
        theme(
          axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
          axis.text.y = element_text(size = 15, colour = "black"),
          axis.title = element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 15)
        ) +
        ggtitle(paste(MS, "total value of", SP, "landings in", GSA)) +
        ylab("Total value of landins (euro)") +
        xlab("year") +
        facet_wrap(~vessel_length))

      suppressMessages(plot3 <- data3 %>%
        ggplot(aes(x = year, y = discards, col = fishing_tech, linetype = vessel_length)) +
        scale_x_continuous(breaks = seq(min(data3$year), max(data3$year), 4)) +
        geom_point() +
        geom_line() +
        theme(
          axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
          axis.text.y = element_text(size = 15, colour = "black"),
          axis.title = element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 15)
        ) +
        ggtitle(paste(MS, "total discards of", SP, "landed in", GSA)) +
        ylab("Total discards (ton)") +
        xlab("year") +
        facet_wrap(~vessel_length))

      output <- list(as.data.frame(data1), as.data.frame(data3), suppressMessages(plot1), suppressMessages(plot2), suppressMessages(plot3))
      names(output) <- c("number_of_records", "summary_table", "total_landings", "total_land_value", "total_discards")


    }
  }
  }

  return(output)
}
