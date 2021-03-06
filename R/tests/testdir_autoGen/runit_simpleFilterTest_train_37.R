            ##
            # Author: Autogenerated on 2013-11-27 18:13:58
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            simpleFilterTest_train_37 <- function(conn) {
                Log.info("A munge-task R unit test on data <train> testing the functional unit <<> ")
                Log.info("Uploading train")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/chess/chess_2x2x100/R/train.csv"), "rtrain.hex")
                Log.info("Filtering out rows by < from dataset train and column \"y\" using value 0.341827352356")
                     filterHex <- hex[hex[,c("y")] < 0.341827352356,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"y" < 0.341827352356,]
                Log.info("Filtering out rows by < from dataset train and column \"y\" using value 0.211347295914")
                     filterHex <- hex[hex[,c("y")] < 0.211347295914,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"y" < 0.211347295914,]
                Log.info("Filtering out rows by < from dataset train and column \"x\" using value 1.09841325617")
                     filterHex <- hex[hex[,c("x")] < 1.09841325617,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"x" < 1.09841325617,]
                    Log.info("Filtering out rows by < from dataset train and column \"y\" using value 1.51075602452, and also subsetting columns.")
                     filterHex <- hex[hex[,c("y")] < 1.51075602452, c("y")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("y")] < 1.51075602452, c("color","x","y")]
                    Log.info("Filtering out rows by < from dataset train and column \"x\" using value 1.63724272367, and also subsetting columns.")
                     filterHex <- hex[hex[,c("x")] < 1.63724272367, c("x")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("x")] < 1.63724272367, c("color","x","y")]
                    Log.info("Filtering out rows by < from dataset train and column \"y\" using value 0.916354284865, and also subsetting columns.")
                     filterHex <- hex[hex[,c("y")] < 0.916354284865, c("y")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("y")] < 0.916354284865, c("color","x","y")]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("simpleFilterTest_ on data train", simpleFilterTest_train_37(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
