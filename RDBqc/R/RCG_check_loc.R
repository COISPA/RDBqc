#' Check trip location
#' @param data detailed data in RCG CS format
#' @param ports ports codification file
#' @description The function allows to check the spatial distribution of data using the initial and final coordinates, where available, and the ports position included in the data in case coordinates are not available.
#' @return A map of trip locations is generated.
#' @export RCG_check_loc
#' @examples RCG_check_loc(data_ex)
#' @importFrom graphics par points text
#' @importFrom utils globalVariables
#' @import rworldmap
#' @import rworldxtra
#' @import sp

RCG_check_loc <- function(data, ports = circabc) {
  if (FALSE) {
    data <- data_ex
    data$Initial_latitude[1] <- 41.4
    data$Initial_longitude[1] <- 17
    data$Final_latitude[1] <- 41.5
    data$Final_longitude[1] <- 17.1
  }

  oldoptions <- options()$warn
  coordinates <- NULL
  # loads world map shape
  world <- getMap(resolution = "high")

  lat.start.na <- data[is.na(data$Initial_latitude), ]
  lon.start.na <- data[is.na(data$Initial_longitude), ]
  lat.end.na <- data[is.na(data$Final_latitude), ]
  lon.end.na <- data[is.na(data$Final_longitude), ]

  df_coord <- data[!(is.na(data$Initial_latitude)) & !(is.na(data$Initial_longitude)), ]

  # if (nrow(data)>0) {
  #
  # }

  # initial coordinates
  DF1 <- as.data.frame(cbind(data$Flag_country, data$Trip_code, data$Harbour, data$Initial_latitude, data$Initial_longitude))
  colnames(DF1) <- c("ISO3", "Code", "Name", "Latitude", "Longitude")
  DF1$Latitude <- as.numeric(DF1$Latitude)
  DF1$Longitude <- as.numeric(DF1$Longitude)
  DF1 <- DF1[!is.na(DF1$Latitude) & !is.na(DF1$Longitude), ]
  if (nrow(DF1) > 0) {
    DF1$Legend <- "initial position"
    DF1 <- DF1[!duplicated(DF1), ]
  }

  # final coordinates
  DF2 <- as.data.frame(cbind(data$Flag_country, data$Trip_code, data$Harbour, data$Final_latitude, data$Final_longitude))
  colnames(DF2) <- c("ISO3", "Code", "Name", "Latitude", "Longitude")
  DF2$Latitude <- as.numeric(DF2$Latitude)
  DF2$Longitude <- as.numeric(DF2$Longitude)
  DF2 <- DF2[!is.na(DF2$Latitude) & !is.na(DF2$Longitude), ]
  if (nrow(DF2) > 0) {
    DF2$Legend <- "final position"
    DF2 <- DF2[!duplicated(DF2), ]
  }
  # ports coordinates
  DF_ports <- base::merge(as.data.frame(ports), data, by.x = "Code", by.y = "Harbour")
  DF3 <- as.data.frame(cbind(DF_ports$ISO3, DF_ports$Code, DF_ports$Name, DF_ports$Latitude, DF_ports$Longitude))
  colnames(DF3) <- c("ISO3", "Code", "Name", "Latitude", "Longitude")
  DF3$Latitude <- as.numeric(DF3$Latitude)
  DF3$Longitude <- as.numeric(DF3$Longitude)
  DF3 <- DF3[!is.na(DF3$Latitude) & !is.na(DF3$Longitude), ]
  if (nrow(DF3) > 0) {
    DF3$Legend <- "ports"
    DF3 <- DF3[!duplicated(DF3), ]
  }
  DF <- rbind(DF1, DF2, DF3)


  if (any(!is.na(DF$Latitude) & !is.na(DF$Longitude))) {
    DF <- DF[!is.na(DF$Latitude) & !is.na(DF$Longitude), ]
    DF$Latitude <- as.numeric(DF$Latitude)
    DF$Longitude <- as.numeric(DF$Longitude)
    labels <- DF[DF$Legend == "ports", ]
    DF <- DF[!duplicated(DF), ]
    # definition of the map extension
    range <- min(DF$Longitude)
    range[2] <- max(DF$Longitude)
    range[3] <- min(DF$Latitude)
    range[4] <- max(DF$Latitude)
    coordinates(DF) <- ~ Longitude + Latitude

    # definition of a buffer area arount the map extension
    dlon <- (range[2] - range[1]) * 0.1
    dlat <- (range[4] - range[3]) * 0.1

    # store the par values to be used in the onexit function
    old_par <- list()
    old_par$mar <- par()$mar
    old_par$fin <- par()$fin

    # onexit declaration
    on.exit(c(par(mar = old_par$mar, fin = old_par$fin), options(warn = oldoptions)))
    options(warn = -1)

    # par parameters
    par(mar = c(4, 5, 4, 2))

    # empty plot with the map extension
    plot(1, 1,
      type = "n", xlim = c(range[1] - dlon, range[2] + dlon), ylim = c(range[3] - dlat, range[4] + dlat),
      xlab = expression(paste("Longitude (", degree, "E)")),
      ylab = expression(paste("Latitude (", degree, "N)")),
      asp = 1 / cos(45 * pi / 180)
    )

    # plot the world shape in the map extension
    plot(world, border = "grey", col = "light grey", add = TRUE)
    if (nrow(DF1) > 0) {
      coordinates(DF1) <- ~ Longitude + Latitude
      plot(DF1, col = "green", add = TRUE, pch = 16, cex = 0.8)
    }
    if (nrow(DF2) > 0) {
      coordinates(DF2) <- ~ Longitude + Latitude
      plot(DF2, col = "red", add = TRUE, pch = 16, cex = 0.8)
    }
    if (nrow(DF3) > 0) {
      coordinates(DF3) <- ~ Longitude + Latitude
      plot(DF3, col = "blue", add = TRUE, pch = 16, cex = 1.1)
    }

    text(
      x = labels$Longitude,
      y = labels$Latitude,
      labels = labels$Name,
      cex = 0.8,
      pos = 4
    )

    legend("topright", c("initial positions", "final positions", "ports"), col = c("green", "red", "blue"), pch = 16, cex = 1)
  } # coordinate
}
