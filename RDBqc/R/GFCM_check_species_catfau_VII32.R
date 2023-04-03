#' Check mismatching species/Catfau and Sex per maturity stages for Task VII.3.2 table
#'
#' @description Function to check the correct codification of faunistic category according to species and sex in Task VII.3.2 table.
#' @param data GFCM Task VII.3.2 table
#' @param species List of combination of species/faunistic category for Task VII.3.2 table
#' @param matsex List of combination of sex/maturity stages for Task VII.3.2 table
#' @param MS member state code
#' @param GSA GSA code
#' @param SP species code
#' @param verbose boolean. If TRUE messages are returned
#' @return Two vectors are returned by the function. The first provides the list of mismatching combination of species/faunistic categories. The second vector provides the list of mismatching combination of sex/maturity stages. Furthermore, a plot of the length distribution by sex and maturity is returned for the selected species.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_species_catfau_TaskVII.3.2(task_vii32, catfau_check, sex_mat,
#'   MS = "ITA", GSA = "18", SP = "HKE"
#' )
check_species_catfau_TaskVII.3.2 <- function(data, species, matsex, MS, GSA, SP, verbose = FALSE) {
  Length <- Maturity <- Sex <- NULL
  data <- data[data$CPC == MS & data$GSA == GSA & data$Species == SP, ]
  species <- species[species$GSA == GSA, ]
  data <- data[data$Maturity != "", ]

  if (nrow(data) > 0) {

    # Control 1 - Scientific name X CATFAU
    points <- grep(".", data$Maturity, fixed = TRUE)
    slashs <- grep("/", data$Maturity, fixed = TRUE)

    if (length(points) > 0 & length(slashs) > 0) {
      data$CATFAU_REV <- substr(data$Maturity, 1, 3)
    } else if (length(points) == 0) {
      data$CATFAU_REV <- substr(data$Maturity, 1, 2)
      s1 <- substr(data$CATFAU_REV, 1, 1)
      s2 <- substr(data$CATFAU_REV, 2, 2)
      data$CATFAU_REV <- paste(s1, s2, sep = ".")
      data$CATFAU_REV[data$CATFAU_REV == "."] <- NA
    }

    # Dataframe 1 - Concatenation species/CATFAU_rev
    data$ID <- paste(data$Species, data$CATFAU_REV)
    data$ID <- as.character(data$ID)

    # Dataframe 2 - Concatenation species/CATFAU_rev
    species$ID <- paste(species$Species, species$CATFAU_REV)
    species$ID <- as.character(species$ID)

    # Creation of data frame mixing the information from the two dataframes
    level_fac_dat1 <- data.frame(ID = unique(data$ID), observed = unique(data$ID))
    level_fac_dat2 <- data.frame(ID = unique(species$ID), expected = unique(species$ID))
    m <- merge(level_fac_dat2, level_fac_dat1, all = TRUE)
    unexpected_codes_Species_catfau <- m$ID[which(is.na(m$expected))]

    # plot
    if (length(slashs) > 0) {
      maturity <- strsplit(data$Maturity, " / ")
      maturity <- do.call(rbind, maturity)[, 2]
      data$Maturity <- maturity
    } else {
      s <- data$Maturity
      s[which(s == "")] <- NA
      ncar <- nchar(s, allowNA = TRUE)
      nc_1 <- ncar - 1
      data$Maturity <- substr(data$Maturity, nc_1, ncar)
      data$Maturity[which(substr(data$Maturity, 1, 1) == "0")] <- substr(data$Maturity[which(substr(data$Maturity, 1, 1) == "0")], 2, 2)
    }

    p <- ggplot(data = data, aes(x = Length, y = Maturity, col = Sex)) +
      geom_point(stat = "identity", fill = "darkorchid4") +
      facet_grid(Reference_Year ~ Sex) +
      xlab("Length Class") +
      ylab("Maturity Stage") +
      ggtitle(SP)

    l_res <- list(unexpected_codes_Species_catfau, p)
  } else {
    if (verbose) {
      message("No data for the selected combination of MS, GSA and SP")
    }
    l_res <- NULL
  }
  return(l_res)
}
