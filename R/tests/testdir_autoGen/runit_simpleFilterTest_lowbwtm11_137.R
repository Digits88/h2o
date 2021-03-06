            ##
            # Author: Autogenerated on 2013-11-27 18:13:59
            # gitHash: c4ad841105ba82f4a3979e4cf1ae7e20a5905e59
            # SEED: 4663640625336856642
            ##
            source('./findNSourceUtils.R')
            Log.info("======================== Begin Test ===========================")
            simpleFilterTest_lowbwtm11_137 <- function(conn) {
                Log.info("A munge-task R unit test on data <lowbwtm11> testing the functional unit <!=> ")
                Log.info("Uploading lowbwtm11")
                hex <- h2o.uploadFile(conn, locate("../../smalldata/logreg/umass_statdata/lowbwtm11.dat"), "rlowbwtm11.hex")
                Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"HT\" using value 0.844324622376")
                     filterHex <- hex[hex[,c("HT")] != 0.844324622376,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"HT" != 0.844324622376,]
                Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"PTD\" using value 0.533390809674")
                     filterHex <- hex[hex[,c("PTD")] != 0.533390809674,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"PTD" != 0.533390809674,]
                Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"RACE\" using value 2.9590453806")
                     filterHex <- hex[hex[,c("RACE")] != 2.9590453806,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"RACE" != 2.9590453806,]
                Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"Pair#\" using value 41.8134685497")
                     filterHex <- hex[hex[,c("Pair#")] != 41.8134685497,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"Pair#" != 41.8134685497,]
                Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"UI\" using value 0.0505559553355")
                     filterHex <- hex[hex[,c("UI")] != 0.0505559553355,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"UI" != 0.0505559553355,]
                Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"AGE\" using value 21.0771864282")
                     filterHex <- hex[hex[,c("AGE")] != 21.0771864282,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"AGE" != 21.0771864282,]
                Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"HT\" using value 0.67635770645")
                     filterHex <- hex[hex[,c("HT")] != 0.67635770645,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"HT" != 0.67635770645,]
                Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"HT\" using value 0.585140183688")
                     filterHex <- hex[hex[,c("HT")] != 0.585140183688,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"HT" != 0.585140183688,]
                Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"PTD\" using value 0.0332610155675")
                     filterHex <- hex[hex[,c("PTD")] != 0.0332610155675,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"PTD" != 0.0332610155675,]
                Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"UI\" using value 0.690885177727")
                     filterHex <- hex[hex[,c("UI")] != 0.690885177727,]
                    Log.info("Perform filtering with the '$' sign also")
                    filterHex <- hex[hex$"UI" != 0.690885177727,]
                    Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"AGE\" using value 31.263248549, and also subsetting columns.")
                     filterHex <- hex[hex[,c("AGE")] != 31.263248549, c("AGE")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("AGE")] != 31.263248549, c("SMOKE","LOW","RACE","PTD","UI","Pair#","HT","LWT","AGE")]
                    Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"PTD\" using value 0.11450282656, and also subsetting columns.")
                     filterHex <- hex[hex[,c("PTD")] != 0.11450282656, c("PTD")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("PTD")] != 0.11450282656, c("SMOKE","LOW","RACE","PTD","UI","Pair#","HT","LWT","AGE")]
                    Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"LOW\" using value 0.0996382354268, and also subsetting columns.")
                     filterHex <- hex[hex[,c("LOW")] != 0.0996382354268, c("LOW")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("LOW")] != 0.0996382354268, c("SMOKE","LOW","RACE","PTD","UI","Pair#","HT","LWT","AGE")]
                    Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"LWT\" using value 111.299260067, and also subsetting columns.")
                     filterHex <- hex[hex[,c("LWT")] != 111.299260067, c("LWT")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("LWT")] != 111.299260067, c("SMOKE","LOW","RACE","PTD","UI","Pair#","HT","LWT","AGE")]
                    Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"PTD\" using value 0.781477296622, and also subsetting columns.")
                     filterHex <- hex[hex[,c("PTD")] != 0.781477296622, c("PTD")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("PTD")] != 0.781477296622, c("SMOKE","LOW","RACE","PTD","UI","Pair#","HT","LWT","AGE")]
                    Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"LWT\" using value 153.293116245, and also subsetting columns.")
                     filterHex <- hex[hex[,c("LWT")] != 153.293116245, c("LWT")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("LWT")] != 153.293116245, c("SMOKE","LOW","RACE","PTD","UI","Pair#","HT","LWT","AGE")]
                    Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"Pair#\" using value 55.8499139288, and also subsetting columns.")
                     filterHex <- hex[hex[,c("Pair#")] != 55.8499139288, c("Pair#")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("Pair#")] != 55.8499139288, c("SMOKE","LOW","RACE","PTD","UI","Pair#","HT","LWT","AGE")]
                    Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"LWT\" using value 106.54029844, and also subsetting columns.")
                     filterHex <- hex[hex[,c("LWT")] != 106.54029844, c("LWT")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("LWT")] != 106.54029844, c("SMOKE","LOW","RACE","PTD","UI","Pair#","HT","LWT","AGE")]
                    Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"Pair#\" using value 2.04940913094, and also subsetting columns.")
                     filterHex <- hex[hex[,c("Pair#")] != 2.04940913094, c("Pair#")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("Pair#")] != 2.04940913094, c("SMOKE","LOW","RACE","PTD","UI","Pair#","HT","LWT","AGE")]
                    Log.info("Filtering out rows by != from dataset lowbwtm11 and column \"HT\" using value 0.812076120391, and also subsetting columns.")
                     filterHex <- hex[hex[,c("HT")] != 0.812076120391, c("HT")]
                    Log.info("Now do the same filter & subset, but select complement of columns.")
                     filterHex <- hex[hex[,c("HT")] != 0.812076120391, c("SMOKE","LOW","RACE","PTD","UI","Pair#","HT","LWT","AGE")]
            }
            conn = new("H2OClient", ip=myIP, port=myPort)
            tryCatch(test_that("simpleFilterTest_ on data lowbwtm11", simpleFilterTest_lowbwtm11_137(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
            PASS()
