MAX_INSPECT_VIEW = 10000

# Class definitions
# WARNING: Do NOT touch the env slot! It is used to link garbage collection between R and H2O
# setClass("H2OClient", representation(ip="character", port="numeric"), prototype(ip="127.0.0.1", port=54321))
setClass("H2OClient", representation(ip="character", port="numeric"), prototype(ip="127.0.0.1", port=54321))
setClass("H2ORawData", representation(h2o="H2OClient", key="character", env="environment"))
# setClass("H2OParsedData", representation(h2o="H2OClient", key="character"))
setClass("H2OParsedData", representation(h2o="H2OClient", key="character", env="environment"))
setClass("H2OLogicalData", contains="H2OParsedData")
setClass("H2OModel", representation(key="character", data="H2OParsedData", model="list", env="environment", "VIRTUAL"))
setClass("H2OGrid", representation(key="character", data="H2OParsedData", model="list", sumtable="list", "VIRTUAL"))

setClass("H2OGLMModel", contains="H2OModel", representation(xval="list"))
# setClass("H2OGLMGrid", contains="H2OGrid")
setClass("H2OKMeansModel", contains="H2OModel")
setClass("H2ONNModel", contains="H2OModel")
setClass("H2ODRFModel", contains="H2OModel")
setClass("H2OPCAModel", contains="H2OModel")
setClass("H2OGBMModel", contains="H2OModel")
setClass("H2OGBMGrid", contains="H2OGrid")

setClass("H2ORawDataVA", representation(h2o="H2OClient", key="character", env="environment"))
setClass("H2OParsedDataVA", representation(h2o="H2OClient", key="character", env="environment"))
setClass("H2OModelVA", representation(key="character", data="H2OParsedDataVA", model="list", env="environment", "VIRTUAL"))
setClass("H2OGridVA", representation(key="character", data="H2OParsedDataVA", model="list", sumtable="list", "VIRTUAL"))
setClass("H2OGLMModelVA", contains="H2OModelVA", representation(xval="list"))
setClass("H2OGLMGridVA", contains="H2OGridVA")

# Register finalizers for H2O data and model objects
# setMethod("initialize", "H2ORawData", function(.Object, h2o = new("H2OClient"), key = "") {
#   .Object@h2o = h2o
#   .Object@key = key
#   .Object@env = new.env()
#   
#   assign("h2o", .Object@h2o, envir = .Object@env)
#   assign("key", .Object@key, envir = .Object@env)
#   
#   # Empty keys don't refer to any object in H2O
#   if(key != "") reg.finalizer(.Object@env, h2o.__finalizer)
#   return(.Object)
# })
# 
# setMethod("initialize", "H2OParsedData", function(.Object, h2o = new("H2OClient"), key = "") {
#   .Object@h2o = h2o
#   .Object@key = key
#   .Object@env = new.env()
#   
#   assign("h2o", .Object@h2o, envir = .Object@env)
#   assign("key", .Object@key, envir = .Object@env)
#   
#   # Empty keys don't refer to any object in H2O
#   if(key != "") reg.finalizer(.Object@env, h2o.__finalizer)
#   return(.Object)
# })
# 
# setMethod("initialize", "H2OModel", function(.Object, key = "", data = new("H2OParsedData"), model = list()) {
#   .Object@key = key
#   .Object@data = data
#   .Object@model = model
#   .Object@env = new.env()
#   
#   assign("h2o", .Object@data@h2o, envir = .Object@env)
#   assign("key", .Object@key, envir = .Object@env)
#   
#   # Empty keys don't refer to any object in H2O
#   if(key != "") reg.finalizer(.Object@env, h2o.__finalizer)
#   return(.Object)
# })

# Class display functions
setMethod("show", "H2OClient", function(object) {
  cat("IP Address:", object@ip, "\n")
  cat("Port      :", object@port, "\n")
})

setMethod("show", "H2ORawData", function(object) {
  print(object@h2o)
  cat("Raw Data Key:", object@key, "\n")
})

setMethod("show", "H2OParsedData", function(object) {
  print(object@h2o)
  cat("Parsed Data Key:", object@key, "\n")
})

