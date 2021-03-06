            ##
            # Author: Autogenerated on 2013-11-27 18:13:59
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            simpleFilterTest_benign_109 <- function(conn) {
                Log.info("A munge-task R unit test on data <benign> testing the functional unit <==> ")
                Log.info("Uploading benign")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/logreg/benign.csv"), "rbenign.hex")
                Log.info("Filtering out rows by == from dataset benign and column \"WT\" using value 194.801005849")
                     filterHex <- hex[hex[,c("WT")] == 194.801005849,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"WT" == 194.801005849,]
                Log.info("Filtering out rows by == from dataset benign and column \"LIV\" using value 10.695677676")
                     filterHex <- hex[hex[,c("LIV")] == 10.695677676,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"LIV" == 10.695677676,]
                Log.info("Filtering out rows by == from dataset benign and column \"CHK\" using value 1.71141409171")
                     filterHex <- hex[hex[,c("CHK")] == 1.71141409171,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"CHK" == 1.71141409171,]
                Log.info("Filtering out rows by == from dataset benign and column \"OBS\" using value 2.35250180783")
                     filterHex <- hex[hex[,c("OBS")] == 2.35250180783,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"OBS" == 2.35250180783,]
                Log.info("Filtering out rows by == from dataset benign and column \"WT\" using value 80.9662311679")
                     filterHex <- hex[hex[,c("WT")] == 80.9662311679,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"WT" == 80.9662311679,]
                Log.info("Filtering out rows by == from dataset benign and column \"NLV\" using value 1.86193874504")
                     filterHex <- hex[hex[,c("NLV")] == 1.86193874504,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"NLV" == 1.86193874504,]
                Log.info("Filtering out rows by == from dataset benign and column \"WT\" using value 95.3104732051")
                     filterHex <- hex[hex[,c("WT")] == 95.3104732051,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"WT" == 95.3104732051,]
                Log.info("Filtering out rows by == from dataset benign and column \"AGLP\" using value 30.051516502")
                     filterHex <- hex[hex[,c("AGLP")] == 30.051516502,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"AGLP" == 30.051516502,]
                Log.info("Filtering out rows by == from dataset benign and column \"NLV\" using value 0.0986690855181")
                     filterHex <- hex[hex[,c("NLV")] == 0.0986690855181,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"NLV" == 0.0986690855181,]
                Log.info("Filtering out rows by == from dataset benign and column \"STR\" using value 19.525126294")
                     filterHex <- hex[hex[,c("STR")] == 19.525126294,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"STR" == 19.525126294,]
                Log.info("Filtering out rows by == from dataset benign and column \"AGP1\" using value 17.9338007784")
                     filterHex <- hex[hex[,c("AGP1")] == 17.9338007784,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"AGP1" == 17.9338007784,]
                Log.info("Filtering out rows by == from dataset benign and column \"WT\" using value 208.889542251")
                     filterHex <- hex[hex[,c("WT")] == 208.889542251,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"WT" == 208.889542251,]
                Log.info("Filtering out rows by == from dataset benign and column \"FNDX\" using value 0.126778281449")
                     filterHex <- hex[hex[,c("FNDX")] == 0.126778281449,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"FNDX" == 0.126778281449,]
                Log.info("Filtering out rows by == from dataset benign and column \"LIV\" using value 9.50112233739")
                     filterHex <- hex[hex[,c("LIV")] == 9.50112233739,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"LIV" == 9.50112233739,]
                Log.info("Filtering out rows by == from dataset benign and column \"OBS\" using value 2.1557945418")
                     filterHex <- hex[hex[,c("OBS")] == 2.1557945418,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"OBS" == 2.1557945418,]
                Log.info("Filtering out rows by == from dataset benign and column \"LIV\" using value 2.51977627588")
                     filterHex <- hex[hex[,c("LIV")] == 2.51977627588,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"LIV" == 2.51977627588,]
                    Log.info("Filtering out rows by == from dataset benign and column \"OBS\" using value 2.17035888356, and also subsetting columns.")
                     filterHex <- hex[hex[,c("OBS")] == 2.17035888356, c("OBS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("OBS")] == 2.17035888356, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"AGMT\" using value 62.4854171282, and also subsetting columns.")
                     filterHex <- hex[hex[,c("AGMT")] == 62.4854171282, c("AGMT")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("AGMT")] == 62.4854171282, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"NLV\" using value 4.7321340579, and also subsetting columns.")
                     filterHex <- hex[hex[,c("NLV")] == 4.7321340579, c("NLV")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("NLV")] == 4.7321340579, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"OBS\" using value 2.40534956236, and also subsetting columns.")
                     filterHex <- hex[hex[,c("OBS")] == 2.40534956236, c("OBS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("OBS")] == 2.40534956236, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"NLV\" using value 3.93931465129, and also subsetting columns.")
                     filterHex <- hex[hex[,c("NLV")] == 3.93931465129, c("NLV")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("NLV")] == 3.93931465129, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"AGLP\" using value 25.8497000163, and also subsetting columns.")
                     filterHex <- hex[hex[,c("AGLP")] == 25.8497000163, c("AGLP")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("AGLP")] == 25.8497000163, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"AGMN\" using value 12.5638869513, and also subsetting columns.")
                     filterHex <- hex[hex[,c("AGMN")] == 12.5638869513, c("AGMN")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("AGMN")] == 12.5638869513, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"AGMN\" using value 16.8522637878, and also subsetting columns.")
                     filterHex <- hex[hex[,c("AGMN")] == 16.8522637878, c("AGMN")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("AGMN")] == 16.8522637878, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"CHK\" using value 1.30950392316, and also subsetting columns.")
                     filterHex <- hex[hex[,c("CHK")] == 1.30950392316, c("CHK")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("CHK")] == 1.30950392316, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"OBS\" using value 1.93851706994, and also subsetting columns.")
                     filterHex <- hex[hex[,c("OBS")] == 1.93851706994, c("OBS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("OBS")] == 1.93851706994, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"MST\" using value 2.48217995791, and also subsetting columns.")
                     filterHex <- hex[hex[,c("MST")] == 2.48217995791, c("MST")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("MST")] == 2.48217995791, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"OBS\" using value 2.22159109881, and also subsetting columns.")
                     filterHex <- hex[hex[,c("OBS")] == 2.22159109881, c("OBS")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("OBS")] == 2.22159109881, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"LIV\" using value 7.73291697944, and also subsetting columns.")
                     filterHex <- hex[hex[,c("LIV")] == 7.73291697944, c("LIV")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("LIV")] == 7.73291697944, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"LIV\" using value 3.77304885557, and also subsetting columns.")
                     filterHex <- hex[hex[,c("LIV")] == 3.77304885557, c("LIV")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("LIV")] == 3.77304885557, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"AGP1\" using value 32.3284780845, and also subsetting columns.")
                     filterHex <- hex[hex[,c("AGP1")] == 32.3284780845, c("AGP1")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("AGP1")] == 32.3284780845, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
                    Log.info("Filtering out rows by == from dataset benign and column \"WT\" using value 180.71868558, and also subsetting columns.")
                     filterHex <- hex[hex[,c("WT")] == 180.71868558, c("WT")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("WT")] == 180.71868558, c("AGP1","MST","AGMT","DEG","HIGD","OBS","FNDX","WT","AGLP","LIV","NLV","AGMN","CHK","STR")]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("simpleFilterTest_ on data benign", simpleFilterTest_benign_109(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
