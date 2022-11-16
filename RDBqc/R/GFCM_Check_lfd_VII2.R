#'  Consistency of length frequency distributions
#'
#' @description Function to verify the consistency of the length frequency distributions (LFD) reported in the TaskVII.2 table. The functions generates plots of the LFD by species, source, segment and year.
#' @param data GFCM Task II.2 table
#' @param MS member state code
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a table with the comparison between min/max lengths observed for each species with theoretical values.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_ldf_TaskVII.2(task_vii2, MS = "ITA", GSA = "18", SP="HKE")
check_ldf_TaskVII.2 <- function(data, MS, GSA, SP, verbose=TRUE) {

  if (FALSE) {
    data <- read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB\\data\\GFCM-DCRF-Tasks_2018-2019\\GFCM-DCRF-Tasks_2018-2019\\GFCM-DCRF_TaskVII-2-Biological_Length_2018-2019.csv",sep=";",header=TRUE)
    # data=task_vii2
    MS = "ITA"
    GSA = "18"
    SP = "HKE"
      check_ldf_TaskVII.2(data, MS, GSA, SP, verbose=TRUE)
  }
  CPC <- Gear <- L50 <- Length <- NumberAlive <- NumberCaught <- NumberDead <-
    NumberIndividuals <- NumberIndividualsExpanded <- NumberReleased <-
    Reference_Year <- Segment <- Sex <- Source <- Species <- WeightCaught <- tot_Caught <- NULL

  data <- data[data$CPC == MS & data$GSA %in% GSA & data$Species %in% SP, ]

  if (nrow(data) == 0) {
    if (verbose){
      message("No data for the selected Country and GSA combination. ")
    }
    return(NULL)
  } else {

    data1 <- suppressMessages(
      data %>% group_by(Reference_Year, Source, Segment, Length) %>% summarise(NumberIndividuals = sum(NumberIndividualsExpanded, na.rm=TRUE))
    )

    data_BS <- data1[data1$Source =="BS",]
    source <- "BS"
    # Plot of tot_Caught
    suppressMessages(plot1 <- data_BS %>%
                       ggplot(aes(x = Length , y = NumberIndividuals , col = Segment)) +
                       # geom_point(size=2) +
                       geom_line(size=0.8) +
                       scale_x_continuous(breaks = seq(trunc(min(data_BS$Length)), trunc(max(data_BS$Length)), (max(data_BS$Length)-min(data_BS$Length))%/%5 )) +
                       theme(
                         axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
                         axis.text.y = element_text(size = 15, colour = "black"),
                         axis.title = element_text(size = 15),
                         plot.title = element_text(hjust = 0.5, size = 15)
                       ) +
                       ggtitle(paste(MS, " - Total individuals caught (expanded) in GSA", GSA, "(BS)")) +
                       ylab("Total individuals caught") +
                       xlab("Year") +
                       facet_wrap(~Reference_Year)
    )


    data_SU <- data1[data1$Source =="SU",]
    source <- "SU"
    # Plot of tot_Caught
    suppressMessages(plot2 <- data_SU %>%
                       ggplot(aes(x = Length , y = NumberIndividuals , col = Segment)) +
                       # geom_point(size=2) +
                       geom_line(size=0.8) +
                       scale_x_continuous(breaks = seq(trunc(min(data1$Length)), trunc(max(data1$Length)), (max(data_SU$Length)-min(data_SU$Length))%/%5)) +
                       theme(
                         axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
                         axis.text.y = element_text(size = 15, colour = "black"),
                         axis.title = element_text(size = 15),
                         plot.title = element_text(hjust = 0.5, size = 15)
                       ) +
                       ggtitle(paste(MS, " - Total individuals caught (expanded) in GSA", GSA, "(SU)")) +
                       ylab("Total individuals caught") +
                       xlab("Year") +
                       facet_wrap(~Reference_Year)
    )
    return(list(plot1,plot2))
    }
}
