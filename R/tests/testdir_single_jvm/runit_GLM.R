source('./findNSourceUtils.R')

Log.info("========================== Begin Tests ==============================\n")
conn = new("H2OClient", ip=myIP, port=myPort)
checkGLMModel <- function(myGLM.h2o, myGLM.r) {
  coeff.mat = as.matrix(myGLM.r$beta)
  numcol = ncol(coeff.mat)
  coeff.R = c(coeff.mat[,numcol], Intercept = as.numeric(myGLM.r$a0[numcol]))
  print(myGLM.h2o@model$coefficients)
  print(coeff.R)
  checkEqualsNumeric(myGLM.h2o@model$coefficients, coeff.R, tolerance = 3.8)
  checkEqualsNumeric(myGLM.h2o@model$null.deviance, myGLM.r$nulldev, tolerance = 1.5)
}

# Test GLM on benign.csv dataset
test.GLM.benign <- function(conn) {
  Log.info("Importing benign.csv data...\n")
  # benign.hex = h2o.importURL(conn, "https..//raw.github.com/0xdata/h2o/master/smalldata/logreg/benign.csv")
  # benign.hex = h2o.importFile(conn, normalizePath("../../../smalldata/logreg/benign.csv"))
  benign.hex = h2o.uploadFile.VA(conn, locate("smalldata/logreg/benign.csv"), "benign.hex")
  benign.sum = summary(benign.hex)
  print(benign.sum)
  
  # benign.data = read.csv(text = getURL("https..//raw.github.com/0xdata/h2o/master/smalldata/logreg/benign.csv"), header = TRUE)
  benign.data = read.csv(locate("smalldata/logreg/benign.csv"))
  benign.data = na.omit(benign.data)
  
  # myY = 3; myY.r = myY + 1
  myY = 4;
  for(maxx in 11:14) {
    # myX = 0:maxx
    # myX = myX[which(myX != myY)]; myX.r = myX + 1
    # myX = paste(myX, collapse=",")
    myX = 1:maxx;
    myX = myX[which(myX != myY)]
    
    Log.info(cat("A)H2O GLM (binomial) with parameters:\nX:", myX, "\nY:", myY, "\n"))
    benign.glm.h2o = h2o.glm(y = myY, x = myX, data = benign.hex, family = "binomial", nfolds = 5, alpha = 0.5)
    print(benign.glm.h2o)
    
    # benign.glm = glm.fit(y = benign.data[,myY], x = benign.data[,myX], family = binomial)
    # benign.glm = glmnet(y = benign.data[,myY], x = data.matrix(benign.data[,myX]), family = "binomial", alpha = 0.5)
    benign.glm = glmnet(y = benign.data[,myY], x = data.matrix(benign.data[,myX]), family = "binomial", alpha = 0.5)
    checkGLMModel(benign.glm.h2o, benign.glm)
  }
  Log.info("End of test")
  PASSS <<- TRUE
}

# Test GLM on prostate dataset
test.GLM.prostate <- function(conn) {
  Log.info("Importing prostate.csv data...\n")
  # prostate.hex = h2o.importURL(conn, "https..//raw.github.com/0xdata/h2o/master/smalldata/logreg/prostate.csv", "prostate.hex")
  # prostate.hex = h2o.importFile(conn, normalizePath("../../../smalldata/logreg/prostate.csv"), "prostate.hex")
  prostate.hex = h2o.uploadFile.VA(conn, locate("smalldata/logreg/prostate.csv"), "prostate.hex")
  prostate.sum = summary(prostate.hex)
  print(prostate.sum)
  
  # prostate.data = read.csv(text = getURL("https..//raw.github.com/0xdata/h2o/master/smalldata/logreg/prostate.csv"), header = TRUE)
  prostate.data = read.csv(locate("smalldata/logreg/prostate.csv"), header = TRUE)
  prostate.data = na.omit(prostate.data)
  
  myY = 2
  for(maxx in 4:9) {
    myX = 3:maxx
    myX = myX[which(myX != myY)]
    # myX = paste(myX, collapse=",")
    
    Log.info(cat("B)H2O GLM (binomial) with parameters:\nX:", myX, "\nY:", myY, "\n"))
    prostate.glm.h2o = h2o.glm(y = myY, x = myX, data = prostate.hex, family = "binomial", nfolds = 10, alpha = 0.5)
    print(prostate.glm.h2o)
    
    # prostate.glm = glm.fit(y = prostate.data[,myY], x = prostate.data[,myX], family = binomial)
    prostate.glm = glmnet(y = prostate.data[,myY], x = data.matrix(prostate.data[,myX]), family = "binomial", alpha = 0.5)
    checkGLMModel(prostate.glm.h2o, prostate.glm)
  }
  Log.info("End of test")
  PASSS <<- TRUE
}

