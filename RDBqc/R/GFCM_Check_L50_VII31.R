#'  Consistency of L50 values in Task VII.3.1 table
#'
#' @description Function to verify the consistency of L50 reported in the TaskVII.3.1 table by mean of plot by GSA, species and sex
#' @param data GFCM Task VII.3.1 table
#' @param MS member state code
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a plot to visualize the L50 time series by species and sex for the selected MS and GSA
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_l50_TaskVII.3.1(task_vii31, MS = "ITA", GSA = "19",SP="HKE")
check_l50_TaskVII.3.1 <- function(data, MS, GSA, SP=NA, verbose=FALSE) {
  if (FALSE) {
    data <- read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB\\data\\GFCM-DCRF-Tasks_2018-2019\\GFCM-DCRF-Tasks_2018-2019\\GFCM-DCRF_TaskVII-3-1-Biological-SizeFirstMaturity_2018-19.csv",sep=";",header=TRUE) # task_vii31
    MS = "ITA"
    SP = "HKE"
    check_l50_TaskVII.3.1(data, MS = "ITA", GSA = "18",SP="HKE")
  }

  CPC <- Gear <- L50 <- Length <- NumberAlive <- NumberCaught <- NumberDead <-
    NumberIndividuals <- NumberIndividualsExpanded <- NumberReleased <-
    Reference_Year <- Segment <- Sex <- Source <- Species <- WeightCaught <- tot_Caught <- NULL

  if (length(SP)==1 & is.na(SP[1])) {
    SP <- sort(unique(data$Species))
  }
  data <- data[data$CPC == MS & data$GSA %in% GSA & data$Species %in% SP, ]

  if (nrow(data) > 0) {

    suppressMessages(plot1 <- data %>%
                       ggplot(aes(x = Reference_Year , y = L50 , col = Sex)) +
                       geom_point(size=2) +
                       geom_line(size=0.8) +
                       scale_x_continuous(breaks = seq(trunc(min(data$Reference_Year)), trunc(max(data$Reference_Year)), (max(data$Reference_Year)-min(data$Reference_Year))%/%1 )) +
                       theme(
                         axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
                         axis.text.y = element_text(size = 15, colour = "black"),
                         axis.title = element_text(size = 15),
                         plot.title = element_text(hjust = 0.5, size = 15)
                       ) +
                       ggtitle(paste(MS, " - L50 in GSA", GSA)) +
                       ylab("L50") +
                       xlab("Year") +
                       facet_wrap(~Species)
    )

    return(plot1)
  } else {
    if (verbose){
      message("No data for the selected Country and GSA combination. ")
    }
    return(NULL)
  }
}
