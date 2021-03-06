            ##
            # Author: Autogenerated on 2013-11-27 18:13:59
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            complexFilterTest_constantColumn_149 <- function(conn) {
                Log.info("A munge-task R unit test on data <constantColumn> testing the functional unit <['', '==']> ")
                Log.info("Uploading constantColumn")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/constantColumn.csv"), "rconstantColumn.hex")
            Log.info("Performing compound task ( ( hex[,c(\"konstant\")] == 0.1 ))  on dataset <constantColumn>")
                     filterHex <- hex[( ( hex[,c("konstant")] == 0.1 )) ,]
            Log.info("Performing compound task ( ( hex[,c(\"konstant\")] == 0.1 ))  on dataset constantColumn, and also subsetting columns.")
                     filterHex <- hex[( ( hex[,c("konstant")] == 0.1 )) , c("konstant")]
                Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[( ( hex[,c("konstant")] == 0.1 )) , c(1)]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("compoundFilterTest_ on data constantColumn", complexFilterTest_constantColumn_149(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