setMethod("show", "H2OGLMModel", function(object) {
  print(object@data)
  cat("GLM2 Model Key:", object@key, "\n\nCoefficients:\n")
  
  model = object@model
  print(round(model$coefficients,5))
  cat("\nDegrees of Freedom:", model$df.null, "Total (i.e. Null); ", model$df.residual, "Residual\n")
  cat("Null Deviance:    ", round(model$null.deviance,1), "\n")
  cat("Residual Deviance:", round(model$deviance,1), " AIC:", round(model$aic,1), "\n")
  cat("Avg Training Error Rate:", round(model$train.err,5), "\n")
  
  # if(model$family == "binomial") {
  if(model$family$family == "binomial") {
    cat("AUC:", round(model$auc,5), " Best Threshold:", round(model$best_threshold,5), "\n")
    cat("\nConfusion Matrix:\n"); print(model$confusion,2)
  }
    
  if(length(object@xval) > 0) {
    cat("\nCross-Validation Models:\n")
    # if(model$family == "binomial") {
    if(model$family$family == "binomial") {
      modelXval = t(sapply(object@xval, function(x) { c(x@model$rank-1, x@model$auc, 1-x@model$deviance/x@model$null.deviance) }))
      colnames(modelXval) = c("Nonzeros", "AUC", "Deviance Explained")
    } else {
      modelXval = t(sapply(object@xval, function(x) { c(x@model$rank-1, x@model$aic, 1-x@model$deviance/x@model$null.deviance) }))
      colnames(modelXval) = c("Nonzeros", "AIC", "Deviance Explained")
    }
    rownames(modelXval) = paste("Model", 1:nrow(modelXval))
    print(modelXval)
  }
})

# setMethod("show", "H2OGLMGrid", function(object) {
#   print(object@data)
#   cat("GLMGrid Model Key:", object@key, "\n")
#   
#   temp = data.frame(t(sapply(object@sumtable, c)))
#   cat("\nSummary\n"); print(temp)
# })

setMethod("show", "H2OKMeansModel", function(object) {
  print(object@data)
  cat("K-Means Model Key:", object@key)
  
  model = object@model
  cat("\n\nK-means clustering with", length(model$size), "clusters of sizes "); cat(model$size, sep=", ")
  cat("\n\nCluster means:\n"); print(model$centers)
  cat("\nClustering vector:\n"); print(summary(model$cluster))
  cat("\nWithin cluster sum of squares by cluster:\n"); print(model$withinss)
  cat("\nAvailable components:\n\n"); print(names(model))
})

setMethod("show", "H2ONNModel", function(object) {
  print(object@data)
  cat("NN Model Key:", object@key)
  
  model = object@model
  cat("\n\nTraining classification error:", model$train_class_error)
  cat("\nTraining square error:", model$train_sqr_error)
  cat("\n\nValidation classification error:", model$valid_class_error)
  cat("\nValidation square error:", model$valid_sqr_error)
  cat("\n\nConfusion matrix:\n"); print(model$confusion)
})

setMethod("show", "H2ODRFModel", function(object) {
  print(object@data)
  cat("Distributed Random Forest Model Key:", object@key)
  
  model = object@model
  cat("\nNumber of trees:", model$ntree)
  cat("\nTree statistics:\n"); print(model$forest)
  cat("\nConfusion matrix:\n"); print(model$confusion)
})

setMethod("show", "H2OPCAModel", function(object) {
  print(object@data)
  cat("PCA Model Key:", object@key)
  
  model = object@model
  cat("\n\nStandard deviations:\n", model$sdev)
  cat("\n\nRotation:\n"); print(model$rotation)
})

setMethod("show", "H2OGBMModel", function(object) {
  print(object@data)
  cat("GBM Model Key:", object@key)
  
  model = object@model
  cat("\n\nConfusion matrix:\n"); print(model$confusion)
  cat("\nMean Squared error by tree:\n"); print(model$err)
})

setMethod("show", "H2OGBMGrid", function(object) {
  print(object@data)
  cat("GBMGrid Model Key:", object@key, "\n")
  
  temp = data.frame(t(sapply(object@sumtable, c)))
  cat("\nSummary\n"); print(temp)
})

setMethod("summary", "H2OPCAModel", function(object) {
  # TODO: Save propVar and cumVar from the Java output instead of computing here
  myVar = object@model$sdev^2
  myProp = myVar/sum(myVar)
  result = rbind(object@model$sdev, myProp, cumsum(myProp))   # Need to limit decimal places to 4
  colnames(result) = paste("PC", seq(1, length(myVar)), sep="")
  rownames(result) = c("Standard deviation", "Proportion of Variance", "Cumulative Proportion")
  
  cat("Importance of components:\n")
  print(result)
})

