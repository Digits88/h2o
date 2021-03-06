            ##
            # Author: Autogenerated on 2013-11-27 18:13:58
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            simpleFilterTest_pharynx_84 <- function(conn) {
                Log.info("A munge-task R unit test on data <pharynx> testing the functional unit <>=> ")
                Log.info("Uploading pharynx")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/logreg/umass_statdata/pharynx.dat"), "rpharynx.hex")
                Log.info("Filtering out rows by >= from dataset pharynx and column \"3\" using value 1.28413116628")
                     filterHex <- hex[hex[,c(3)] >= 1.28413116628,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"3" >= 1.28413116628,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"6\" using value 8.48823808663")
                     filterHex <- hex[hex[,c(6)] >= 8.48823808663,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"6" >= 8.48823808663,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"1\" using value 5.70551089744")
                     filterHex <- hex[hex[,c(1)] >= 5.70551089744,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"1" >= 5.70551089744,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"9\" using value 0.438816090481")
                     filterHex <- hex[hex[,c(9)] >= 0.438816090481,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"9" >= 0.438816090481,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"11\" using value 0.244891656854")
                     filterHex <- hex[hex[,c(11)] >= 0.244891656854,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"11" >= 0.244891656854,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"5\" using value 85.9830279606")
                     filterHex <- hex[hex[,c(5)] >= 85.9830279606,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"5" >= 85.9830279606,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"1\" using value 4.70580592311")
                     filterHex <- hex[hex[,c(1)] >= 4.70580592311,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"1" >= 4.70580592311,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"5\" using value 29.0218029498")
                     filterHex <- hex[hex[,c(5)] >= 29.0218029498,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"5" >= 29.0218029498,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"8\" using value 1.80318384277")
                     filterHex <- hex[hex[,c(8)] >= 1.80318384277,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"8" >= 1.80318384277,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"9\" using value 2.51965947499")
                     filterHex <- hex[hex[,c(9)] >= 2.51965947499,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"9" >= 2.51965947499,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"11\" using value 0.873504954531")
                     filterHex <- hex[hex[,c(11)] >= 0.873504954531,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"11" >= 0.873504954531,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"10\" using value 4349.61552546")
                     filterHex <- hex[hex[,c(10)] >= 4349.61552546,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"10" >= 4349.61552546,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"7\" using value 3.07479866717")
                     filterHex <- hex[hex[,c(7)] >= 3.07479866717,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"7" >= 3.07479866717,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"12\" using value 391.167076301")
                     filterHex <- hex[hex[,c(12)] >= 391.167076301,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"12" >= 391.167076301,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"5\" using value 61.6371486911")
                     filterHex <- hex[hex[,c(5)] >= 61.6371486911,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"5" >= 61.6371486911,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"8\" using value 1.40129138511")
                     filterHex <- hex[hex[,c(8)] >= 1.40129138511,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"8" >= 1.40129138511,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"8\" using value 1.21708537404")
                     filterHex <- hex[hex[,c(8)] >= 1.21708537404,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"8" >= 1.21708537404,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"4\" using value 2.83081028991")
                     filterHex <- hex[hex[,c(4)] >= 2.83081028991,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"4" >= 2.83081028991,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"12\" using value 1113.12535868")
                     filterHex <- hex[hex[,c(12)] >= 1113.12535868,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"12" >= 1113.12535868,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"4\" using value 2.78699251097")
                     filterHex <- hex[hex[,c(4)] >= 2.78699251097,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"4" >= 2.78699251097,]
                Log.info("Filtering out rows by >= from dataset pharynx and column \"3\" using value 1.64942164377")
                     filterHex <- hex[hex[,c(3)] >= 1.64942164377,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"3" >= 1.64942164377,]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"12\" using value 752.318802912, and also subsetting columns.")
                     filterHex <- hex[hex[,c(12)] >= 752.318802912, c(12)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(12)] >= 752.318802912, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"5\" using value 66.8739528906, and also subsetting columns.")
                     filterHex <- hex[hex[,c(5)] >= 66.8739528906, c(5)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(5)] >= 66.8739528906, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"5\" using value 32.3428250199, and also subsetting columns.")
                     filterHex <- hex[hex[,c(5)] >= 32.3428250199, c(5)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(5)] >= 32.3428250199, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"10\" using value 10479.8796814, and also subsetting columns.")
                     filterHex <- hex[hex[,c(10)] >= 10479.8796814, c(10)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(10)] >= 10479.8796814, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"8\" using value 2.83868111907, and also subsetting columns.")
                     filterHex <- hex[hex[,c(8)] >= 2.83868111907, c(8)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(8)] >= 2.83868111907, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"2\" using value 1.75749200827, and also subsetting columns.")
                     filterHex <- hex[hex[,c(2)] >= 1.75749200827, c(2)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(2)] >= 1.75749200827, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"1\" using value 5.16262900435, and also subsetting columns.")
                     filterHex <- hex[hex[,c(1)] >= 5.16262900435, c(1)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(1)] >= 5.16262900435, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"7\" using value 3.4280522428, and also subsetting columns.")
                     filterHex <- hex[hex[,c(7)] >= 3.4280522428, c(7)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(7)] >= 3.4280522428, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"5\" using value 49.2359747292, and also subsetting columns.")
                     filterHex <- hex[hex[,c(5)] >= 49.2359747292, c(5)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(5)] >= 49.2359747292, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"9\" using value 1.05931496061, and also subsetting columns.")
                     filterHex <- hex[hex[,c(9)] >= 1.05931496061, c(9)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(9)] >= 1.05931496061, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"0\" using value 161.605067194, and also subsetting columns.")
                     filterHex <- hex[hex[,c(1)] >= 161.605067194, c(1)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(1)] >= 161.605067194, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"10\" using value 9158.43053782, and also subsetting columns.")
                     filterHex <- hex[hex[,c(10)] >= 9158.43053782, c(10)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(10)] >= 9158.43053782, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"3\" using value 1.45802693645, and also subsetting columns.")
                     filterHex <- hex[hex[,c(3)] >= 1.45802693645, c(3)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(3)] >= 1.45802693645, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"0\" using value 159.723456926, and also subsetting columns.")
                     filterHex <- hex[hex[,c(1)] >= 159.723456926, c(1)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(1)] >= 159.723456926, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"9\" using value 1.84101020697, and also subsetting columns.")
                     filterHex <- hex[hex[,c(9)] >= 1.84101020697, c(9)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(9)] >= 1.84101020697, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"9\" using value 0.313749388048, and also subsetting columns.")
                     filterHex <- hex[hex[,c(9)] >= 0.313749388048, c(9)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(9)] >= 0.313749388048, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"4\" using value 7.12172115719, and also subsetting columns.")
                     filterHex <- hex[hex[,c(4)] >= 7.12172115719, c(4)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(4)] >= 7.12172115719, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"2\" using value 1.9996265204, and also subsetting columns.")
                     filterHex <- hex[hex[,c(2)] >= 1.9996265204, c(2)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(2)] >= 1.9996265204, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"2\" using value 1.91709608625, and also subsetting columns.")
                     filterHex <- hex[hex[,c(2)] >= 1.91709608625, c(2)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(2)] >= 1.91709608625, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"8\" using value 1.59961618171, and also subsetting columns.")
                     filterHex <- hex[hex[,c(8)] >= 1.59961618171, c(8)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(8)] >= 1.59961618171, c(11,10,12,1,3,2,5,4,7,6,9,8)]
                    Log.info("Filtering out rows by >= from dataset pharynx and column \"11\" using value 0.315289997531, and also subsetting columns.")
                     filterHex <- hex[hex[,c(11)] >= 0.315289997531, c(11)]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c(11)] >= 0.315289997531, c(11,10,12,1,3,2,5,4,7,6,9,8)]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("simpleFilterTest_ on data pharynx", simpleFilterTest_pharynx_84(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
