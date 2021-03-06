            ##
            # Author: Autogenerated on 2013-11-27 18:13:59
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            complexFilterTest_test_174 <- function(conn) {
                Log.info("A munge-task R unit test on data <test> testing the functional unit <['!', '>', '&', '==', '&', '<=']> ")
                Log.info("Uploading test")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/chess/chess_2x2x500/h2o/test.csv"), "rtest.hex")
            Log.info("Performing compound task !( ( hex[,c(\"y\")] > 0.688748448866 ) & ( hex[,c(\"y\")] == 1.28815359404 ) & ( ( hex[,c(\"x\")] <= 1.57856116456 )) ) on dataset <test>")
                     filterHex <- hex[!( ( hex[,c("y")] > 0.688748448866 ) & ( hex[,c("y")] == 1.28815359404 ) & ( ( hex[,c("x")] <= 1.57856116456 )) ),]
            Log.info("Performing compound task !( ( hex[,c(\"y\")] > 1.8172030488 ) & ( hex[,c(\"x\")] == 0.578832013936 ) & ( ( hex[,c(\"x\")] <= 1.83434103414 )) ) on dataset test, and also subsetting columns.")
                     filterHex <- hex[!( ( hex[,c("y")] > 1.8172030488 ) & ( hex[,c("x")] == 0.578832013936 ) & ( ( hex[,c("x")] <= 1.83434103414 )) ), c("x","y")]
                Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[!( ( hex[,c("y")] > 1.8172030488 ) & ( hex[,c("x")] == 0.578832013936 ) & ( ( hex[,c("x")] <= 1.83434103414 )) ), c("color")]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("compoundFilterTest_ on data test", complexFilterTest_test_174(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