setMethod("plot", "H2OPCAModel", function(x, y, ...) {
  barplot(x@model$sdev^2)
  title(main = paste("h2o.prcomp(", x@data@key, ")", sep=""), ylab = "Variances")
})

# i are the rows, j are the columns. These can be vectors of integers or character strings, or a single H2OLogicalData2 object.
setMethod("[", "H2OParsedData", function(x, i, j, ..., drop = TRUE) {
  numRows = nrow(x); numCols = ncol(x)
  if((!missing(i) && is.numeric(i) && any(abs(i) < 1 || abs(i) > numRows)) || 
     (!missing(j) && is.numeric(j) && any(abs(j) < 1 || abs(j) > numCols)))
    stop("Array index out of bounds")
  
  if(missing(i) && missing(j)) return(x)
  if(missing(i) && !missing(j)) {
    if(is.character(j)) { 
      # return(do.call("$", c(x, j)))
      myCol = colnames(x)
      if(any(!(j %in% myCol))) stop("undefined columns selected")
      j = match(j, myCol)
    }
    # if(is.logical(j)) j = -which(!j)
    if(is.logical(j)) j = which(j)

    if(class(j) == "H2OLogicalData")
      expr = paste(x@key, "[", j@key, ",]", sep="")
    else if(is.numeric(j) || is.integer(j))
      expr = paste(x@key, "[,c(", paste(j, collapse=","), ")]", sep="")
    else stop(paste("Column index of type", class(j), "unsupported!"))
  } else if(!missing(i) && missing(j)) {
    # if(is.logical(i)) i = -which(!i)
    if(is.logical(i)) i = which(i)
    if(class(i) == "H2OLogicalData")
      expr = paste(x@key, "[", i@key, ",]", sep="")
    else if(is.numeric(i) || is.integer(i))
      expr = paste(x@key, "[c(", paste(i, collapse=","), "),]", sep="")
    else stop(paste("Row index of type", class(i), "unsupported!"))
  } else {
    # if(is.logical(i)) i = -which(!i)
    if(is.logical(i)) i = which(i)
    if(class(i) == "H2OLogicalData") rind = i@key
    else if(is.numeric(i) || is.integer(i))
      rind = paste("c(", paste(i, collapse=","), ")", sep="")
    else stop(paste("Row index of type", class(i), "unsupported!"))
    
    if(is.character(j)) { 
      # return(do.call("$", c(x, j)))
      myCol = colnames(x)
      if(any(!(j %in% myCol))) stop("undefined columns selected")
      j = match(j, myCol)
    }
    # if(is.logical(j)) j = -which(!j)
    if(is.logical(j)) j = which(j)
    if(class(j) == "H2OLogicalData") cind = j@key
    else if(is.numeric(j) || is.integer(j))
      cind = paste("c(", paste(j, collapse=","), ")", sep="")
    else stop(paste("Column index of type", class(j), "unsupported!"))
    expr = paste(x@key, "[", rind, ",", cind, "]", sep="")
  }
  res = h2o.__exec2(x@h2o, expr)
  if(res$num_rows == 0 && res$num_cols == 0)
    res$scalar
  else
    new("H2OParsedData", h2o=x@h2o, key=res$dest_key)
})

setMethod("$", "H2OParsedData", function(x, name) {
  myNames = colnames(x)
  if(!(name %in% myNames)) return(NULL)
  cind = match(name, myNames)
  expr = paste(x@key, "[,", cind, "]", sep="")
  res = h2o.__exec2(x@h2o, expr)
  if(res$num_rows == 0 && res$num_cols == 0)
    res$scalar
  else
    new("H2OParsedData", h2o=x@h2o, key=res$dest_key)
})

