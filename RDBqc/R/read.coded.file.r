#' Read encoded data
#' @param file file path of the table to be read
#' @param sep separator of the csv file (es. ";", ",")
#' @param dec decimals separator of the csv file (es. ".", ",")
#' @param verbose boolean. Returns messages if TRUE.
#'
#' @return The function returns the csv auto-selecting the best ecoding to be used. It is possible to set both the value and the decimar separators
#' @export
#' @examples ## when fill = TRUE
#' test1 <- data.frame(a=1:5, b=c("a","b","c","d","e"))
#' tf <- tempfile()
#' write.table(test1, tf, sep=",",row.names=FALSE)
#' read.coded.file(tf,verbose=TRUE)
#' @importFrom readr guess_encoding
#' @importFrom utils read.table

read.coded.file <- function(file, sep=",",dec=".",verbose=FALSE){
    encodings <- guess_encoding(file)$encoding
    encodingS <- c(encodings,"UTF-8")

    for (enc in encodings) {
        tryCatch({
            df <- read.table(file, fileEncoding = enc, sep = sep, dec = dec, header = TRUE)
            if(verbose){
                print(paste("Correct encoding:", enc))
                }
            break
        }, error = function(e) {
            if (verbose){
                print(paste("Error with encoding:", enc))
                }
        })
    }
    return(df)
}
