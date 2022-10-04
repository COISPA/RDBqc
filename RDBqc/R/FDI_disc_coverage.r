#' Coverage of FDI discard data
#'
#' @param data data frame of the FDI table A
#' @param MS Country
#' @param verbose boolean. If TRUE a message is printed.
#' @description The functions checks the discard coverage in table A (table 2.2.1) for the selected MS by GSAs
#' @return The function returns a list of data frames by GSA reporting the landing volumes (with discard >0, =0 and =NK and total landing) by year
#' @export
#'
#' @examples FDI_disc_coverage(fdi_a_catch, MS="PSP", verbose=TRUE)
#' @importFrom scales label_percent

FDI_disc_coverage <- function(data, MS, verbose = TRUE){

    country <- NULL

    colnames(data) <- tolower(colnames(data))
    # check if MS is existing
    mslist <- unique(data$country)
    if (MS %in% mslist) {
        if (verbose){
              print(paste("Discard coverage per GSA for", MS, "data", sep=" ") )
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
    # d1 <- which(data1$discards >= 0)
    # d2 <- which(data1$discards == 0)
    # d3 <- which(data1$discards == 'NK'| is.na(data1$discards))

    d3 <- which(data1$discards == 'NK')
    suppressWarnings(d1 <- which(as.numeric(data1$discards) > 0))
    suppressWarnings(d2 <- which(as.numeric(data1$discards) == 0))

    data1$DISCcat     <- rep(NA, nrow(data1))
    data1$DISCcat[d1] <- "1"
    data1$DISCcat[d2] <- "0"
    data1$DISCcat[d3] <- "NK"

    if (class(data1$totwghtlandg)!= "numeric") {
        stop("Unexpected values in 'totwghtlandg' field in table A catch" )
    }

    discov <- aggregate(list(landings=data1$totwghtlandg), by =list(year = data1$year, gsa= data1$sub_region, disccat = data1$DISCcat), FUN=sum, na.rm=T)
    TL     <- aggregate(list(landings=data1$totwghtlandg), by =list(year = data1$year, gsa= data1$sub_region), FUN=sum, na.rm=T)

    gsals <- vector("list", length = length(ngsas))
    i=1
    for(i in 1:length(ngsas)) {
        d        <- discov[which(discov$gsa==ngsas[i]),]
        l        <- TL[which(TL$gsa==ngsas[i]),]
        ind1     <- which(d$disccat==1)
        ind2     <- which(d$disccat==0)
        ind3     <- which(d$disccat=='NK')
        if (length(ind1)!=0 ) {
            l$disc1    <- d$landings[ind1]
            l$disc1per <- scales::label_percent(1,accuracy = 0.01)((d$landings[ind1]/l$landings)*100)
        } else {
            l$disc1    <- rep(0, nrow(l))
            l$disc1per <- scales::label_percent(1)(rep(0, nrow(l)))
        }
        if (length(ind2)!=0 ) {
            l$disc0    <- d$landings[ind2]
            l$disc0per <- scales::label_percent(1,accuracy = 0.01)((d$landings[ind2]/l$landings)*100)
        } else {
            l$disc0    <- rep(0, nrow(l))
            l$disc0per <- scales::label_percent(1,accuracy = 0.01)(rep(0, nrow(l)))
        }
        if (length(ind3)!=0 ) {
            l$discNK    <- d$landings[ind3]
            l$discNKper <- scales::label_percent(1,accuracy = 0.01)((d$landings[ind3]/l$landings)*100)
        } else {
            l$discNK    <- rep(0, nrow(l))
            l$discNKper <- scales::label_percent(1,accuracy = 0.01)(rep(0, nrow(l)))
        }
        colnames(l) <- c('year', 'gsa', 'Total_lands', 'Lands_(disc > 0)',
                         '% Lands_(disc >0)', 'Lands_(disc = 0)',
                         '% Lands_(disc = 0)', 'Lands_(disc = NK)',
                         '% Lands_(disc = NK)')
        if (verbose){
           print(paste("Discard coverage in", ngsas[i], sep=' '))
        }
        # print(l)
        gsals[[i]] <- l
    }

    names(gsals) <- ngsas

    }  else  {
        message(paste('MS ',MS,' not existing in provided data'))
        gsals=NULL
    }


    return(gsals)
}
