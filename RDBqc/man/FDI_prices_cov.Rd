% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FDI_price_cov.R
\name{FDI_prices_cov}
\alias{FDI_prices_cov}
\title{Check prices trend in FDI A table}
\usage{
FDI_prices_cov(data, MS, SP = "COMBINED", GSA = "COMBINED", verbose = TRUE)
}
\arguments{
\item{data}{FDI table A catch}

\item{MS}{member state code}

\item{SP}{species reference code in the three alpha code format ("COMBINED" values perform the analysis for all species present in data)}

\item{GSA}{GSA code ("COMBINED" values perform the analysis for all GSAs present in data).}

\item{verbose}{boolean. If TRUE a message is printed.}
}
\value{
The function returns a list. The first element gives the summary table of records number. From the second to the fourth element gives 3 plots for each variables among: of total live weight landed, total value of landings (euro), and total discards (ton)).
}
\description{
The function checks the trend prices in the given table grouped by year, GSA, MS, and species. If SP are not specified by the user the function combines those by default.
}
\examples{
FDI_prices_cov(data = fdi_a_catch, SP = c("MUT", "HKE"), MS = "PSP", GSA = "GSA99")
FDI_prices_cov(data = fdi_a_catch, SP = "MUT", MS = "PSP", GSA = "GSA99")
}
\author{
Andrea Pierucci \href{mailto:pierucci@coispa.eu}{pierucci@coispa.eu}

Walter Zupa \href{mailto:zupa@coispa.it}{zupa@coispa.it}
}
