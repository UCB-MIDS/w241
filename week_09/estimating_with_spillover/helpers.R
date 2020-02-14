#### Source code for Spillover App
library(randomizr)
library(gplots)

get_condition <- function(assign, adjmat){
  exposure <-  adjmat %*% assign
  condition <- rep("00", length(assign))
  condition[assign==1 & exposure==0] <- "10"
  condition[assign==0 & exposure>0] <- "01"
  condition[assign==1 & exposure>0] <- "11"
  return(condition)
}

get_Y <- function(cond, Y00, Y01, Y10, Y11){
  Y <- Y00
  Y[cond=="10"] <- Y10[cond=="10"]
  Y[cond=="01"] <- Y01[cond=="01"]
  Y[cond=="11"] <- Y11[cond=="11"]
  return(Y)
}

get_prob <- function(cond,prob00,prob01,prob10, prob11){
  prob <- prob00
  prob[cond=="10"] <- prob10[cond=="10"]
  prob[cond=="01"] <- prob01[cond=="01"]
  prob[cond=="11"] <- prob11[cond=="11"]
  return(prob)
}

estimator_ipw <- function(Y, cond, prob,prob00,prob01,prob10, prob11){
  df <- data.frame(Y, cond, prob, prob00, prob01, prob10, prob11)
  indirect <- try(with(subset(df, prob00 >0 & prob00 <1 & prob01 >0 & prob01 < 1), weighted.mean(Y[cond=="01"], 1/prob[cond=="01"]) - weighted.mean(Y[cond=="00"], 1/prob[cond=="00"])))
  direct <- try(with(subset(df, prob00 >0 & prob00 <1 & prob10 >0 & prob10 < 1), weighted.mean(Y[cond=="10"], 1/prob[cond=="10"]) - weighted.mean(Y[cond=="00"], 1/prob[cond=="00"])))
  indirect_direct <- try(with(subset(df, prob00 >0 & prob00 <1 & prob11 >0 & prob11 < 1), weighted.mean(Y[cond=="11"], 1/prob[cond=="11"]) - weighted.mean(Y[cond=="00"], 1/prob[cond=="00"])))
  return(c(indirect, direct, indirect_direct))
}