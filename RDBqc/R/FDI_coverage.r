#' Coverage of data by table
#'
#' @param data data frame. One of the allowed FDI table among A, G, H, I, J
#' @param MS Country
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return the function returns a data frame reporting the coverage of the selected table in terms of number of records by country, GSA and year
#' @export
#'
#' @examples FDI_coverage(data=fdi_h_spatial_landings,MS="ITA", verbose = FALSE)


FDI_coverage <- function(data, MS, verbose = TRUE){

    country <- NULL

    # check if MS is existing
    mslist <- unique(data$country)
    if (MS %in% mslist) {
        if(verbose){
             print(paste("Coverage of", MS, "data", sep=" ") )
        }

        # subset for MS
        data1    <- subset(data, country == MS)
        data1$id <- seq(1,nrow(data1), 1)

        gsas <- unique(data1$sub_region)
        yrs  <- unique(data1$year)

        # check there are gsas and years reported
        if (!is.null(gsas)){
            if (!is.null(yrs)){
                # check for NAs in gsas or years reported

                gsas <- data1$sub_region
                yrs  <- data1$year

                na1 <- which(is.na(gsas))
                na2 <- which(is.na(yrs))

                if (verbose) {
                    if (length(na1)!=0) {message(paste('Found NAs in SUB_REGIONS in', length(na1), 'rows' )) }
                    if (length(na2)!=0) {message(paste('Found NAs in Years in', length(na2), 'rows' )) }
                }
                # coverage by GSA and year
                cov <- aggregate(list(records=data1$id), by =list(year = data1$year, gsa= data1$sub_region, country=data1$country), FUN=length)
            } else {
                if(verbose){
                  message('No YEARS existing')
                }
                cov=NULL
                }

        } else {
            if(verbose){
                message('No SUB_REGIONS existing')
            }
            cov=NULL
        }

    }else{
        message('MS not existing in provided data')
        cov=NULL
    }



    return(cov)
}
