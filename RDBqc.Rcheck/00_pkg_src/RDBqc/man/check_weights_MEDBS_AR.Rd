% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_weights_MEDBS_AR.r
\name{check_weights_MEDBS_AR}
\alias{check_weights_MEDBS_AR}
\title{Cross check of number of weight measurements between MED&BS GP table and AR Table 2.2}
\usage{
check_weights_MEDBS_AR(
  GP,
  AR,
  MS,
  GSA,
  SP,
  year,
  species_list = RDBqc::SSPP,
  OUT = FALSE,
  verbose = TRUE
)
}
\arguments{
\item{GP}{data frame containing MED&BS GP table}

\item{AR}{data frame containing Annual Report data table 2.2}

\item{MS}{member state code}

\item{GSA}{Geographical Subarea}

\item{SP}{Species 3-alpha code}

\item{year}{Reference year for the analysis}

\item{species_list}{table of species 3-alpha codes, reporting the MED & BS mandatory species}

\item{OUT}{Default is FALSE. If set as TRUE tables in csv will be saved in the OUTPUT folder created in the working directory}

\item{verbose}{boolean. If TRUE a message is printed.}
}
\value{
A list of three data frames is returned. The first list element contains all the species matching between the two tables; the second list element reports the species reported in Annual Report but not in the MED&BS GP table; the third list element contains the species reported in MED&BS GP table but not in the Annual Report table 2.2. Warnings are reported for data of species not included in the MED&BS data call, and for species expected in the Work Plan and not reported in the Annual Report. Errors are reported for species expected in both tables but not present at least in one of the two tables.
}
\description{
The function compares the number of weight measurements reported in GP table of MED & BS data call with the information reported in the table 2.2 ("Biol variables") of the Annual Report.
The user have to define the two source tables as data frames in the \code{GP} and \code{AR} parameters. The analysis should be constrained at the selected country level (\code{MS}), geographical sub-area \code{GSA} and \code{year}.
}
\author{
Walter Zupa \href{mailto:zupa@fondazionecoispa.org}{zupa@fondazionecoispa.org}
}