setMethod("[<-", "H2OParsedData", function(x, i, j, ..., value) {
  numRows = nrow(x); numCols = ncol(x)
  # if((!missing(i) && is.numeric(i) && any(abs(i) < 1 || abs(i) > numRows)) || 
  #     (!missing(j) && is.numeric(j) && any(abs(j) < 1 || abs(j) > numCols)))
  #  stop("Array index out of bounds!")
  if(!(missing(i) || is.numeric(i)) || !(missing(j) || is.numeric(j) || is.character(j))) 
    stop("Row/column types not supported!")
  
  if(!missing(i) && is.numeric(i)) {
    if(any(i == 0)) stop("Array index out of bounds")
    if(any(i < 0 && abs(i) > numRows)) stop("Unimplemented: can't extend rows")
    if(min(i) > numRows+1) stop("new rows would leave holes after existing rows")
  }
  if(!missing(j) && is.numeric(j)) {
    if(any(j == 0)) stop("Array index out of bounds")
    if(any(j < 0 && abs(j) > numCols)) stop("Unimplemented: can't extend columns")
    if(min(j) > numCols+1) stop("new columns would leaves holes after existing columns")
  }
  
  if(missing(i) && missing(j))
    lhs = x@key
  else if(missing(i) && !missing(j)) {
    if(is.character(j)) {
      myNames = colnames(x)
      if(any(!(j %in% myNames))) stop("Unimplemented: undefined column names specified")
      cind = match(j, myNames)
    } else cind = j
    cind = paste("c(", paste(cind, collapse = ","), ")", sep = "")
    lhs = paste(x@key, "[,", cind, "]", sep = "")
  } else if(!missing(i) && missing(j)) {
    rind = paste("c(", paste(i, collapse = ","), ")", sep = "")
    lhs = paste(x@key, "[", rind, ",]", sep = "")
  } else {
    if(is.character(j)) {
      myNames = colnames(x)
      if(any(!(j %in% myNames))) stop("Unimplemented: undefined column names specified")
      cind = match(j, myNames)
    } else cind = j
    cind = paste("c(", paste(cind, collapse = ","), ")", sep = "")
    rind = paste("c(", paste(i, collapse = ","), ")", sep = "")
    lhs = paste(x@key, "[", rind, ",", cind, "]", sep = "")
  }
  
  rhs = ifelse(class(value) == "H2OParsedData", value@key, value)
  res = h2o.__exec2(x@h2o, paste(lhs, "=", rhs))
  return(x)
})

setMethod("$<-", "H2OParsedData", function(x, name, value) {
  lhs = paste(x@key, "[,", ncol(x)+1, "]", sep = "")
  rhs = ifelse(class(value) == "H2OParsedData", value@key, paste("c(", paste(value, collapse = ","), ")", sep=""))
  res = h2o.__exec2(x@h2o, paste(lhs, "=", rhs))
  # TODO: Set column name of ncol(x) + 1 to name
  return(x)
})

setMethod("+", c("H2OParsedData", "H2OParsedData"), function(e1, e2) { h2o.__binop2("+", e1, e2) })
setMethod("-", c("H2OParsedData", "H2OParsedData"), function(e1, e2) { h2o.__binop2("-", e1, e2) })
setMethod("*", c("H2OParsedData", "H2OParsedData"), function(e1, e2) { h2o.__binop2("*", e1, e2) })
setMethod("/", c("H2OParsedData", "H2OParsedData"), function(e1, e2) { h2o.__binop2("/", e1, e2) })
setMethod("%%", c("H2OParsedData", "H2OParsedData"), function(e1, e2) { h2o.__binop2("%", e1, e2) })
setMethod("==", c("H2OParsedData", "H2OParsedData"), function(e1, e2) { h2o.__binop2("==", e1, e2) })
setMethod(">", c("H2OParsedData", "H2OParsedData"), function(e1, e2) { h2o.__binop2(">", e1, e2) })
setMethod("<", c("H2OParsedData", "H2OParsedData"), function(e1, e2) { h2o.__binop2("<", e1, e2) })
setMethod("!=", c("H2OParsedData", "H2OParsedData"), function(e1, e2) { h2o.__binop2("!=", e1, e2) })
setMethod(">=", c("H2OParsedData", "H2OParsedData"), function(e1, e2) { h2o.__binop2(">=", e1, e2) })
setMethod("<=", c("H2OParsedData", "H2OParsedData"), function(e1, e2) { h2o.__binop2("<=", e1, e2) })
setMethod("&", c("H2OParsedData", "H2OParsedData"), function(e1, e2) {h2o.__binop2("&&", e1, e2) })
setMethod("|", c("H2OParsedData", "H2OParsedData"), function(e1, e2) {h2o.__binop2("||", e1, e2) })

