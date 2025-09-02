#' check the length-weight consistency in the Catch table
#'
#' @param data Catch table in MED&BS datacall format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @return the function returns a plot with the lengths and weights from the Catch table by year.
#' @importFrom dplyr bind_cols select mutate filter matches rename_with
#' @importFrom tidyr pivot_longer
#' @importFrom stringr str_replace
#' @importFrom ggplot2 ggplot aes geom_point labs theme_minimal
#' @importFrom ggpubr ggarrange annotate_figure text_grob
#' @export
#' @author Isabella Bitetto <bitetto@fondazionecoispa.org>
#' @examples MEDBS_Catch_LW(data = Catch_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")
MEDBS_Catch_LW <- function(data, SP, MS, GSA, verbose = TRUE) {

    AGE_COL <-LENGTHCLASS<- MEAN_LENGTH_DISCARD<- MEAN_LENGTH_LANDED<-
    MEAN_WEIGHT_DISCARD<- MEAN_WEIGHT_LANDED<- YEAR<- NULL

    colnames(data) <- toupper(colnames(data))
    data[is.na(data$VESSEL_LENGTH), "VESSEL_LENGTH"] <- "NA"
    data[is.na(data$GEAR), "GEAR"] <- "NA"
    data[is.na(data$MESH_SIZE_RANGE), "MESH_SIZE_RANGE"] <- "NA"
    data[is.na(data$FISHERY), "FISHERY"] <- "NA"
    data <- data[data$AREA == as.character(GSA) & data$COUNTRY == MS & data$SPECIES == SP, ]
    Data_call <- data

    if (nrow(data) > 0) {
        #-----------CHECK CONSISTENCY LANDING-----------
        Data_call[Data_call$LANDINGS == -1, "LANDINGS"] <- 0
        Data_call[Data_call$DISCARDS == -1, "DISCARDS"] <- 0
        for (p in 25:ncol(Data_call)) {
            Data_call[, p] <- as.numeric(Data_call[, p])
            Data_call[is.na(Data_call[, p]), p] <- 0
            Data_call[Data_call[, p] == -1, p] <- 0
        }

        # Landing_nb <- Data_call[, 1:12]
        # i <- 1
        # for (i in 1:20) {
        #     Landing_nb <- cbind(Landing_nb, Data_call[, which(colnames(Data_call) == paste("AGE_", i - 1, "_NO_LANDED", sep = ""))])
        #     colnames(Landing_nb)[ncol(Landing_nb)] <- paste("AGE_", i - 1, "_NO_LANDED", sep = "")
        # }
        # Landing_nb <- cbind(Landing_nb, Data_call[, (colnames(Data_call) == "AGE_20_PLUS_NO_LANDED" | colnames(Data_call) == "AGE_20_NO_LANDED")])
        #
        # colnames(Landing_nb) <- c(colnames(Data_call[1:12]), paste("AGE_", c(0:19), "_NO_LANDED", sep = ""), "AGE_20_PLUS_NO_LANDED")
        #
        # Landing_nb[, 13:ncol(Landing_nb)][Landing_nb[, 13:ncol(Landing_nb)] == -1] <- 0
        # Landing_nb$Sum <- rowSums(Landing_nb[, 13:ncol(Landing_nb)])
        # pos_indices <- which(Landing_nb$Sum > 0)
        Landing_wt <- Data_call[, 1:12]
        for (i in 1:20) {
            Landing_wt <- cbind(Landing_wt, Data_call[, colnames(Data_call) == paste("AGE_", i - 1, "_MEAN_WEIGHT_LANDED", sep = "") | colnames(Data_call) == paste("AGE_", i - 1, "_WT_LANDED", sep = "")])
        }
        Landing_wt <- cbind(Landing_wt, Data_call[, colnames(Data_call) == "AGE_20_PLUS_MEAN_WEIGHT_LANDED" | colnames(Data_call) == "AGE_20_WT_LANDED"])
        colnames(Landing_wt) <- c(colnames(Data_call[1:12]), paste("AGE_", c(0:19), "_MEAN_WEIGHT_LANDED", sep = ""), "AGE_20_PLUS_MEAN_WEIGHT_LANDED")

        Landing_wt[, 13:ncol(Landing_wt)][Landing_wt[, 13:ncol(Landing_wt)] == -1] <- 0

        Landing_lgt <- Data_call[, 1:12]
        for (i in 1:20) {
            Landing_lgt <- cbind(Landing_lgt, Data_call[, colnames(Data_call) == paste("AGE_", i - 1, "_MEAN_LENGTH_LANDED", sep = "") | colnames(Data_call) == paste("AGE_", i - 1, "_LT_LANDED", sep = "")])
        }
        Landing_lgt <- cbind(Landing_lgt, Data_call[, colnames(Data_call) == "AGE_20_PLUS_MEAN_WEIGHT_LANDED" | colnames(Data_call) == "AGE_20_LT_LANDED"])
        colnames(Landing_lgt) <- c(colnames(Data_call[1:12]), paste("AGE_", c(0:19), "_MEAN_LENGTH_LANDED", sep = ""), "AGE_20_PLUS_MEAN_LENGTHT_LANDED")

        Landing_lgt[, 13:ncol(Landing_lgt)][Landing_lgt[, 13:ncol(Landing_lgt)] == -1] <- 0


        # Data_call$check_LANDING <- NA
        # Data_call$check_DISCARD <- NA
        # Data_call$sumprodl <- NA
        # Data_call$SOPl <- NA
        # Data_call$sumprodd <- NA
        # Data_call$SOPd <- NA

        # The first 12 columns are metadata (as in your original code)
        meta_cols <- names(Landing_wt)[1:12]

        lw_long <- bind_cols(
            Landing_wt[, meta_cols],
            Landing_wt %>%
                select(matches("^AGE_\\d+_MEAN_WEIGHT_LANDED$|^AGE_20_PLUS_MEAN_WEIGHT_LANDED$")),
            Landing_lgt %>%
                select(matches("^AGE_\\d+_MEAN_LENGTH_LANDED$|^AGE_\\d+_MEAN_LENGTHT_LANDED$|^AGE_20_PLUS_MEAN_LENGTH_LANDED$|^AGE_20_PLUS_MEAN_LENGTHT_LANDED$")) %>%
                rename_with(~ str_replace(.x, "MEAN_LENGTHT_LANDED", "MEAN_LENGTH_LANDED"))
        ) %>%
            pivot_longer(
                cols = -all_of(meta_cols),
                names_to   = c("AGE_COL", ".value"),
                names_pattern = "^(AGE_\\d+|AGE_20_PLUS)_(MEAN_WEIGHT_LANDED|MEAN_LENGTH_LANDED)$"
            ) %>%
            select(-AGE_COL) %>%
            # optional cleanup
            mutate(
                MEAN_WEIGHT_LANDED = ifelse(MEAN_WEIGHT_LANDED <= 0, NA, MEAN_WEIGHT_LANDED),
                MEAN_LENGTH_LANDED = ifelse(MEAN_LENGTH_LANDED <= 0, NA, MEAN_LENGTH_LANDED)
            ) %>%
            filter(!is.na(MEAN_WEIGHT_LANDED), !is.na(MEAN_LENGTH_LANDED))

        df <- lw_long %>%
            filter(MEAN_LENGTH_LANDED > 0,
                   MEAN_WEIGHT_LANDED > 0,
                   is.finite(MEAN_LENGTH_LANDED),
                   is.finite(MEAN_WEIGHT_LANDED)) %>%
            mutate(YEAR = as.factor(YEAR))  # color by year

        # Single scatter plot
      p1<-  ggplot(df, aes(x = MEAN_LENGTH_LANDED, y = MEAN_WEIGHT_LANDED, color = YEAR)) +
            geom_point(alpha = 0.6, size = 2) +
            labs(
                x = "Mean length in landing",
                y = "Mean weight in landing",
                color = "Year",
                title = "Length weight from Catch (landing columns)"
            ) +
            theme_minimal()


# DISCARDS

      Discard_wt <- Data_call[, c(1:11,13)]
      for (i in 1:20) {
          Discard_wt <- cbind(Discard_wt, Data_call[, colnames(Data_call) == paste("AGE_", i - 1, "_MEAN_WEIGHT_DISCARD", sep = "") | colnames(Data_call) == paste("AGE_", i - 1, "_WT_DISCARD", sep = "")])
      }
      Discard_wt <- cbind(Discard_wt, Data_call[, colnames(Data_call) == "AGE_20_PLUS_MEAN_WEIGHT_DISCARD" | colnames(Data_call) == "AGE_20_WT_DISCARD"])
      colnames(Discard_wt) <- c(colnames(Data_call[c(1:11,13)]), paste("AGE_", c(0:19), "_MEAN_WEIGHT_DISCARD", sep = ""), "AGE_20_PLUS_MEAN_WEIGHT_DISCARD")

      Discard_wt[, 13:ncol(Discard_wt)][Discard_wt[, 13:ncol(Discard_wt)] == -1] <- 0

      Discard_lgt <- Data_call[, c(1:11,13)]
      for (i in 1:20) {
          Discard_lgt <- cbind(Discard_lgt, Data_call[, colnames(Data_call) == paste("AGE_", i - 1, "_MEAN_LENGTH_DISCARD", sep = "") | colnames(Data_call) == paste("AGE_", i - 1, "_LT_DISCARD", sep = "")])
      }
      Discard_lgt <- cbind(Discard_lgt, Data_call[, colnames(Data_call) == "AGE_20_PLUS_MEAN_WEIGHT_DISCARD" | colnames(Data_call) == "AGE_20_LT_DISCARD"])
      colnames(Discard_lgt) <- c(colnames(Data_call[1:12]), paste("AGE_", c(0:19), "_MEAN_LENGTH_DISCARD", sep = ""), "AGE_20_PLUS_MEAN_LENGTHT_DISCARD")

      Discard_lgt[, 13:ncol(Discard_lgt)][Discard_lgt[, 13:ncol(Discard_lgt)] == -1] <- 0


      # Data_call$check_LANDING <- NA
      # Data_call$check_DISCARD <- NA
      # Data_call$sumprodl <- NA
      # Data_call$SOPl <- NA
      # Data_call$sumprodd <- NA
      # Data_call$SOPd <- NA

      # The first 12 columns are metadata
      meta_cols <- names(Discard_wt)[c(1:12)]
      lw_long <- bind_cols(
          Discard_wt[, meta_cols],
          Discard_wt %>%
              select(matches("^AGE_\\d+_MEAN_WEIGHT_DISCARD$|^AGE_20_PLUS_MEAN_WEIGHT_DISCARD$")),
          Discard_lgt %>%
              select(matches("^AGE_\\d+_MEAN_LENGTH_DISCARD$|^AGE_\\d+_MEAN_LENGTHT_DISCARD$|^AGE_20_PLUS_MEAN_LENGTH_DISCARD$|^AGE_20_PLUS_MEAN_LENGTHT_DISCARD$")) %>%
              rename_with(~ str_replace(.x, "MEAN_LENGTHT_DISCARD", "MEAN_LENGTH_DISCARD"))
      ) %>%
          pivot_longer(
              cols = -all_of(meta_cols),
              names_to   = c("AGE_COL", ".value"),
              names_pattern = "^(AGE_\\d+|AGE_20_PLUS)_(MEAN_WEIGHT_DISCARD|MEAN_LENGTH_DISCARD)$"
          ) %>%
          select(-AGE_COL) %>%
          # optional cleanup
          mutate(
              MEAN_WEIGHT_DISCARD = ifelse(MEAN_WEIGHT_DISCARD <= 0, NA, MEAN_WEIGHT_DISCARD),
              MEAN_LENGTH_DISCARD = ifelse(MEAN_LENGTH_DISCARD <= 0, NA, MEAN_LENGTH_DISCARD)
          ) %>%
          filter(!is.na(MEAN_WEIGHT_DISCARD), !is.na(MEAN_LENGTH_DISCARD))

      df <- lw_long %>%
          filter(MEAN_LENGTH_DISCARD > 0,
                 MEAN_WEIGHT_DISCARD > 0,
                 is.finite(MEAN_LENGTH_DISCARD),
                 is.finite(MEAN_WEIGHT_DISCARD)) %>%
          mutate(YEAR = as.factor(YEAR))  # color by year

      # Single scatter plot
      p2<-  ggplot(df, aes(x = MEAN_LENGTH_DISCARD, y = MEAN_WEIGHT_DISCARD, color = YEAR)) +
          geom_point(alpha = 0.6, size = 2) +
          labs(
              x = "Mean length in discard",
              y = "Mean weight in discard",
              color = "Year",
              title = "Length weight from Catch (discard columns)"
          ) +
          theme_minimal()


      p <- ggarrange(p1,p2,
                     common.legend = TRUE,legend="right",nrow=1, ncol=2)
      p <- annotate_figure(p, top = text_grob(paste0("Length-weight for landing and discard from catch table of ", SP, " in ", MS, " - ", GSA), size = 8))

          return(p)



    }
}
