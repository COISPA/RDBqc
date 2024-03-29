% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MEDBS_SOP.R
\name{MEDBS_SOP}
\alias{MEDBS_SOP}
\title{check of the sum of products}
\usage{
MEDBS_SOP(data, SP, MS, GSA, threshold = 5, verbose = TRUE)
}
\arguments{
\item{data}{Catch table in MED&BS datacall format}

\item{SP}{species code}

\item{MS}{member state code}

\item{GSA}{GSA code (Geographical sub-area)}

\item{threshold}{threshold value in percentage to check the percentage difference between SOP and both volumes of landing and discard. Default value is 5\%}

\item{verbose}{boolean. If TRUE messages are returned}
}
\value{
the function returns a data frame of the record with values of percentage difference between SOP and both volumes of landing and discard greater then threshold value.
}
\description{
check of the sum of products
}
\examples{
MEDBS_SOP(data = Catch_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9", threshold = 5)
}
\author{
Walter Zupa \href{mailto:zupa@coispa.it}{zupa@coispa.it}
}
