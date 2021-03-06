            ##
            # Author: Autogenerated on 2013-11-27 18:13:58
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            simpleFilterTest_prostate_89 <- function(conn) {
                Log.info("A munge-task R unit test on data <prostate> testing the functional unit <>=> ")
                Log.info("Uploading prostate")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/logreg/prostate.csv"), "rprostate.hex")
                Log.info("Filtering out rows by >= from dataset prostate and column \"CAPSULE\" using value 0.545234345163")
                     filterHex <- hex[hex[,c("CAPSULE")] >= 0.545234345163,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"CAPSULE" >= 0.545234345163,]
                Log.info("Filtering out rows by >= from dataset prostate and column \"AGE\" using value 49.9196659707")
                     filterHex <- hex[hex[,c("AGE")] >= 49.9196659707,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"AGE" >= 49.9196659707,]
                    Log.info("Filtering out rows by >= from dataset prostate and column \"PSA\" using value 76.4158620447, and also subsetting columns.")
                     filterHex <- hex[hex[,c("PSA")] >= 76.4158620447, c("PSA")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("PSA")] >= 76.4158620447, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by >= from dataset prostate and column \"GLEASON\" using value 7.45756687738, and also subsetting columns.")
                     filterHex <- hex[hex[,c("GLEASON")] >= 7.45756687738, c("GLEASON")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("GLEASON")] >= 7.45756687738, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("simpleFilterTest_ on data prostate", simpleFilterTest_prostate_89(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
