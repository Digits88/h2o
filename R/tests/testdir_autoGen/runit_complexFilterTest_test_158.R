            ##
            # Author: Autogenerated on 2013-11-27 18:13:59
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            complexFilterTest_test_158 <- function(conn) {
                Log.info("A munge-task R unit test on data <test> testing the functional unit <['!', '>', '&', '==', '&', '<=']> ")
                Log.info("Uploading test")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/chess/chess_2x2x200/R/test.csv"), "rtest.hex")
            Log.info("Performing compound task !( ( hex[,c(\"y\")] > 1.02550256674 ) & ( hex[,c(\"x\")] == 1.41243850997 )) on dataset <test>")
                     filterHex <- hex[!( ( hex[,c("y")] > 1.02550256674 ) & ( hex[,c("x")] == 1.41243850997 )),]
            Log.info("Performing compound task !( ( hex[,c(\"y\")] > 1.98620257929 ) & ( hex[,c(\"y\")] == 1.04592536463 )) on dataset test, and also subsetting columns.")
                     filterHex <- hex[!( ( hex[,c("y")] > 1.98620257929 ) & ( hex[,c("y")] == 1.04592536463 )), c("y")]
                Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[!( ( hex[,c("y")] > 1.98620257929 ) & ( hex[,c("y")] == 1.04592536463 )), c("x","color")]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("compoundFilterTest_ on data test", complexFilterTest_test_158(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
