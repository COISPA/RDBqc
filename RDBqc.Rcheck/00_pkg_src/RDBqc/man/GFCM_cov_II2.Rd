% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GFCM_cov_task2.2.R
\name{GFCM_cov_II2}
\alias{GFCM_cov_II2}
\title{Check coverage of GFCM task II.2 table}
\usage{
GFCM_cov_II2(
  data,
  MS,
  SP = "COMBINED",
  segment = "COMBINED",
  GSA,
  verbose = TRUE
)
}
\arguments{
\item{data}{GFCM task II.2 table}

\item{MS}{member state code}

\item{SP}{species reference code in the three alpha code format ("COMBINED" values perform the analysis for all species present in data)}

\item{segment}{segment code ("COMBINED" values perform the analysis for all segments present in data)}

\item{GSA}{GSA code}

\item{verbose}{boolean. If TRUE a message is printed.}
}
\value{
The function returns a list. The first element gives the summary table of records number. From the second to the third element gives 2 plots for total live landing and total discards (ton)).
}
\description{
The function checks and count the numbers of records data in the given task II.2 table grouped by year, GSA, MS, species, and segment for two variables (Total landing (ton) and total discards (ton)). If SP and segment are not specified by the user the function combines those by default.
}
\examples{
GFCM_cov_II2(data = task_ii2, MS = "ITA", GSA = "18", SP = "HKE", segment = "COMBINED")
}
\author{
Walter Zupa \href{mailto:zupa@coispa.it}{zupa@coispa.it}
}
