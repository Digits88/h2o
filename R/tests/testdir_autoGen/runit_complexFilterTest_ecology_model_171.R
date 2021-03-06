            ##
            # Author: Autogenerated on 2013-11-27 18:13:59
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            complexFilterTest_ecology_model_171 <- function(conn) {
                Log.info("A munge-task R unit test on data <ecology_model> testing the functional unit <['!', '>', '&', '==', '&', '<=']> ")
                Log.info("Uploading ecology_model")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/gbm_test/ecology_model.csv"), "recology_model.hex")
            Log.info("Performing compound task !( ( hex[,c(\"USAvgT\")] > -1.99705060631 ) & ( hex[,c(\"DSDam\")] == 0.545304065842 ) & ( ( hex[,c(\"USRainDays\")] <= 2.22755919652 )) ) on dataset <ecology_model>")
                     filterHex <- hex[!( ( hex[,c("USAvgT")] > -1.99705060631 ) & ( hex[,c("DSDam")] == 0.545304065842 ) & ( ( hex[,c("USRainDays")] <= 2.22755919652 )) ),]
            Log.info("Performing compound task !( ( hex[,c(\"USRainDays\")] > 0.515832037128 ) & ( hex[,c(\"USAvgT\")] == -3.04492154572 ) & ( ( hex[,c(\"Site\")] <= 846.245170694 )) ) on dataset ecology_model, and also subsetting columns.")
                     filterHex <- hex[!( ( hex[,c("USRainDays")] > 0.515832037128 ) & ( hex[,c("USAvgT")] == -3.04492154572 ) & ( ( hex[,c("Site")] <= 846.245170694 )) ), c("USNative","USSlope","DSMaxSlope","DSDist","USRainDays","LocSed","Site","DSDam","SegSumT","SegLowFlow","USAvgT","SegTSeas","Angaus")]
                Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[!( ( hex[,c("USRainDays")] > 0.515832037128 ) & ( hex[,c("USAvgT")] == -3.04492154572 ) & ( ( hex[,c("Site")] <= 846.245170694 )) ), c("Method")]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("compoundFilterTest_ on data ecology_model", complexFilterTest_ecology_model_171(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
