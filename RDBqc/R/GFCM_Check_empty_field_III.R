#' Check empty fields in GFCM Task III table
#'
#' @param data GFCM Task III table
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function checks the presence of not allowed empty data in the given table, according to the \href{https://gfcm.sharepoint.com/sites/DCRF/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2FDCRF%2FShared%20Documents%2FGFCM%2DDCRF%2Dmanual%2D2018%2Dv%2E21%2E2%2Epdf&parent=%2Fsites%2FDCRF%2FShared%20Documents&p=true&ga=1}{GFCM, 2018. GFCM Data Collection Reference Framework (DCRF). Version: 20.1}
#' @return Two lists are returned by the function. The first list gives the number of NA for each reference column. The second list gives the index of each NA in the reference column.
#' @export
#'
#' @examples check_EF_taskIII(task_iii)
check_EF_taskIII <- function(data, verbose = TRUE) {
  # Declaration of variables and suppression of empty columns for dataframe1
  data <- data[, which(colnames(data) %in% c(
    "Reference_Year",
    "CPC",
    "GSA",
    "Segment",
    "Group",
    "Date",
    "Source",
    "NumberCaught"
  ))] # c(1:6,8,11)



  # selection of fields of interest and definition of NA

  data$Reference_Year[data$Reference_Year == ""] <- NA
  data$CPC[data$CPC == ""] <- NA
  data$GSA[data$GSA == ""] <- NA
  data$Segment[data$Segment == ""] <- NA
  data$Group[data$Group == ""] <- NA
  data$Date[data$Date == ""] <- NA
  data$Source[data$Source == ""] <- NA
  data$NumberCaught[data$NumberCaught == ""] <- NA


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

  #

  results2 <- list(NA_finder_col1, NA_finder_col2, NA_finder_col3, NA_finder_col4, NA_finder_col5, NA_finder_col6, NA_finder_col7, NA_finder_col8)
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

  output <- list(results, results2)
  return(output)
}
