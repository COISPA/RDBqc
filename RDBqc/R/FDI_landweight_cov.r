#' Coverage of weight of landings in FDI table A and H
#'
#' @param dataA data frame of the FDI table A
#' @param dataH data frame of the FDI table H
#' @param MS Country code
#' @param verbose boolean. If TRUE a message is printed.
#' @description The functions checks the coverage of weight of landings comparing data reported in table A and H
#' @return The function returns a data frame reporting the weight of landings by GSA and by year
#' @export
#' @examples FDI_landweight_cov(dataA=fdi_a_catch, dataH=fdi_h_spatial_landings, MS="PSP", verbose = TRUE)
FDI_landweight_cov <- function(dataA, dataH, MS, verbose = FALSE){

    country <- NULL

    colnames(dataA) <- tolower(colnames(dataA))
    colnames(dataH) <- tolower(colnames(dataH))

    # check if MS is existing
    mslistA <- unique(dataA$country)
    mslistH <- unique(dataH$country)
    if (MS %in% mslistA & MS %in% mslistH) {
        print(paste("Coverage of landings' weight for", MS, "data in tables A and H", sep=" ") )
    }else if (!(MS %in% mslistA)){
        stop('MS not existing in table A')
    }else if (!(MS %in% mslistH)){
        stop('MS not existing in table H')
    }else {
        stop('MS not existing in table A and H')
    }

    # subset for MS
    dataA    <- subset(dataA, country == MS)
    dataH    <- subset(dataH, country == MS)
    dataA$id <- seq(1,nrow(dataA), 1)
    dataH$id <- seq(1,nrow(dataH), 1)

    gsasA <- unique(dataA$sub_region)
    gsasH <- unique(dataH$sub_region)
    yrsA  <- unique(dataA$year)
    yrsH  <- unique(dataH$year)

    # check there are gsas and years reported
    if (is.null(gsasA)) {stop('No SUB_REGIONS existing in table A')}
    if (is.null(yrsA)) {stop('No YEARS existing in table A')}
    if (is.null(gsasH)) {stop('No SUB_REGIONS existing in table H')}
    if (is.null(yrsH)) {stop('No YEARS existing in table H')}

    # check for NAs in gsas or years reported

    gsasA <- dataA$sub_region
    gsasH <- dataH$sub_region
    yrsA  <- dataA$year
    yrsH  <- dataH$year

    naA1 <- which(is.na(gsasA))
    naA2 <- which(is.na(yrsA))
    naH1 <- which(is.na(gsasH))
    naH2 <- which(is.na(yrsH))


    if (verbose) {
        if (length(naA1)!=0) {message(paste('Found NAs in SUB_REGIONS in', length(naA1), 'rows in table A' )) }
        if (length(naA2)!=0) {message(paste('Found NAs in Years in', length(naA2), 'rows, in table A' )) }
        if (length(naH1)!=0) {message(paste('Found NAs in SUB_REGIONS in', length(naH1), 'rows in table H' )) }
        if (length(naH2)!=0) {message(paste('Found NAs in Years in', length(naH2), 'rows, in table H' )) }
    }

    # Landings weight coverage in tables A and H by gsa (comparison)
    covA <- aggregate(list(landingsA=dataA$totwghtlandg), by =list(year = dataA$year, country=dataA$country , gsa= dataA$sub_region), FUN=sum, na.rm=T)
    covH <- aggregate(list(landingsH=dataH$totwghtlandg), by =list(year = dataH$year, country=dataA$country, gsa= dataH$sub_region), FUN=sum, na.rm=T)

    # merge tables by year and gsa
    cov        <- merge(covA, covH, all.x=T, all.Y=T)
    cov$diff1  <- scales::label_percent(1,accuracy=0.01,big.mark = "")(((cov$landingsH - cov$landingsA)/ cov$landingsA)*100)

    colnames(cov) <- c('year','country', 'gsa', 'Lands table A', 'Lands table H',
                       '% diff')

    # report results by year and gsa
    gsa  <- unique(cov$gsa)
    ngsa <- length(gsa)

    # for (i in 1:ngsa){
    #     l <- subset(cov, gsa==gsa[i])
    #     print(paste("Landings' weight coverage in", gsa[i], sep=' '))
    #     print(l)
    # }

    return(cov)
}
