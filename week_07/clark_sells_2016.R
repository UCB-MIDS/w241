###### MULTIPLE COMPARISONS DEMO ######

## 
## written by Julia Clark and Cameron Sells @ UCSD
## You, (MIDS students) could consider emailing them as a thanks.
##

## jmc003@ucsd.edu and csells@ucsd.edu 

# Suppose we have a GOTV experiment...
# DV: "Voted": Whether the subject voted (binary)
# Our treatment variable is called "Treated." 

# This creates a mock experimental dataset
set.seed(10000000)
n <- 6000
data <- data.frame(PID = sample(90000000:95500000, n), 
                   MunicipalityID = 1:20,
                   Age = rpois(n, 40), 
                   Education = rbinom(n, 6, .2)+1, 
                   Income = ceiling(rexp(n, .001)), 
                   Treated = sample(c(rep(1, round(.4*n)), rep(0, round(.6*n)))) )
data$MunicipalityID[1:(.16*n)] <- 1
data$Voted <- rbinom(n, 1, pnorm(-30 + 3.5*data$Education + 1.5*log(data$Income) + 0*data$Treated + .5*data$Age + rnorm(n, 0, 10)) )
head(data)

# Note that the treatment has no effect on turnout. 
summary(lm(Voted ~ Education + log(Income) + Age + Treated, data=data))

# We have 6000 observations across 20 municipalities. Municipality 1 is the capital city, 
# and it accounts for around 20% of our sample.
table(data$MunicipalityID)

# We are interested in whether there are heterogenous treatment effects across municipalities,
# and especially whether the treatment effect is different for the city compared to the rural municipalities in the hinterland.

# In order to investigate the presence of heterogenous effects, we interact the treatment variable with municipality
mod <- lm(Voted ~ Education + log(Income) + Age + factor(MunicipalityID) + Treated + Treated:factor(MunicipalityID), data=data)
summary(mod)

# Just by random chance, two villages have a treatment effect different from that of the city

SiteEffectsDifference <- coef(mod)[25:43]
SEs <- summary(mod)$coefficients[25:43,2]
pvalues <- summary(mod)$coefficients[25:43,4]
k <- length(SiteEffectsDifference)

# Plot of difference between village and city site effects
plot(2:20, SiteEffectsDifference, ylim=c(-.2, .25), xlab="Municipality", ylab="Village Effect - City Effect")
segments(x0=2:20, SiteEffectsDifference - 1.96*SEs, y1=SiteEffectsDifference + 1.96*SEs, lwd=4)
abline(h=0)
points(2:20, SiteEffectsDifference, pch=ifelse(pvalues < 0.05, 19, 21), bg="white", cex=.8)



## BONFERRONI CORRECTION
# For a Bonferroni correction, we can EITHER adjust the significance-level or adjust the p-values themselves.

# To adjust the p-values:
bonferroni.pvalues <- p.adjust(pvalues, "bonferroni")
bonferroni.pvalues

# This is equivalent to
ifelse(pvalues*k < 1, pvalues*k, 1)


# To adjust the significance-level (and therefore the confidence intervals):
bonfer <- function(alpha, k){
  alpha/k
}

threshold.bonferroni <- bonfer(0.05, 19)
threshold.bonferroni
pvalues < threshold.bonferroni

# Same plot as before, but with adjusted confidence intervals
plot(2:20, SiteEffectsDifference, ylim=c(-.2, .25), xlab="Municipality", ylab="Village Effect - City Effect")
segments(x0=2:20, SiteEffectsDifference - abs(qnorm(threshold.bonferroni/2))*SEs, y1=SiteEffectsDifference + abs(qnorm(threshold.bonferroni/2))*SEs, lwd=4)
abline(h=0)
points(2:20, SiteEffectsDifference, pch=ifelse(bonferroni.pvalues < 0.05, 19, 21), bg="white", cex=.8)


## OTHER COMMON CORRECTIONS:
# Holm Correction and Benjamini-Hochberg Correction
p.adjust(pvalues, "holm")
p.adjust(pvalues, "BH")

# And many others...

# Compared:
Corrections <- c()
for(i in c("holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none")){
  Corrections <- rbind(Corrections, p.adjust(pvalues, i))
}
rownames(Corrections) <- c("holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none")
Corrections


## FINDING THRESHOLD P-VALUES THROUGH SIMULATION
# (Adapted from http://egap.org/methods-guides/10-things-you-need-know-about-multiple-comparisons)

# The basic idea here is that we are going to simulate site effects by randomly re-assigning 
# the treatment a bunch of times, and then we are going to use the p-values from these simulated effects to
# identify which threshold significance level gives us a family-wise error rate of 0.05.

p.sims <- matrix(NA, nrow=19, ncol=1000)
# This loop calculates new sets of p-values for 1000 rerandomizations (normally, we would want to do more than 1000)
for(i in 1:1000){
  re.data <- data
  
  # Reassigns treatment
  re.data$Treated <- sample(c(rep(1, round(.4*n)), rep(0, round(.6*n))))
  
  # Recalculates the site effects for the rerandomized data
  mod <- lm(Voted ~ Education + log(Income) + Age + factor(MunicipalityID) + Treated + Treated:factor(MunicipalityID), data=re.data)
  
  # Saves the p-values from that rerandomization
  p.values <- summary(mod)$coefficients[25:43,4]
  p.sims[,i] <- p.values
}

threshold.finder <- function(threshold){
  # This helper-function returnes TRUE if one or more of the p-values from the re-randomization
  # trial is below a given threshold alpha, and FALSE otherwise (this is the family-wise hypothesis test)
  mean(apply(p.sims, 2, x <- function(x) any(x < threshold) ))
}

# This creates a vector of possible threshold levels between 0 and 0.05
thresholds <- seq(0, 0.05, length.out = 1000)

# This runs the tresthold.finder() function on each of the possible threshold values that
# we just created. It tells us the Family-wise Type I error rate for each threshold value
FWER <- sapply(thresholds, threshold.finder)
cbind(thresholds, FWER)

# This identifies which of the possible threshold values yields a family-wise Type I error rate
# of 0.05
threshold.sim <- thresholds[max(which(FWER <= 0.05))]
threshold.sim

# Which of our original p-values are below this threshold?
pvalues < threshold.sim



## HOW CLOSE DO THESE CORRECTIONS GET TO A FWER OF 0.05?
unadjusted.reject <- c()
bonferroni.reject <- c()
holm.reject <- c()
BH.reject <- c()
s <- 1000
for(i in 1:s){
  # Reassigns treatment
  re.data <- data
  re.data$Treated <- sample(c(rep(1, floor(.4*6000)), rep(0, ceiling(.6*6000))))
  
  # Estimating equation and p-values
  mod <- lm(Voted ~ Education + log(Income) + Age + factor(MunicipalityID) + Treated + Treated:factor(MunicipalityID), data=re.data)
  p.values <- summary(mod)$coefficients[25:43,4]
  
  # For each of the methods of caluclating p-values, the values of this trial is TRUE
  # if we reject the null hypothesis for at least one site, and FALSE otherwise
  unadjusted.reject <- c(unadjusted.reject, any(p.values < 0.05))
  bonferroni.reject <- c(bonferroni.reject, any(p.adjust(p.values, "bonferroni") < 0.05))
  holm.reject <- c(holm.reject, any(p.adjust(p.values, "holm") < 0.05))
  BH.reject <- c(BH.reject, any(p.adjust(p.values, "BH") < 0.05))
}
mean(unadjusted.reject)
mean(bonferroni.reject)
mean(holm.reject)
mean(BH.reject)


