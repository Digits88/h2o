            ##
            # Author: Autogenerated on 2013-11-27 18:13:58
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            simpleFilterTest_syn_fp_prostate_35 <- function(conn) {
                Log.info("A munge-task R unit test on data <syn_fp_prostate> testing the functional unit <<> ")
                Log.info("Uploading syn_fp_prostate")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/syn_fp_prostate.csv"), "rsyn_fp_prostate.hex")
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"DPROS\" using value -8.40623871554e+58")
                     filterHex <- hex[hex[,c("DPROS")] < -8.40623871554e+58,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"DPROS" < -8.40623871554e+58,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"VOL\" using value -4.26570480587e+58")
                     filterHex <- hex[hex[,c("VOL")] < -4.26570480587e+58,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"VOL" < -4.26570480587e+58,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"ID\" using value 2.21369506579")
                     filterHex <- hex[hex[,c("ID")] < 2.21369506579,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"ID" < 2.21369506579,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"ID\" using value 1.89225495688")
                     filterHex <- hex[hex[,c("ID")] < 1.89225495688,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"ID" < 1.89225495688,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"CAPSULE\" using value -7.26771279424e+57")
                     filterHex <- hex[hex[,c("CAPSULE")] < -7.26771279424e+57,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"CAPSULE" < -7.26771279424e+57,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"PSA\" using value 3.13998336331e+58")
                     filterHex <- hex[hex[,c("PSA")] < 3.13998336331e+58,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"PSA" < 3.13998336331e+58,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"ID\" using value 0.756638586847")
                     filterHex <- hex[hex[,c("ID")] < 0.756638586847,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"ID" < 0.756638586847,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"PSA\" using value 9.05966309706e+57")
                     filterHex <- hex[hex[,c("PSA")] < 9.05966309706e+57,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"PSA" < 9.05966309706e+57,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"PSA\" using value -6.3548450841e+58")
                     filterHex <- hex[hex[,c("PSA")] < -6.3548450841e+58,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"PSA" < -6.3548450841e+58,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"VOL\" using value 6.66519337013e+58")
                     filterHex <- hex[hex[,c("VOL")] < 6.66519337013e+58,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"VOL" < 6.66519337013e+58,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"GLEASON\" using value 0.128130278031")
                     filterHex <- hex[hex[,c("GLEASON")] < 0.128130278031,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"GLEASON" < 0.128130278031,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"ID\" using value 6.06938825463")
                     filterHex <- hex[hex[,c("ID")] < 6.06938825463,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"ID" < 6.06938825463,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"CAPSULE\" using value 6.30128472593e+58")
                     filterHex <- hex[hex[,c("CAPSULE")] < 6.30128472593e+58,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"CAPSULE" < 6.30128472593e+58,]
                Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"CAPSULE\" using value -5.14837717669e+58")
                     filterHex <- hex[hex[,c("CAPSULE")] < -5.14837717669e+58,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"CAPSULE" < -5.14837717669e+58,]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"VOL\" using value -9.09089642098e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("VOL")] < -9.09089642098e+58, c("VOL")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("VOL")] < -9.09089642098e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"RACE\" using value -4.29361821104e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("RACE")] < -4.29361821104e+58, c("RACE")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("RACE")] < -4.29361821104e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"VOL\" using value 6.13165081905e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("VOL")] < 6.13165081905e+58, c("VOL")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("VOL")] < 6.13165081905e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"RACE\" using value -4.81427960884e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("RACE")] < -4.81427960884e+58, c("RACE")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("RACE")] < -4.81427960884e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"VOL\" using value 1.86520545362e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("VOL")] < 1.86520545362e+58, c("VOL")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("VOL")] < 1.86520545362e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"PSA\" using value -7.94296573001e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("PSA")] < -7.94296573001e+58, c("PSA")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("PSA")] < -7.94296573001e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"DPROS\" using value 4.24589173053e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("DPROS")] < 4.24589173053e+58, c("DPROS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("DPROS")] < 4.24589173053e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"CAPSULE\" using value 4.11146405088e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("CAPSULE")] < 4.11146405088e+58, c("CAPSULE")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("CAPSULE")] < 4.11146405088e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"DCAPS\" using value 6.29582725618e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("DCAPS")] < 6.29582725618e+58, c("DCAPS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("DCAPS")] < 6.29582725618e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"AGE\" using value -7.99559970811e+57, and also subsetting columns.")
                     filterHex <- hex[hex[,c("AGE")] < -7.99559970811e+57, c("AGE")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("AGE")] < -7.99559970811e+57, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"CAPSULE\" using value 4.05043364946e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("CAPSULE")] < 4.05043364946e+58, c("CAPSULE")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("CAPSULE")] < 4.05043364946e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"PSA\" using value -4.13286067396e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("PSA")] < -4.13286067396e+58, c("PSA")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("PSA")] < -4.13286067396e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"RACE\" using value -1.48494835937e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("RACE")] < -1.48494835937e+58, c("RACE")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("RACE")] < -1.48494835937e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by < from dataset syn_fp_prostate and column \"AGE\" using value -7.26573421896e+58, and also subsetting columns.")
                     filterHex <- hex[hex[,c("AGE")] < -7.26573421896e+58, c("AGE")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("AGE")] < -7.26573421896e+58, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("simpleFilterTest_ on data syn_fp_prostate", simpleFilterTest_syn_fp_prostate_35(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