setMethod("+", c("numeric", "H2OParsedData"), function(e1, e2) { h2o.__binop2("+", e1, e2) })
setMethod("-", c("numeric", "H2OParsedData"), function(e1, e2) { h2o.__binop2("-", e1, e2) })
setMethod("*", c("numeric", "H2OParsedData"), function(e1, e2) { h2o.__binop2("*", e1, e2) })
setMethod("/", c("numeric", "H2OParsedData"), function(e1, e2) { h2o.__binop2("/", e1, e2) })
setMethod("%%", c("numeric", "H2OParsedData"), function(e1, e2) { h2o.__binop2("%", e1, e2) })
setMethod("==", c("numeric", "H2OParsedData"), function(e1, e2) { h2o.__binop2("==", e1, e2) })
setMethod(">", c("numeric", "H2OParsedData"), function(e1, e2) { h2o.__binop2(">", e1, e2) })
setMethod("<", c("numeric", "H2OParsedData"), function(e1, e2) { h2o.__binop2("<", e1, e2) })
setMethod("!=", c("numeric", "H2OParsedData"), function(e1, e2) { h2o.__binop2("!=", e1, e2) })
setMethod(">=", c("numeric", "H2OParsedData"), function(e1, e2) { h2o.__binop2(">=", e1, e2) })
setMethod("<=", c("numeric", "H2OParsedData"), function(e1, e2) { h2o.__binop2("<=", e1, e2) })
setMethod("&", c("numeric", "H2OParsedData"), function(e1, e2) {h2o.__binop2("&&", e1, e2) })
setMethod("|", c("numeric", "H2OParsedData"), function(e1, e2) {h2o.__binop2("||", e1, e2) })

setMethod("+", c("H2OParsedData", "numeric"), function(e1, e2) { h2o.__binop2("+", e1, e2) })
setMethod("-", c("H2OParsedData", "numeric"), function(e1, e2) { h2o.__binop2("-", e1, e2) })
setMethod("*", c("H2OParsedData", "numeric"), function(e1, e2) { h2o.__binop2("*", e1, e2) })
setMethod("/", c("H2OParsedData", "numeric"), function(e1, e2) { h2o.__binop2("/", e1, e2) })
setMethod("%%", c("H2OParsedData", "numeric"), function(e1, e2) { h2o.__binop2("%", e1, e2) })
setMethod("==", c("H2OParsedData", "numeric"), function(e1, e2) { h2o.__binop2("==", e1, e2) })
setMethod(">", c("H2OParsedData", "numeric"), function(e1, e2) { h2o.__binop2(">", e1, e2) })
setMethod("<", c("H2OParsedData", "numeric"), function(e1, e2) { h2o.__binop2("<", e1, e2) })
setMethod("!=", c("H2OParsedData", "numeric"), function(e1, e2) { h2o.__binop2("!=", e1, e2) })
setMethod(">=", c("H2OParsedData", "numeric"), function(e1, e2) { h2o.__binop2(">=", e1, e2) })
setMethod("<=", c("H2OParsedData", "numeric"), function(e1, e2) { h2o.__binop2("<=", e1, e2) })
setMethod("&", c("H2OParsedData", "numeric"), function(e1, e2) {h2o.__binop2("&&", e1, e2) })
setMethod("|", c("H2OParsedData", "numeric"), function(e1, e2) {h2o.__binop2("||", e1, e2) })

setMethod("!", "H2OParsedData", function(x) { h2o.__unop2("!", x) })
setMethod("abs", "H2OParsedData", function(x) { h2o.__unop2("abs", x) })
setMethod("sign", "H2OParsedData", function(x) { h2o.__unop2("sgn", x) })
setMethod("sqrt", "H2OParsedData", function(x) { h2o.__unop2("sqrt", x) })
setMethod("ceiling", "H2OParsedData", function(x) { h2o.__unop2("ceil", x) })
setMethod("floor", "H2OParsedData", function(x) { h2o.__unop2("floor", x) })
setMethod("log", "H2OParsedData", function(x) { h2o.__unop2("log", x) })
setMethod("exp", "H2OParsedData", function(x) { h2o.__unop2("exp", x) })
setMethod("sum", "H2OParsedData", function(x) { h2o.__unop2("sum", x) })
setMethod("is.na", "H2OParsedData", function(x) { h2o.__unop2("is.na", x) })

setGeneric("h2o.cut", function(x, breaks) { standardGeneric("h2o.cut") })
setMethod("h2o.cut", signature(x="H2OParsedData", breaks="numeric"), function(x, breaks) {
  nums = ifelse(length(breaks) == 1, breaks, paste("c(", paste(breaks, collapse=","), ")", sep=""))
  expr = paste("cut(", x@key, ",", nums, ")", sep="")
  res = h2o.__exec2(x@h2o, expr)
  if(res$num_rows == 0 && res$num_cols == 0)   # TODO: If logical operator, need to indicate
    return(res$scalar)
  new("H2OParsedData", h2o=x@h2o, key=res$dest_key)
})

