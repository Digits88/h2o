source('./findNSourceUtils.R')

Log.info("======================== Begin Test ===========================\n")
view_max <- 10000 #maximum returned by Inspect.java

test.summary.numeric <- function(conn) {
  Log.info("Importing USArrests.csv data...\n")
  arrests.hex <- h2o.importFile.VA(conn, locate("smalldata/pca_test/USArrests.csv", schema = "local"), "arrests.hex")
  
  Log.info("\nCheck that summary works...")
  summary(arrests.hex)
  
  summary_ <- summary(arrests.hex)
  
  Log.info("\nCheck that we get a table back from the summary(hex)")
  expect_that(summary_, is_a("table"))
  
  summary_2 <- summary(tail(USArrests))
  
  Log.info("\nCheck that the summary of the tail of the dataset is the same as what R produces: ")
  Log.info("\nsummary(tail(USArrests))\n")
  
  print(summary_2)
  Log.info("\nsummary(tail(arrests.hex))\n")
  
  print(summary(tail(arrests.hex)))
  expect_that(summary(tail(arrests.hex)), equals(summary_2))

  Log.info("End of test.")
  PASSS <<- TRUE
}

conn <- new("H2OClient", ip=myIP, port=myPort)
PASSS <- FALSE
tryCatch(test_that("summaryTests",test.summary.numeric(conn)), error = function(e) FAIL(e))
if (!PASSS) FAIL("Did not reach the end of test. Check Rsandbox/errors.log for warnings and errors.")
PASS()