# Test GLM on covtype (20k) dataset
test.GLM.covtype <- function(conn) {
  Log.info("Importing covtype.20k.data...\n")
  # covtype.hex = h2o.importFile(conn, "../../../UCI/UCI-large/covtype/covtype.data")
  # covtype.hex = h2o.importURL(conn, "https..//raw.github.com/0xdata/h2o/master/smalldata/covtype/covtype.20k.data")
  # covtype.hex = h2o.importFile(conn, normalizePath("../../../smalldata/covtype/covtype.20k.data"))
  covtype.hex = h2o.uploadFile.VA(conn, locate("smalldata/covtype/covtype.20k.data"))
  covtype.sum = summary(covtype.hex)
  print(covtype.sum)
  
  myY = 55
  myX = setdiff(1:54, c(21,29))   # Cols 21 and 29 are constant, so must be explicitly ignored
  myX = myX[which(myX != myY)];
  # max_iter = 8
  
  # L2: alpha = 0, lambda = 0
  start = Sys.time()
  covtype.h2o1 = h2o.glm(y = myY, x = myX, data = covtype.hex, family = "binomial", nfolds = 2, alpha = 0, lambda = 0)
  end = Sys.time()
  Log.info(cat("GLM (L2) on", covtype.hex@key, "took", as.numeric(end-start), "seconds\n"))
  print(covtype.h2o1)
  
  # Elastic: alpha = 0.5, lambda = 1e-4
  start = Sys.time()
  covtype.h2o2 = h2o.glm(y = myY, x = myX, data = covtype.hex, family = "binomial", nfolds = 2, alpha = 0.5, lambda = 1e-4)
  end = Sys.time()
  Log.info(cat("GLM (Elastic) on", covtype.hex@key, "took", as.numeric(end-start), "seconds\n"))
  print(covtype.h2o2)
  
  # L1: alpha = 1, lambda = 1e-4
  start = Sys.time()
  covtype.h2o3 = h2o.glm(y = myY, x = myX, data = covtype.hex, family = "binomial", nfolds = 2, alpha = 1, lambda = 1e-4)
  end = Sys.time()
  Log.info(cat("GLM (L1) on", covtype.hex@key, "took", as.numeric(end-start), "seconds\n"))
  print(covtype.h2o3)
  Log.info("End of test.")
  PASSS <<- TRUE
}

PASSS <- FALSE
conn = new("H2OClient", ip=myIP, port=myPort)
tryCatch(test_that("GLM Test: Benign", test.GLM.benign(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
if (!PASSS) FAIL("Did not reach the end of test. Check Rsandbox/errors.log for warnings and errors.")
PASS()
PASSS <- FALSE
tryCatch(test_that("GLM TestL Prostate", test.GLM.prostate(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
if (!PASSS) FAIL("Did not reach the end of test. Check Rsandbox/errors.log for warnings and errors.")
PASS()
PASSS <- FALSE
tryCatch(test_that("GLM Test: Covtype", test.GLM.covtype(conn)), warning = function(w) WARN(w), error = function(e) FAIL(e))
if (!PASSS) FAIL("Did not reach the end of test. Check Rsandbox/errors.log for warnings and errors.")
PASS()
