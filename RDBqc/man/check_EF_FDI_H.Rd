% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FDI_Check_empty_field_H.R
\name{check_EF_FDI_H}
\alias{check_EF_FDI_H}
\title{Check empty fields in FDI H table}
\usage{
check_EF_FDI_H(data, verbose = TRUE)
}
\arguments{
\item{data}{FDI Task H table}

\item{verbose}{boolean. If TRUE a message is printed.}
}
\value{
Two lists are returned by the function. The first list gives the number of NA for each reference column. The second list gives the index of each NA in the reference column.
}
\description{
The function checks the presence of not allowed empty data in the given table.
}
\examples{
check_EF_FDI_H(fdi_h_spatial_landings)
}
\author{
Loredana Casciaro \href{mailto:casciaro@coispa.eu}{casciaro@coispa.eu}

Sebastien Alfonso \href{mailto:salfonso@coispa.eu}{salfonso@coispa.eu}

Walter Zupa \href{mailto:zupa@coispa.it}{zupa@coispa.it}
}
