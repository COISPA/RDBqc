#' Check of species value
#'
#' @param data data frame of FDA table A catch.
#' @param MS country code
#' @param SP vector of the species code for which the check should be performed
#' @param make_plot boolean. If TRUE plots are returned.
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function finds an average price per species and year and compare it to the average price calculated per country.
#' @export
#'
#' @examples FDI_species_price(data=fdi_a_catch, MS="PSP",
#'  SP=c("ARA","BOG","HKE"), make_plot=TRUE, verbose = TRUE)
#'
#'  FDI_species_price(data=fdi_a_catch, MS="PSP",
#'  SP=c("ARS"), make_plot=TRUE, verbose = TRUE)
FDI_species_price <- function(data, MS, SP=NA, make_plot=F, verbose = FALSE){

    country <- price <- year <- NULL

    colnames(data) <- tolower(colnames(data))

    # check if MS is existing
    mslist <- unique(data$country)
    if (MS %in% mslist) {
        print(paste("Average price per species in", MS, sep=" ") )


    # subset for MS
    data1    <- subset(data, country == MS)

    if (any(SP %in% unique(data1$species))) {
    if (length(SP) == 1) {
        if (is.na(SP)){
          SP <- unique(data1$species)
        }
    }

    data1    <- subset(data1, species %in% SP)
    data1$id <- seq(1,nrow(data1), 1)

    species <- unique(data1$species)
    yrs     <- unique(data1$year)
    nsp     <- length(species)

    # check there are years reported
    if (is.null(yrs)) {stop('No YEARS existing')}

    # check for NAs in years reported
    yrs  <- data1$year
    na2  <- which(is.na(yrs))

    if (verbose) {
        if (length(na2)!=0) {message(paste('Found NAs in Years in', length(na2), 'rows' )) }
    }


    # converting totvallandg in numeric field
    data1[data1$totvallandg =="NK" & !is.na(data1$totvallandg), "totvallandg"] <- NA
    data1$totvallandg <- as.numeric(data1$totvallandg)


    # compute average price per species and year
    WT <- aggregate(list(wt=data1$totwghtlandg), by =list(year = data1$year, species= data1$species), FUN=sum, na.rm=T)
    LV <- aggregate(list(lv=data1$totvallandg), by =list(year = data1$year, species= data1$species), FUN=sum, na.rm=T)

    l       <- merge(WT, LV, all.x=T, all.Y=T)
    l$price <- l$lv/(l$wt*1000)

    l[is.infinite(l$price),"price"] <- NA

    # cases for which totalweightlandings >0 while landingsvalue=0
    ind      <- which(l$wt > 0 & l$lv ==0)
    if (length(ind)>0){
        l1       <- l[ind,]
        l1$price <- NA
        sp1      <- unique(l1$species)
        l[ind,]$price <- NA     # set NA to prices in this cases (otherwise price is estimated to zero)
    }

    # compute average price per species across all years to append to tables l and l1
    av_price <- aggregate(list(av_price=l$price), by =list(species= l$species), FUN=mean, na.rm=T)
    l2       <- merge(l, av_price, all.x=T, all.Y=T)
    l2$av_price[which(is.nan(l2$av_price))] <- NA   # change NaN to NA
    l1      <- l2[which(is.na(l2$price)), ]

    colnames(l1) <- c('species', 'year', 'land weight', 'land value', 'price', 'av_price')
    colnames(l2) <- c('species', 'year', 'land weight', 'land value', 'price', 'av_price')

    if(length(ind)!=0){
        if (verbose) {
        message(paste('Found',length(ind),
                    'cases with total landings > 0 but landings value = 0, for', length(sp1), 'species, see output tables',
                    sep=" "))
            }
        #print(l1)
    } else {
        if (verbose) {
            message('No cases with total landings > 0 but landings value = 0')
        }
    }

    # plot of price per species and year
    if (make_plot==T){
        p <- ggplot(l, aes(x=year, y=price))+
            geom_point(color="steelblue") +
            geom_line(color="steelblue") +
            labs(title = "Price per species and year",
                 y = "price (euros per ton)", x = "year")+
            facet_wrap(~ species)
        print(p)
    }

    } else {
        if(verbose){message(paste('Species ',paste(SP,collapse=", "),' not existing in provided data'))}
        l1 <- NULL
        l2 <- NULL
    }
    } else {
        if(verbose){message(paste('MS ',MS,'not existing in provided data'))}
        l1 <- NULL
        l2 <- NULL
    }

    return(list(price_per_species = l2, cases_with_zero_land_value=l1))
}
