            ##
            # Author: Autogenerated on 2013-11-27 18:13:58
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            simpleFilterTest_parse_fail_double_space_25 <- function(conn) {
                Log.info("A munge-task R unit test on data <parse_fail_double_space> testing the functional unit <<> ")
                Log.info("Uploading parse_fail_double_space")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/parse_fail_double_space.csv"), "rparse_fail_double_space.hex")
                Log.info("Filtering out rows by < from dataset parse_fail_double_space and column \"FirstName\" using value -1.28189814854e+101")
                     filterHex <- hex[hex[,c("FirstName")] < -1.28189814854e+101,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"FirstName" < -1.28189814854e+101,]
                Log.info("Filtering out rows by < from dataset parse_fail_double_space and column \"FirstName\" using value 3.12969456017e+101")
                     filterHex <- hex[hex[,c("FirstName")] < 3.12969456017e+101,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"FirstName" < 3.12969456017e+101,]
                    Log.info("Filtering out rows by < from dataset parse_fail_double_space and column \"DateofBirth\" using value 0.4576766672, and also subsetting columns.")
                     filterHex <- hex[hex[,c("DateofBirth")] < 0.4576766672, c("DateofBirth")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("DateofBirth")] < 0.4576766672, c("LastName","MiddleInitials","FirstName","DateofBirth")]
                    Log.info("Filtering out rows by < from dataset parse_fail_double_space and column \"FirstName\" using value 5.0864519907e+101, and also subsetting columns.")
                     filterHex <- hex[hex[,c("FirstName")] < 5.0864519907e+101, c("FirstName")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("FirstName")] < 5.0864519907e+101, c("LastName","MiddleInitials","FirstName","DateofBirth")]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("simpleFilterTest_ on data parse_fail_double_space", simpleFilterTest_parse_fail_double_space_25(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