h2o.table <- function(x) { h2o.__unop2("table", x) }
h2o.factor <- function(x) { h2o.__unop2("factor", x) }
h2o.runif <- function(x) { h2o.__unop2("runif", x) }

setMethod("colnames", "H2OParsedData", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT2, src_key=x@key)
  unlist(lapply(res$cols, function(y) y$name))
})

setMethod("names", "H2OParsedData", function(x) { colnames(x) })

setMethod("nrow", "H2OParsedData", function(x) { 
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT2, src_key=x@key); as.numeric(res$numRows) })

setMethod("ncol", "H2OParsedData", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT2, src_key=x@key); as.numeric(res$numCols) })

setMethod("min", "H2OParsedData", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT2, src_key=x@key)
  min(sapply(res$cols, function(x) { x$min }))
})

setMethod("max", "H2OParsedData", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT2, src_key=x@key)
  max(sapply(res$cols, function(x) { x$max }))
})

setMethod("range", "H2OParsedData", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT2, src_key=x@key)
  temp = sapply(res$cols, function(x) { c(x$min, x$max) })
  c(min(temp[1,]), max(temp[2,]))
})

setMethod("colMeans", "H2OParsedData", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT2, src_key=x@key)
  temp = sapply(res$cols, function(x) { x$mean })
  names(temp) = sapply(res$cols, function(x) { x$name })
  temp
})

setMethod("dim", "H2OParsedData", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT2, src_key=x@key)
  as.numeric(c(res$numRows, res$numCols))
})

setMethod("as.data.frame", "H2OParsedData", function(x) {
  url <- paste('http://', x@h2o@ip, ':', x@h2o@port, '/2/DownloadDataset?src_key=', x@key, sep='')
  ttt <- getURL(url)
  read.csv(textConnection(ttt))
})

setMethod("head", "H2OParsedData", function(x, n = 6L, ...) { 
  if(n == 0 || !is.numeric(n)) stop("n must be a non-zero integer")
  n = round(n)
  # if(abs(n) > nrow(x)) stop(paste("n must be between 1 and", nrow(x)))
  numRows = nrow(x)
  if(n < 0 && abs(n) >= numRows) return(data.frame())
  myView = ifelse(n > 0, min(n, numRows), numRows+n)
  if(myView > MAX_INSPECT_VIEW) stop(paste("Cannot view more than", MAX_INSPECT_VIEW, "rows"))
  
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT, key=x@key, offset=0, view=myView)
  temp = unlist(lapply(res$rows, function(y) { y$row = NULL; y }))
  if(is.null(temp)) return(temp)
  x.df = data.frame(matrix(temp, nrow = myView, byrow = TRUE))
  colnames(x.df) = unlist(lapply(res$cols, function(y) y$name))
  x.df
})

setMethod("tail", "H2OParsedData", function(x, n = 6L, ...) {
  if(n == 0 || !is.numeric(n)) stop("n must be a non-zero integer")
  n = round(n)
  # if(abs(n) > nrow(x)) stop(paste("n must be between 1 and", nrow(x)))
  numRows = nrow(x)
  if(n < 0 && abs(n) >= numRows) return(data.frame())
  myOff = ifelse(n > 0, max(0, numRows-n), abs(n))
  myView = ifelse(n > 0, min(n, numRows), numRows+n)
  if(myView > MAX_INSPECT_VIEW) stop(paste("Cannot view more than", MAX_INSPECT_VIEW, "rows"))
  
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT, key=x@key, offset=myOff, view=myView)
  temp = unlist(lapply(res$rows, function(y) { y$row = NULL; y }))
  if(is.null(temp)) return(temp)
  x.df = data.frame(matrix(temp, nrow = myView, byrow = TRUE))
  colnames(x.df) = unlist(lapply(res$cols, function(y) y$name))
  x.df
})

setMethod("is.factor", "H2OParsedData", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_SUMMARY2, source=x@key)
  # temp = sapply(res$summaries, function(x) { is.null(x$domains) })
  temp = sapply(res$summaries, function(x) { x$stats$type != "Enum" })
  return(!any(temp))
})

