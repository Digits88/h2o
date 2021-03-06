            ##
            # Author: Autogenerated on 2013-11-27 18:13:58
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            simpleFilterTest_zero_dot_zero_zero_one_43 <- function(conn) {
                Log.info("A munge-task R unit test on data <zero_dot_zero_zero_one> testing the functional unit <<=> ")
                Log.info("Uploading zero_dot_zero_zero_one")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/zero_dot_zero_zero_one.csv"), "rzero_dot_zero_zero_one.hex")
                Log.info("Filtering out rows by <= from dataset zero_dot_zero_zero_one and column \"2\" using value -0.0001")
                     filterHex <- hex[hex[,c(2)] <= -0.0001,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"2" <= -0.0001,]
                    Log.info("Filtering out rows by <= from dataset zero_dot_zero_zero_one and column \"0\" using value 0.0001, and also subsetting columns.")
                     filterHex <- hex[hex[,c(1)] <= 0.0001, c(1)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(1)] <= 0.0001, c(1,2)]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("simpleFilterTest_ on data zero_dot_zero_zero_one", simpleFilterTest_zero_dot_zero_zero_one_43(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
