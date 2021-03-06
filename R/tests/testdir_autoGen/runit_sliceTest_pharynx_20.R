            ##
            # Author: Autogenerated on 2013-11-27 18:13:58
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            sliceTest_pharynx_20 <- function(conn) {
                Log.info("A munge-task R unit test on data <pharynx> testing the functional unit <[> ")
                Log.info("Uploading pharynx")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/logreg/umass_statdata/pharynx.dat"), "rpharynx.hex")
                    Log.info("Performing a 1-by-1 column slice of pharynx using these columns: ")
                    Log.info("Performing a 1-by-1 row slice of pharynx using these rows: ")
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("sliceTest_ on data pharynx", sliceTest_pharynx_20(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