setMethod("quantile", "H2OParsedData", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_SUMMARY2, source=x@key)
  # temp = sapply(res$summaries, function(x) { x$percentileValues })
  temp = sapply(res$summaries, function(x) { x$stats$pctile })
  filt = !sapply(temp, is.null)
  temp = temp[filt]
  if(length(temp) == 0) return(NULL)
  
  # myFeat = res$names[filt[1:length(res$names)]]
  # myQuantiles = c(1, 5, 10, 25, 33, 50, 66, 75, 90, 95, 99)
  myFeat = sapply(res$summaries, function(x) { x$colname })
  myQuantiles = 100 * res$summaries[[1]]$stats$pct
  matrix(unlist(temp), ncol = length(myFeat), dimnames = list(paste(myQuantiles, "%", sep=""), myFeat))
})

setGeneric("histograms", function(object) { standardGeneric("histograms") })
setMethod("histograms", "H2OParsedData", function(object) {
  res = h2o.__remoteSend(object@h2o, h2o.__PAGE_SUMMARY2, source=object@key)
  list.of.bins <- lapply(res$summaries, function(x) {
    if (x$stats$type == 'Enum') {
      bins <- NULL
    } else {
      counts <- x$hcnt
      breaks <- seq(x$hstart, by=x$hstep, length.out=length(x$hcnt) + 1)
      bins <- list(counts,breaks)
      names(bins) <- cbind('counts', 'breaks')
    }
    bins
  })
  return(list.of.bins)
})

setMethod("summary", "H2OParsedData", function(object) {
  res = h2o.__remoteSend(object@h2o, h2o.__PAGE_SUMMARY2, source=object@key)
  cols <- sapply(res$summaries, function(col) {
    if(col$stats$type != 'Enum') { # numeric column
      if(is.null(col$stats$mins) || length(col$stats$mins) == 0) col$stats$mins = NaN
      if(is.null(col$stats$maxs) || length(col$stats$maxs) == 0) col$stats$maxs = NaN
      if(is.null(col$stats$pctile))
        params = format(rep(round(as.numeric(col$stats$mean), 3), 6), nsmall = 3)
      else
        params = format(round(as.numeric(c(
          col$stats$mins[1],
          col$stats$pctile[4],
          col$stats$pctile[6],
          col$stats$mean,
          col$stats$pctile[8],
          col$stats$maxs[1])), 3), nsmall = 3)
      result = c(paste("Min.   :", params[1], "  ", sep=""), paste("1st Qu.:", params[2], "  ", sep=""),
                 paste("Median :", params[3], "  ", sep=""), paste("Mean   :", params[4], "  ", sep=""),
                 paste("3rd Qu.:", params[5], "  ", sep=""), paste("Max.   :", params[6], "  ", sep="")) 
    }
    else {
      top.ix <- sort.int(col$hcnt, decreasing=T, index.return=T)$ix[1:6]
      domains <- col$hbrk[top.ix]
      counts <- col$hcnt[top.ix]
      width <- max(cbind(nchar(domains), nchar(counts)))
      result <- paste(domains,
                      mapply(function(x, y) { paste(rep(' ',max(width + 1 - nchar(x) - nchar(y),0)), collapse='') }, domains, counts),
                      ":",
                      counts,
                      " ",
                      sep='')
      result[is.na(top.ix)] <- NA
      result
    }
  })
  
  result = as.table(cols)
  rownames(result) <- rep("", 6)
  colnames(result) <- sapply(res$summaries, function(col) col$colname)
  result
})

setMethod("apply", "H2OParsedData", function(X, MARGIN, FUN, ...) {
  params = c(X@key, MARGIN, paste(deparse(substitute(FUN)), collapse=""))
  expr = paste("apply(", paste(params, collapse=","), ")", sep="")
  res = h2o.__exec2(X@h2o, expr)
  new("H2OParsedData", h2o=X@h2o, key=res$dest_key)
})

#--------------------------------- ValueArray ----------------------------------#
setMethod("show", "H2ORawDataVA", function(object) {
  print(object@h2o)
  cat("Raw Data Key:", object@key, "\n")
})

setMethod("show", "H2OParsedDataVA", function(object) {
  print(object@h2o)
  cat("Parsed Data Key:", object@key, "\n")
})

