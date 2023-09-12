#' Check empty fields in FDI J table
#'
#' @description The function checks the presence of not allowed empty data in the given table.
#' @param data GFCM Task J table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return Two lists are returned by the function. The first list gives the number of NA for each reference column. The second list gives the index of each NA in the reference column.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_EF_FDI_J(fdi_j_capacity)
#'
####
check_EF_FDI_J <- function(data, verbose = TRUE) {
  # Declaration of variables and suppression of empty columns for dataframe1
  data <- data[, 1:14]

  data$tottrips <- as.character(data$tottrips)
  data$totkw <- as.character(data$totkw)
  data$totgt <- as.character(data$totgt)
  data$totves <- as.character(data$totves)
  data$avgage <- as.character(data$avgage)
  data$avgloa <- as.character(data$avgloa)
  data$maxseadays <- as.character(data$maxseadays)

  # selection of fields of interest and definition of NA

  data$country[data$country == ""] <- NA
  data$year[data$year == ""] <- NA
  data$vessel_length[data$vessel_length == ""] <- NA
  data$fishing_tech[data$fishing_tech == ""] <- NA
  data$supra_region[data$supra_region == ""] <- NA
  data$geo_indicator[data$geo_indicator == ""] <- NA
  data$principal_sub_region[data$principal_sub_region == ""] <- NA
  data$tottrips[data$tottrips == ""] <- NA
  data$totkw[data$totkw == ""] <- NA
  data$totgt[data$totgt == ""] <- NA
  data$totves[data$totves == ""] <- NA
  data$avgage[data$avgage == ""] <- NA
  data$avgloa[data$avgloa == ""] <- NA
  data$maxseadays[data$maxseadays == ""] <- NA


  # Localisation of the NA
  results <- sapply(data, function(x) sum(is.na(x)))
  NA_finder_col1 <- which(is.na(data[, 1]), arr.ind = TRUE)
  NA_finder_col2 <- which(is.na(data[, 2]), arr.ind = TRUE)
  NA_finder_col3 <- which(is.na(data[, 3]), arr.ind = TRUE)
  NA_finder_col4 <- which(is.na(data[, 4]), arr.ind = TRUE)
  NA_finder_col5 <- which(is.na(data[, 5]), arr.ind = TRUE)
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
  output
  return(output)
}
