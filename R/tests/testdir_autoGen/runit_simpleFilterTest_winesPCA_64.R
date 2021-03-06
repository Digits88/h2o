            ##
            # Author: Autogenerated on 2013-11-27 18:13:58
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            simpleFilterTest_winesPCA_64 <- function(conn) {
                Log.info("A munge-task R unit test on data <winesPCA> testing the functional unit <>> ")
                Log.info("Uploading winesPCA")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/winesPCA.csv"), "rwinesPCA.hex")
                Log.info("Filtering out rows by > from dataset winesPCA and column \"0\" using value -2.7334021805")
                     filterHex <- hex[hex[,c(1)] > -2.7334021805,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"0" > -2.7334021805,]
                Log.info("Filtering out rows by > from dataset winesPCA and column \"1\" using value 2.95396050388")
                     filterHex <- hex[hex[,c(1)] > 2.95396050388,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"1" > 2.95396050388,]
                Log.info("Filtering out rows by > from dataset winesPCA and column \"0\" using value -0.0431257057331")
                     filterHex <- hex[hex[,c(1)] > -0.0431257057331,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"0" > -0.0431257057331,]
                    Log.info("Filtering out rows by > from dataset winesPCA and column \"1\" using value -2.18715664406, and also subsetting columns.")
                     filterHex <- hex[hex[,c(1)] > -2.18715664406, c(1)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(1)] > -2.18715664406, c(1)]
                    Log.info("Filtering out rows by > from dataset winesPCA and column \"0\" using value 3.70677777035, and also subsetting columns.")
                     filterHex <- hex[hex[,c(1)] > 3.70677777035, c(1)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(1)] > 3.70677777035, c(1)]
                    Log.info("Filtering out rows by > from dataset winesPCA and column \"0\" using value 2.44263221174, and also subsetting columns.")
                     filterHex <- hex[hex[,c(1)] > 2.44263221174, c(1)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(1)] > 2.44263221174, c(1)]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("simpleFilterTest_ on data winesPCA", simpleFilterTest_winesPCA_64(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
