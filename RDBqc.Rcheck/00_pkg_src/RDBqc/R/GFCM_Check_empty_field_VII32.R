#' Check empty fields in GFCM Task VII.3.2 table
#'
#' @param data GFCM Task VII.3.2 table
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function checks the presence of not allowed empty data in the given table, according to the \href{https://gfcm.sharepoint.com/sites/DCRF/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2FDCRF%2FShared%20Documents%2FGFCM%2DDCRF%2Dmanual%2D2018%2Dv%2E21%2E2%2Epdf&parent=%2Fsites%2FDCRF%2FShared%20Documents&p=true&ga=1}{GFCM, 2018. GFCM Data Collection Reference Framework (DCRF). Version: 20.1}
#' @return Two lists are returned by the function. The first list gives the number of NA for each reference column. The second list gives the index of each NA in the reference column.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_EF_TaskVII32(task_vii32)
#'
####
check_EF_TaskVII32 <- function(data, verbose = TRUE) {
  # Declaration of variables and suppression of empty columns for dataframe1
  data <- data[, c(
    "Reference_Year", "CPC", "GSA", "Source", "SurveyName", "Segment", "Species",
    "LengthUnit", "Length", "Sex", "Maturity", "NumberIndividualsMeasured",
    "WeightIndividualsSampled", "NumberIndividualsExpanded"
  )] # c(1:14)


  # selection of fields of interest and definition of NA

  data$Reference_Year[data$Reference_Year == ""] <- NA
  data$CPC[data$CPC == ""] <- NA
  data$GSA[data$GSA == ""] <- NA
  data$Source[data$Source == ""] <- NA
  data$SurveyName[data$SurveyName == ""] <- NA
  data$Segment[data$Segment == ""] <- NA
  data$Species[data$Species == ""] <- NA
  data$LengthUnit[data$LengthUnit == ""] <- NA
  data$Length[data$Length == ""] <- NA
  data$Sex[data$Sex == ""] <- NA
  data$Maturity[data$Maturity == ""] <- NA
  data$NumberIndividualsMeasured[data$NumberIndividualsMeasured == ""] <- NA
  data$WeightIndividualsSampled[data$WeightIndividualsSampled == ""] <- NA
  data$NumberIndividualsExpanded[data$NumberIndividualsExpanded == ""] <- NA

  # Localisation of the NA
  results <- sapply(data, function(x) sum(is.na(x)))
  NA_finder_col1 <- which(is.na(data[, 1]), arr.ind = TRUE)
  NA_finder_col2 <- which(is.na(data[, 2]), arr.ind = TRUE)
  NA_finder_col3 <- which(is.na(data[, 3]), arr.ind = TRUE)
  NA_finder_col4 <- which(is.na(data[, 4]), arr.ind = TRUE)

  control <- data$source_data_cd == "SU" & is.na(data$survey_name)
  NA_finder_col5 <- which(control, arr.ind = TRUE)

  NA_finder_col6 <- which(is.na(data[, 6]), arr.ind = TRUE)
  NA_finder_col7 <- which(is.na(data[, 7]), arr.ind = TRUE)
  NA_finder_col8 <- which(is.na(data[, 8]), arr.ind = TRUE)
  NA_finder_col9 <- which(is.na(data[, 9]), arr.ind = TRUE)
  NA_finder_col10 <- which(is.na(data[, 10]), arr.ind = TRUE)
  NA_finder_col11 <- which(is.na(data[, 11]), arr.ind = TRUE)
  NA_finder_col12 <- which(is.na(data[, 12]), arr.ind = TRUE)
  NA_finder_col13 <- which(is.na(data[, 13]), arr.ind = TRUE)
  NA_finder_col14 <- which(is.na(data[, 14]), arr.ind = TRUE)

  results2 <- list(NA_finder_col1, NA_finder_col2, NA_finder_col3, NA_finder_col4, NA_finder_col5, NA_finder_col6, NA_finder_col7, NA_finder_col8, NA_finder_col9, NA_finder_col10, NA_finder_col11, NA_finder_col12, NA_finder_col13, NA_finder_col14)
  names(results2) <- colnames(data)

  # col 1
  if (verbose) {
    if (length(NA_finder_col1) == 0) {
      message(paste("no NA in the", colnames(data)[1], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col1), " NA in ", colnames(data)[1]))
    }
  }


  # col 2
  if (verbose) {
    if (length(NA_finder_col2) == 0) {
      message(paste("no NA in the", colnames(data)[2], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col2), " NA in ", colnames(data)[2]))
    }
  }

  # col 3
  if (verbose) {
    if (length(NA_finder_col3) == 0) {
      message(paste("no NA in the", colnames(data)[3], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col3), " NA in ", colnames(data)[3]))
    }
  }

  # col 4
  if (verbose) {
    if (length(NA_finder_col4) == 0) {
      message(paste("no NA in the", colnames(data)[4], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col4), " NA in ", colnames(data)[4]))
    }
  }

  # col 5
  if (verbose) {
    if (length(NA_finder_col5) == 0) {
      message(paste("no NA in the", colnames(data)[5], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col5), " NA in ", colnames(data)[5]))
    }
  }

  # col 6
  if (verbose) {
    if (length(NA_finder_col6) == 0) {
      message(paste("no NA in the", colnames(data)[6], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col6), " NA in ", colnames(data)[6]))
    }
  }

  # col 7
  if (verbose) {
    if (length(NA_finder_col7) == 0) {
      message(paste("no NA in the", colnames(data)[7], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col7), " NA in ", colnames(data)[7]))
    }
  }

  # col 8
  if (verbose) {
    if (length(NA_finder_col8) == 0) {
      message(paste("no NA in the", colnames(data)[8], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col8), " NA in ", colnames(data)[8]))
    }
  }

  # col 9
  if (verbose) {
    if (length(NA_finder_col9) == 0) {
      message(paste("no NA in the", colnames(data)[9], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col9), " NA in ", colnames(data)[9]))
    }
  }

  # col 10
  if (verbose) {
    if (length(NA_finder_col10) == 0) {
      message(paste("no NA in the", colnames(data)[10], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col10), " NA in ", colnames(data)[10]))
    }
  }

  # col 11
  if (verbose) {
    if (length(NA_finder_col11) == 0) {
      message(paste("no NA in the", colnames(data)[11], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col11), " NA in ", colnames(data)[11]))
    }
  }

  # col 12
  if (verbose) {
    if (length(NA_finder_col12) == 0) {
      message(paste("no NA in the", colnames(data)[12], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col12), " NA in ", colnames(data)[12]))
    }
  }

  # col 13
  if (verbose) {
    if (length(NA_finder_col13) == 0) {
      message(paste("no NA in the", colnames(data)[13], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col13), " NA in ", colnames(data)[13]))
    }
  }

  # col 14
  if (verbose) {
    if (length(NA_finder_col14) == 0) {
      message(paste("no NA in the", colnames(data)[14], "column"))
    } else {
      message(paste("There are ", length(NA_finder_col14), " NA in ", colnames(data)[14]))
    }
  }

  output <- list(results, results2)
  return(output)
}
