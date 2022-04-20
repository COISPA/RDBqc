% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RCG_check_lw.R
\name{RCG_check_lw}
\alias{RCG_check_lw}
\title{Consistency of length-weight relationship and consistency with allowed ranges}
\usage{
RCG_check_lw(data, MS, GSA, SP, Min = 0, Max = 1000, verbose = TRUE)
}
\arguments{
\item{data}{table of detailed data in RCG format}

\item{MS}{member state code}

\item{GSA}{GSA code}

\item{SP}{reference species for the analysis}

\item{Min}{min weight expected in the data}

\item{Max}{max weight expected in the data}

\item{verbose}{boolean. If it is TRUE messages are reported with the outputs}
}
\value{
Plot and error message
}
\description{
The function allows to check the consistency of length-weight relationship by sex and year on a given species generating a multi-frame plot. The function also returns the records in which the individual weights are greater or lower than the expected ones (\code{Min} and \code{Max} parameters).
}
\examples{
RCG_check_lw(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",Min=0,Max=1000)
}