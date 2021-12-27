
#' Check trip location
#' @param data_example detailed data in RCG CS format
#' @return map of trip locations
#' @export
#' @examples check_loc(data_ex)
#' @importFrom graphics par points text
#' @importFrom utils globalVariables
#' @import rworldmap
#' @import rworldxtra
#' @import sp
#' @description If Initial and/or Final coordinates are included in the data, maps of them are produced. If not the locations of the harbours are mapped.
check_loc<-function(data_example){
    oldoptions <- options()$warn
        coordinates <-  NULL
    # loads world map shape
    world <- getMap(resolution = "high")

    # example points data frame
    DF=as.data.frame(cbind(data_example$Flag_country,data_example$Trip_code,data_example$Harbour,data_example$Initial_latitude,data_example$Initial_longitude))
    #points <- data.frame(matrix(ncol=5, nrow=3))
    colnames(DF) <- c("ISO3","Code","Name","Latitude","Longitude")
   if(any(!is.na(DF$Latitude))){
       labels <- DF
       # definition of the map extension
       range <- min(DF$Longitude)
       range[2] <- max(DF$Longitude)
       range[3] <- min(DF$Latitude)
       range[4] <- max(DF$Latitude)
       coordinates(DF) <- ~ Longitude + Latitude

       # definition of a buffer area arount the map extension
       dlon <- (range[2]-range[1])*0.1
       dlat <- (range[4]-range[3])*0.1

       # store the par values to be used in the onexit function
       old_par <- list()
       old_par$mar <-par()$mar
       old_par$fin <-par()$fin

       # onexit declaration
       on.exit(c(par(mar=old_par$mar,fin=old_par$fin),options(warn=oldoptions)))
       options(warn=-1)

       # par parameters
       par(new=TRUE, mar=c(4, 5, 4, 2))

       # empty plot with the map extension
       plot(1,1,type="n",xlim=c(range[1]-dlon,range[2]+dlon), ylim=c(range[3]-dlat,range[4]+dlat) ,
            xlab=expression(paste("Longitude (",degree,"E)")),
            ylab=expression(paste("Latitude (",degree,"N)")),
            asp=1)

       # plot the world shape in the map extension
       plot(world, border="grey", col="light grey", add=TRUE)
       plot(DF, col="red", add=TRUE,pch=16,cex=1.4)
       text(x=labels$Longitude,
            y=labels$Latitude,
            labels=labels$Name,
            pos=4)

   }    # coordinate

    DF=as.data.frame(cbind(data_example$Flag_country,data_example$Trip_code,data_example$Harbour,data_example$Final_latitude,data_example$Final_longitude))
    #points <- data.frame(matrix(ncol=5, nrow=3))
    colnames(DF) <- c("ISO3","Code","Name","Latitude","Longitude")
    if(any(!is.na(DF$Latitude))){
        labels <- DF
        # definition of the map extension
        range <- min(DF$Longitude)
        range[2] <- max(DF$Longitude)
        range[3] <- min(DF$Latitude)
        range[4] <- max(DF$Latitude)
        coordinates(DF) <- ~ Longitude + Latitude

        # definition of a buffer area arount the map extension
        dlon <- (range[2]-range[1])*0.1
        dlat <- (range[4]-range[3])*0.1

        # store the par values to be used in the onexit function
        old_par <- list()
        old_par$mar <-par()$mar
        old_par$fin <-par()$fin

        # onexit declaration
        on.exit(c(par(mar=old_par$mar,fin=old_par$fin),options(warn=oldoptions)))
        options(warn=-1)

        # par parameters
        par(new=TRUE, mar=c(4, 5, 4, 2))

        # empty plot with the map extension
        plot(1,1,type="n",xlim=c(range[1]-dlon,range[2]+dlon), ylim=c(range[3]-dlat,range[4]+dlat) ,
             xlab=expression(paste("Longitude (",degree,"E)")),
             ylab=expression(paste("Latitude (",degree,"N)")),
             asp=1)

        # plot the world shape in the map extension
        plot(world, border="grey", col="light grey", add=TRUE)
        plot(DF, col="red", add=TRUE,pch=16,cex=1.4)
        text(x=labels$Longitude,
             y=labels$Latitude,
             labels=labels$Name,
             pos=4)

    }

DF2=base::merge(as.data.frame(circabc),data_example,by.x="Code",by.y="Harbour")
DF=as.data.frame(cbind(DF2$ISO3,DF2$Code,DF2$Name,DF2$Latitude,DF2$Longitude))
    #points <- data.frame(matrix(ncol=5, nrow=3))
    colnames(DF) <- c("ISO3","Code","Name","Latitude","Longitude")
    DF$Latitude=as.numeric(DF$Latitude)
    DF$Longitude=as.numeric(DF$Longitude)
    if(any(!is.na(DF$Latitude))){
        labels <- DF
        # definition of the map extension
        range <- min(DF$Longitude)
        range[2] <- max(DF$Longitude)
        range[3] <- min(DF$Latitude)
        range[4] <- max(DF$Latitude)
        coordinates(DF) <- ~ Longitude + Latitude

        # definition of a buffer area arount the map extension
        dlon <- (range[2]-range[1])*0.1
        dlat <- (range[4]-range[3])*0.1

        # store the par values to be used in the onexit function
        old_par <- list()
        old_par$mar <-par()$mar
        old_par$fin <-par()$fin

        # onexit declaration
        on.exit(c(par(mar=old_par$mar,fin=old_par$fin),options(warn=oldoptions)))
        options(warn=-1)

        # par parameters
        par(new=TRUE, mar=c(4, 5, 4, 2))

        # empty plot with the map extension
        plot(1,1,type="n",xlim=c(range[1]-dlon,range[2]+dlon), ylim=c(range[3]-dlat,range[4]+dlat) ,
             xlab=expression(paste("Longitude (",degree,"E)")),
             ylab=expression(paste("Latitude (",degree,"N)")),
             asp=1)

        # plot the world shape in the map extension
        plot(world, border="grey", col="light grey", add=TRUE)
        plot(DF, col="red", add=TRUE,pch=16,cex=1.4)
        text(x=labels$Longitude,
             y=labels$Latitude,
             labels=labels$Name,
             pos=4)

    }
}
