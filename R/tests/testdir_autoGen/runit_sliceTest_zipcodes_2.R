            ##
            # Author: Autogenerated on 2013-11-27 18:13:58
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            sliceTest_zipcodes_2 <- function(conn) {
                Log.info("A munge-task R unit test on data <zipcodes> testing the functional unit <[> ")
                Log.info("Uploading zipcodes")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/zip_code/zipcodes"), "rzipcodes.hex")
                Log.info("Performing a column slice of zipcodes using these columns: c(1)")
                slicedHex <- hex[,c(1)]
                    Log.info("Performing a row slice of zipcodes using these rows: c(1,3,2)")
                slicedHex <- hex[c(1,3,2),]
                    Log.info("Performing a 1-by-1 column slice of zipcodes using these columns: ")
                    Log.info("Performing a 1-by-1 row slice of zipcodes using these rows: ")
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("sliceTest_ on data zipcodes", sliceTest_zipcodes_2(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
