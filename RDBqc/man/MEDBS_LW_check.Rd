% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MEDBS_LW_check.R
\name{MEDBS_LW_check}
\alias{MEDBS_LW_check}
\title{LW params in GP_tab in table check}
\usage{
MEDBS_LW_check(GP_tab, SP, MS, GSA, verbose = TRUE)
}
\arguments{
\item{GP_tab}{growth params table in MED&BS datacall format}

\item{SP}{species (three alpha code)}

\item{MS}{Country}

\item{GSA}{GSA (Geographical sub-area (GFCM sensu))}

\item{verbose}{boolean value to obtain further explanation messages from the function}
}
\value{
a summary table and plots of the LW params
}
\description{
The function allows to check the length-weight parameters included in the GP table for a selected species
}
\examples{
MEDBS_LW_check(GP_tab_example,"MUT","ITA","18")
}