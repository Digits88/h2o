            ##
            # Author: Autogenerated on 2013-11-27 18:13:59
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            simpleFilterTest_prostate_cat_replaced_102 <- function(conn) {
                Log.info("A munge-task R unit test on data <prostate_cat_replaced> testing the functional unit <==> ")
                Log.info("Uploading prostate_cat_replaced")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/glm_test/prostate_cat_replaced.csv"), "rprostate_cat_replaced.hex")
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"ID\" using value 261.147878863")
                     filterHex <- hex[hex[,c("ID")] == 261.147878863,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"ID" == 261.147878863,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"CAPSULE\" using value 0.254712710935")
                     filterHex <- hex[hex[,c("CAPSULE")] == 0.254712710935,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"CAPSULE" == 0.254712710935,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"VOL\" using value 84.7535282423")
                     filterHex <- hex[hex[,c("VOL")] == 84.7535282423,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"VOL" == 84.7535282423,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"PSA\" using value 26.7034922816")
                     filterHex <- hex[hex[,c("PSA")] == 26.7034922816,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"PSA" == 26.7034922816,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"DPROS\" using value 2.33836044223")
                     filterHex <- hex[hex[,c("DPROS")] == 2.33836044223,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"DPROS" == 2.33836044223,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"GLEASON\" using value 4.20704737587")
                     filterHex <- hex[hex[,c("GLEASON")] == 4.20704737587,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"GLEASON" == 4.20704737587,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"PSA\" using value 94.0342660444")
                     filterHex <- hex[hex[,c("PSA")] == 94.0342660444,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"PSA" == 94.0342660444,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"AGE\" using value 51.353856299")
                     filterHex <- hex[hex[,c("AGE")] == 51.353856299,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"AGE" == 51.353856299,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"CAPSULE\" using value 0.956332661871")
                     filterHex <- hex[hex[,c("CAPSULE")] == 0.956332661871,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"CAPSULE" == 0.956332661871,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"CAPSULE\" using value 0.30309932759")
                     filterHex <- hex[hex[,c("CAPSULE")] == 0.30309932759,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"CAPSULE" == 0.30309932759,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"VOL\" using value 13.7626027969")
                     filterHex <- hex[hex[,c("VOL")] == 13.7626027969,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"VOL" == 13.7626027969,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"DCAPS\" using value 1.47901440625")
                     filterHex <- hex[hex[,c("DCAPS")] == 1.47901440625,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"DCAPS" == 1.47901440625,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"AGE\" using value 67.0162092431")
                     filterHex <- hex[hex[,c("AGE")] == 67.0162092431,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"AGE" == 67.0162092431,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"VOL\" using value 0.0227251918197")
                     filterHex <- hex[hex[,c("VOL")] == 0.0227251918197,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"VOL" == 0.0227251918197,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"DCAPS\" using value 1.65421599136")
                     filterHex <- hex[hex[,c("DCAPS")] == 1.65421599136,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"DCAPS" == 1.65421599136,]
                Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"AGE\" using value 72.8436663077")
                     filterHex <- hex[hex[,c("AGE")] == 72.8436663077,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"AGE" == 72.8436663077,]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"DPROS\" using value 1.41226399453, and also subsetting columns.")
                     filterHex <- hex[hex[,c("DPROS")] == 1.41226399453, c("DPROS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("DPROS")] == 1.41226399453, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"CAPSULE\" using value 0.557323499254, and also subsetting columns.")
                     filterHex <- hex[hex[,c("CAPSULE")] == 0.557323499254, c("CAPSULE")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("CAPSULE")] == 0.557323499254, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"DCAPS\" using value 1.50719649091, and also subsetting columns.")
                     filterHex <- hex[hex[,c("DCAPS")] == 1.50719649091, c("DCAPS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("DCAPS")] == 1.50719649091, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"DCAPS\" using value 1.08030350392, and also subsetting columns.")
                     filterHex <- hex[hex[,c("DCAPS")] == 1.08030350392, c("DCAPS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("DCAPS")] == 1.08030350392, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"DCAPS\" using value 1.8305019248, and also subsetting columns.")
                     filterHex <- hex[hex[,c("DCAPS")] == 1.8305019248, c("DCAPS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("DCAPS")] == 1.8305019248, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"DPROS\" using value 1.31451077778, and also subsetting columns.")
                     filterHex <- hex[hex[,c("DPROS")] == 1.31451077778, c("DPROS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("DPROS")] == 1.31451077778, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"DCAPS\" using value 1.27353614441, and also subsetting columns.")
                     filterHex <- hex[hex[,c("DCAPS")] == 1.27353614441, c("DCAPS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("DCAPS")] == 1.27353614441, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"PSA\" using value 30.5901771302, and also subsetting columns.")
                     filterHex <- hex[hex[,c("PSA")] == 30.5901771302, c("PSA")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("PSA")] == 30.5901771302, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"AGE\" using value 55.06130438, and also subsetting columns.")
                     filterHex <- hex[hex[,c("AGE")] == 55.06130438, c("AGE")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("AGE")] == 55.06130438, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"GLEASON\" using value 2.81304001394, and also subsetting columns.")
                     filterHex <- hex[hex[,c("GLEASON")] == 2.81304001394, c("GLEASON")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("GLEASON")] == 2.81304001394, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"DPROS\" using value 3.47160850187, and also subsetting columns.")
                     filterHex <- hex[hex[,c("DPROS")] == 3.47160850187, c("DPROS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("DPROS")] == 3.47160850187, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"VOL\" using value 48.6067275145, and also subsetting columns.")
                     filterHex <- hex[hex[,c("VOL")] == 48.6067275145, c("VOL")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("VOL")] == 48.6067275145, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"VOL\" using value 77.0186911509, and also subsetting columns.")
                     filterHex <- hex[hex[,c("VOL")] == 77.0186911509, c("VOL")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("VOL")] == 77.0186911509, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"ID\" using value 64.4138241011, and also subsetting columns.")
                     filterHex <- hex[hex[,c("ID")] == 64.4138241011, c("ID")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("ID")] == 64.4138241011, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"ID\" using value 40.1158504898, and also subsetting columns.")
                     filterHex <- hex[hex[,c("ID")] == 40.1158504898, c("ID")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("ID")] == 40.1158504898, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
                    Log.info("Filtering out rows by == from dataset prostate_cat_replaced and column \"CAPSULE\" using value 0.724011862683, and also subsetting columns.")
                     filterHex <- hex[hex[,c("CAPSULE")] == 0.724011862683, c("CAPSULE")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("CAPSULE")] == 0.724011862683, c("GLEASON","DPROS","PSA","DCAPS","VOL","CAPSULE","RACE","ID","AGE")]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("simpleFilterTest_ on data prostate_cat_replaced", simpleFilterTest_prostate_cat_replaced_102(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
