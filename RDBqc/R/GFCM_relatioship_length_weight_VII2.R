#' Plot of the relationship length weight for each species
#'
#' @description Function to check the consistency of length-weight relationship in the GFCM Task VII.2 table per species.
#' @param data GFCM Task VII.2 table
#'
#' @return The function return a plot of the length weight relationship per species.
#' @export
#' @import ggplot2
#'
#' @examples check_lw_TaskVII.2(task_vii2)


check_lw_TaskVII.2 <- function(data){
#Package

  Length <- WeightIndividualsSampled <- NULL
  plot=ggplot(data, aes(x = Length, y = WeightIndividualsSampled))+
  geom_point(size=1) +facet_wrap(~Species,ncol=5,scales="free")+
  theme(strip.text = element_text(size=7,lineheight=1.0),
        strip.background = element_rect(fill="grey", colour="black",
                                        size=1))+
  xlab("Length") + ylab("Weight (kg)")

print(plot)
}

