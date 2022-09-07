#' Coverage of FDI discard data
#'
#' @param data data frame of the FDI table A
#' @param MS Country
#' @param verbose boolean. If TRUE a message is printed.
#' @description The functions checks the discard coverage in table A (table 2.2.1) for the selected MS by GSAs
#' @return The function returns a data frame reporting the landing volumes (with discard >0, =0 and =NK and total landing) by GSA and year
#' @export
#'
#' @examples FDI_disc_coverage(fdi_a_catch, MS="PSP", verbose=TRUE)
#' @importFrom scales label_percent

FDI_disc_coverage <- function(data, MS, verbose = TRUE){

    country <- NULL

    # check if MS is existing
    mslist <- unique(data$country)
    if (MS %in% mslist) {
        if(verbose) {
            message(paste("Discard coverage per GSA for", MS, "data", sep=" ") )
        }
    }else{
        stop('MS not existing in provided data')
    }

    # subset for MS
    data1    <- subset(data, country == MS)
    #data1$id <- seq(1,nrow(data1), 1)

    ngsas <- unique(data1$sub_region)
    nyrs  <- unique(data1$year)

    # check there are gsas and years reported
    if (is.null(ngsas)) {stop('No SUB_REGIONS existing')}
    if (is.null(nyrs)) {stop('No YEARS existing')}

    # check for NAs in gsas or years reported

    gsas <- data1$sub_region
    yrs  <- data1$year

    na1 <- which(is.na(gsas))
    na2 <- which(is.na(yrs))

    if (verbose) {
        if (length(na1)!=0) {message(paste('Found NAs in SUB_REGIONS in', length(na1), 'rows' )) }
        if (length(na2)!=0) {message(paste('Found NAs in Years in', length(na2), 'rows' )) }
    }

    # Discard coverage by GSA and year. Split discards in categories ">0", "0", "NK"
    d3 <- which(data1$discards == 'NK')
    suppressWarnings(d1 <- which(as.numeric(data1$discards) > 0))
    suppressWarnings(d2 <- which(as.numeric(data1$discards) == 0))

    data1$DISCcat     <- rep(NA, nrow(data1))
    data1$DISCcat[d1] <- 1
    data1$DISCcat[d2] <- 0
    data1$DISCcat[d3] <- 'NK'

    data1[is.na(data1$totwghtlandg),"totwghtlandg"] <- "0"
    data1[data1$totwghtlandg=="NA","totwghtlandg"]<-"0"
    data1[data1$totwghtlandg=="NK","totwghtlandg"]<-"0"

    data1$totwghtlandg <- as.numeric(data1$totwghtlandg)


    discov <- aggregate(list(landings=data1$totwghtlandg), by =list(year = data1$year, gsa= data1$sub_region, disccat = data1$DISCcat), FUN=sum)
    TL     <- aggregate(list(landings=data1$totwghtlandg), by =list(year = data1$year, gsa= data1$sub_region), FUN=sum)

    #gsals <- vector("list", length = length(ngsas))
    for(i in 1:length(ngsas)) {
        #gsals[[i]] <- discov[which(discov$gsa==ngsas[i]),]
        d        <- discov[which(discov$gsa==ngsas[i]),]
        l        <- TL[which(TL$gsa==ngsas[i]),]
        if (length(d1)!=0 ) {
            l$disc1    <- d$landings[which(d$disccat==1)]
            l$disc1per <- label_percent(1)(d$landings[which(d$disccat==1)]/l$landings)
        } else {
            l$disc1    <- rep(0, nrow(l))
            l$disc1per <- label_percent(1)(rep(0, nrow(l)))
        }
        if (length(d2)!=0 ) {
            l$disc0    <- d$landings[which(d$disccat==0)]
            l$disc0per <- label_percent(1)(d$landings[which(d$disccat==0)]/l$landings)
        } else {
            l$disc0    <- rep(0, nrow(l))
            l$disc0per <- label_percent(1)(rep(0, nrow(l)))
    }
    if (length(d3)!=0 ) {
      l$discNK    <- d$landings[which(d$disccat=='NK')]
      l$discNKper <- label_percent(1)(d$landings[which(d$disccat=='NK')]/l$landings)
    } else {
      l$discNK    <- rep(0, nrow(l))
      l$discNKper <- label_percent(1)(rep(0, nrow(l)))
    }
    colnames(l) <- c('year', 'gsa', 'Total _lands', 'Lands_(disc>0)',
                     '%Lands_(disc>0)', 'Lands_(disc=0)',
                     '%Lands_(disc=0)', 'Lands_(disc=NK)',
                     '%Lands_(disc=NK)')
    if(verbose) {message(paste("Discard coverage in", ngsas[i], sep=' '))}

  }

  return(l)
}