setMethod("show", "H2OGLMModelVA", function(object) {
  print(object@data)
  cat("GLM Model Key:", object@key, "\n\nCoefficients:\n")
  
  model = object@model
  print(round(model$coefficients,5))
  cat("\nDegrees of Freedom:", model$df.null, "Total (i.e. Null); ", model$df.residual, "Residual\n")
  cat("Null Deviance:    ", round(model$null.deviance,1), "\n")
  cat("Residual Deviance:", round(model$deviance,1), " AIC:", round(model$aic,1), "\n")
  cat("Avg Training Error Rate:", round(model$train.err,5), "\n")
  
  # if(model$family == "binomial") {
  if(model$family$family == "binomial") {
    cat("AUC:", round(model$auc,5), " Best Threshold:", round(model$threshold,5), "\n")
    cat("\nConfusion Matrix:\n"); print(model$confusion)
  }
  
  if(length(object@xval) > 0) {
    cat("\nCross-Validation Models:\n")
    # if(model$family == "binomial") {
    if(model$family$family == "binomial") {
      modelXval = t(sapply(object@xval, function(x) { c(x@model$threshold, x@model$auc, x@model$class.err) }))
      colnames(modelXval) = c("Best Threshold", "AUC", "Err(0)", "Err(1)")
    } else {
      modelXval = sapply(object@xval, function(x) { x@model$train.err })
      modelXval = data.frame(modelXval)
      colnames(modelXval) = c("Error")
    }
    rownames(modelXval) = paste("Model", 0:(nrow(modelXval)-1))
    print(modelXval)
  }
})

setMethod("show", "H2OGLMGridVA", function(object) {
  print(object@data)
  cat("GLMGrid Model Key:", object@key, "\n")
  
  temp = data.frame(t(sapply(object@sumtable, c)))
  cat("\nSummary\n"); print(temp)
})

setMethod("colnames", "H2OParsedDataVA", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT, key=x@key)
  unlist(lapply(res$cols, function(y) y$name))
})

setMethod("names", "H2OParsedDataVA", function(x) { colnames(x) })

setMethod("nrow", "H2OParsedDataVA", function(x) { 
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT, key=x@key); as.numeric(res$num_rows) })

setMethod("ncol", "H2OParsedDataVA", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT, key=x@key); as.numeric(res$num_cols) })

setMethod("dim", "H2OParsedDataVA", function(x) {
  res = h2o.__remoteSend(x@h2o, h2o.__PAGE_INSPECT, key=x@key)
  as.numeric(c(res$num_rows, res$num_cols))
})

setMethod("head", "H2OParsedDataVA", function(x, n = 6L, ...) { 
  head(new("H2OParsedData", h2o=x@h2o, key=x@key), n, ...)
})

setMethod("tail", "H2OParsedDataVA", function(x, n = 6L, ...) {
  tail(new("H2OParsedData", h2o=x@h2o, key=x@key), n, ...)
})
          
setMethod("summary", "H2OParsedDataVA", function(object) {
  res = h2o.__remoteSend(object@h2o, h2o.__PAGE_SUMMARY, key=object@key)
  res = res$summary$columns
  result = NULL; cnames = NULL
  for(i in 1:length(res)) {
    cnames = c(cnames, paste("      ", res[[i]]$name, sep=""))
    if(res[[i]]$type == "number") {
      if(is.null(res[[i]]$min) || length(res[[i]]$min) == 0) res[[i]]$min = NaN
      if(is.null(res[[i]]$max) || length(res[[i]]$max) == 0) res[[i]]$max = NaN
      if(is.null(res[[i]]$mean) || length(res[[i]]$mean) == 0) res[[i]]$mean = NaN
      if(is.null(res[[i]]$percentiles))
        params = format(rep(round(as.numeric(res[[i]]$mean), 3), 6), nsmall = 3)
      else
        params = format(round(as.numeric(c(res[[i]]$min[1], res[[i]]$percentiles$values[4], res[[i]]$percentiles$values[6], res[[i]]$mean, res[[i]]$percentiles$values[8], res[[i]]$max[1])), 3), nsmall = 3)
      result = cbind(result, c(paste("Min.   :", params[1], "  ", sep=""), paste("1st Qu.:", params[2], "  ", sep=""),
                               paste("Median :", params[3], "  ", sep=""), paste("Mean   :", params[4], "  ", sep=""),
                               paste("3rd Qu.:", params[5], "  ", sep=""), paste("Max.   :", params[6], "  ", sep="")))                 
    }
    else if(res[[i]]$type == "enum") {
      col = matrix(rep("", 6), ncol=1)
      len = length(res[[i]]$histogram$bins)
      for(j in 1:min(6,len))
        col[j] = paste(res[[i]]$histogram$bin_names[len-j+1], ": ", res[[i]]$histogram$bins[len-j+1], sep="")
      result = cbind(result, col)
    }
  }
  result = as.table(result)
  rownames(result) <- rep("", 6)
  colnames(result) <- cnames
  result
})