            ##
            # Author: Autogenerated on 2013-11-27 18:13:58
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            simpleFilterTest_test_78 <- function(conn) {
                Log.info("A munge-task R unit test on data <test> testing the functional unit <>> ")
                Log.info("Uploading test")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/chess/chess_2x2x500/weka/test.csv.arff"), "rtest.hex")
                Log.info("Filtering out rows by > from dataset test and column \"0\" using value 1.4460295314")
                     filterHex <- hex[hex[,c(1)] > 1.4460295314,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"0" > 1.4460295314,]
                Log.info("Filtering out rows by > from dataset test and column \"0\" using value 0.913360557095")
                     filterHex <- hex[hex[,c(1)] > 0.913360557095,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"0" > 0.913360557095,]
                Log.info("Filtering out rows by > from dataset test and column \"0\" using value 1.98456753332")
                     filterHex <- hex[hex[,c(1)] > 1.98456753332,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"0" > 1.98456753332,]
                Log.info("Filtering out rows by > from dataset test and column \"0\" using value 0.323301119508")
                     filterHex <- hex[hex[,c(1)] > 0.323301119508,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"0" > 0.323301119508,]
                    Log.info("Filtering out rows by > from dataset test and column \"0\" using value 1.38393720379, and also subsetting columns.")
                     filterHex <- hex[hex[,c(1)] > 1.38393720379, c(1)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(1)] > 1.38393720379, c(1,2)]
                    Log.info("Filtering out rows by > from dataset test and column \"1\" using value 1.65993924895, and also subsetting columns.")
                     filterHex <- hex[hex[,c(1)] > 1.65993924895, c(1)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(1)] > 1.65993924895, c(1,2)]
                    Log.info("Filtering out rows by > from dataset test and column \"1\" using value 1.95956718488, and also subsetting columns.")
                     filterHex <- hex[hex[,c(1)] > 1.95956718488, c(1)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(1)] > 1.95956718488, c(1,2)]
                    Log.info("Filtering out rows by > from dataset test and column \"1\" using value 0.865882891691, and also subsetting columns.")
                     filterHex <- hex[hex[,c(1)] > 0.865882891691, c(1)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(1)] > 0.865882891691, c(1,2)]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("simpleFilterTest_ on data test", simpleFilterTest_test_78(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
