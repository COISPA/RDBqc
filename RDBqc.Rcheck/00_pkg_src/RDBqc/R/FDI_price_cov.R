#' Check prices trend in FDI A table
#'
#' @description The function checks the trend prices in the given table grouped by year, GSA, MS, and species. If SP are not specified by the user the function combines those by default.
#' @param data FDI table A catch
#' @param MS member state code
#' @param SP species reference code in the three alpha code format ("COMBINED" values perform the analysis for all species present in data)
#' @param GSA GSA code ("COMBINED" values perform the analysis for all GSAs present in data).
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a list. The first element gives the summary table of records number. From the second to the fourth element gives 3 plots for each variables among: of total live weight landed, total value of landings (euro), and total discards (ton)).
#' @export
#' @author Andrea Pierucci <pierucci@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples FDI_prices_cov(data = fdi_a_catch, SP = c("MUT", "HKE"), MS = "PSP", GSA = "GSA99")
#' FDI_prices_cov(data = fdi_a_catch, SP = "MUT", MS = "PSP", GSA = "GSA99")
#' @import tidyverse
#' @importFrom tidyr drop_na

FDI_prices_cov <- function(data, MS, SP = "COMBINED", GSA = "COMBINED", verbose = TRUE) {
  country <- mean_price <- species <- sub_region <- totvallandg <- totwghtlandg <- year <- NULL

  if (nrow(data) == 0) {
    stop(paste0("No data available"))
  }

  # check of the GSA, combined vs GSA  defined by the user
  if (length(GSA) == 1 & GSA[1] == "COMBINED") {
    data$sub_region <- "COMBINED"
  } else {
    data <- data[data$sub_region %in% GSA, ]
  }
  # check of the species, combined vs specific species defined by the user
  if (length(SP) == 1 & SP[1] == "COMBINED") {
    data$species <- "COMBINED"
  } else {
    data <- data[data$species %in% SP, ]
  }

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No data available for selected country, species and or GSA "))
    }
  } else {
    data[data == "NK"] <- 0
    data[data == "NA"] <- 0
    data[is.na(data)] <- 0

    # Summary Table of records number by country, GSA, and specie
    suppressMessages(data1 <- data %>%
      tidyr::drop_na(year, country, sub_region, species) %>%
      select(year, country, sub_region, species, totwghtlandg, totvallandg) %>%
      filter(sub_region %in% GSA & country %in% MS & species %in% SP) %>%
      group_by(year, country, sub_region, species) %>%
      summarise(
        totwghtlandg = sum(as.numeric(totwghtlandg)),
        totvallandg = sum(as.numeric(totvallandg)),
        mean_price = totvallandg / totwghtlandg / 1000
      ))

    # Summary table of records by country and species
    data2 <- data
    data2[is.na(data2)] <- 0
    suppressMessages(data2 <- data %>%
      drop_na(year, country, species) %>%
      select(year, country, species, totwghtlandg, totvallandg) %>%
      filter(country %in% MS & species %in% SP) %>%
      group_by(year, country, species) %>%
      summarise(
        totwghtlandg = sum(as.numeric(totwghtlandg)),
        totvallandg = sum(as.numeric(totvallandg)),
        mean_price = totvallandg / totwghtlandg / 1000
      ))


    data2$sub_region <- "COMBINED"
    data2 <- data2 %>% select(year, country, sub_region, species, totwghtlandg, totvallandg, mean_price)
    data3 <- rbind(data1, data2)

    Nspecies <- unique(data3$species)
    plot_list <- list()
    for (i in Nspecies)
    {
      plot_list[[i]] <-
        ggplot(data = data3[data3$species == i, ], aes(x = year, y = mean_price, col = sub_region, linetype = country)) +
        geom_point() +
        geom_line() +
        scale_x_continuous(breaks = seq(min(data3$year), max(data3$year), 4)) +
        theme(
          axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
          axis.text.y = element_text(size = 15, colour = "black"),
          axis.title = element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 15)
        ) +
        ggtitle(paste0(i, " - Average price (Euro/Kg)")) +
        ylab("price (Euro/Kg)") +
        xlab("year")
    }

    output <- plot_list
    return(list(Summary_Table_by_GSA = as.data.frame(data1), Summary_Table_by_Country = as.data.frame(data2), plots = output))
  }
}
