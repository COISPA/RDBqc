% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_cs_headers.r
\name{check_cs_header}
\alias{check_cs_header}
\title{Headers check for CS table}
\usage{
check_cs_header(cs, verbose = FALSE)
}
\arguments{
\item{cs}{RCG sampling table (CS)}

\item{verbose}{boolean. If TRUE messages are returned}
}
\value{
The data frame of CS data is returned with the expected format used by the QC functions
}
\description{
Headers check for CS table
}
\examples{
check_cs_header(data_ex)
}
