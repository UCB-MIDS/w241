library(data.table)
library(plm)
library(lmtest)
library(sandwich)

## Let's make data, as we typicall have done, but now, we're going to be observing
## each individual across two time periods. And, we're going to use one of the
## more interesting experiemntal designs that are available to us:
##
##  - a two-group, switching design
##
## For this, we're going to create two groups:
##
##  - The A group will receive control first, and then treatment second
##  - The B group will receive treatment first, and then control second 
##
## To further fit with the reality of repeatedly observing people, lets'
## presume that people get better over time.
##
NROWS = 100

d <- data.table(
    id = rep(1:NROWS, each = 2)
)

d[ , group := rep(LETTERS[1:2], each = .N/2)]
d[ , time  := rep(0:1)]

d[group=='A' & time==0, treat := 0]
d[group=='A' & time==1, treat := 1]
d[group=='B' & time==0, treat := 1]
d[group=='B' & time==1, treat := 0]

## we're going to structure the outcomes in the following way:
##
##  - y00: y0, in time 0
##  - y01: y0, in time 1
##  - y10: y1, in time 0
##  - y11: y1, in time 1
##
## 
d[time==0 , po_control:= runif(.N, -10, 10)]

## suppose there is a two unit treatment effect in the first
## time period. This means that 
d[time==0 , po_treat:= po_control + rnorm(.N, 2, 1)]

## suppose that all individuals get one unit better through time
## that is, independent of their treatment/control/group assignment
## you just get better/smarter/more practiced at the task through time
##
## everybody gets one unit better through time
##
## Don't worry, we (the faculty) still have to resort to klugy manuvers
## in data manipulation from time to time...
## ... here, we're going to make a new column, called tmp, and put into it
## the first potential outcome (from control in time period 1) plus the
## time improvement effect, then we're going to sub that into the second slot
## in the `po_control` variable, then we're going to drop the `tmp` column. 
d[ , tmp := po_control[1] + rnorm(.N, 1, 1), by = .(id)][is.na(po_control), po_control := tmp][ , tmp:= NULL]

d[is.na(po_treat), po_treat := po_control + rnorm(.N, 2, 1)]

## and so, if you're in treatment in the second period, you're two
## units on average better than your potential outcome to control in that
## time period

d[time==0, mean(po_treat - po_control)]
d[time==1, mean(po_treat - po_control)]

## Likewise, within an individual, the difference between their 

d[ , .(
    control_diffs = diff(po_control),
    treat_diffs   = diff(po_treat)),
  by = .(id)
  ][ , .(
     average_control_diffs = mean(control_diffs),
     average_treat_diffs   = mean(treat_diffs))
     ]


## Great! The data is set up for us. 
## But, of course, as ever, we don't get all this data. We only get a piece of it,
## namely the piece that corresponds to the treatment that someon was assigned to.

d[treat==0 , Y := po_control]
d[treat==1,  Y := po_treat]

## With this, we could estimate a simple linear model.

mod <-  d[ , lm(Y ~ treat)]
summary(mod)

## And, the good news is that this does a pretty good job of recovering an unbiased
## estiamte of the treatment effect. However, we're missing the _super_ important information
## about the person's baseline values. What would happen if we include a factor indicator
## for the person's ID? This is going to pull out their average, isn't it?

mod_1 <- d[ , lm(Y ~ treat + as.factor(id))]
summary(mod_1)

## Nice!

## However, what is missing in this is the acknowledgment that we've seen this person twice,
## and so, that their potential outcomes are linked to one another (and so not independent).
## To acknowledge this, we cluster the estimates in this model on the thing that defines the
## cluster -- namely, the `id` of the person. 

coeftest(mod_1, vcovCL(mod_1, cluster = d[ , .(id)]))[1:10, ]
coeftest(mod_1)[1:10, ]

## Note that:
##  1. The test statistic is smaller than when we fail to acknowledge this clustering
##     structure; but,
##  2. Larger than when we failed to use the person information in the analysis.

## One way to think of this is that without the person information, we have conducted
## a between-subjects experient. When we include the person indicator, our analysis
## then acknowledges that we have conducted a within-subjects experment; and when
## we finally correct the standard errors to acknowledge that the data is related,
## we have a result that have appropriate false-discovery rates. 

##
## Simulate the problem without clustering the standard errors
##

## In this next section, we're going to take all the content that we've got through
## to this point, wrap it in a function, and make ONE IMPORTANT CHANGE:
##
## - We're going to construct the data so that there is exactly zero treatment effect
##
## Our hope is that we can show that when we analyze the data as a within subjects
## design, but fail to cluster the standard errors, that we have a false discovery
## rate that is too high; but that when we cluster the standard errors, the false
## discovery rate again corresponds to the pvalue we've chosen.

simulate_and_analyze_effect <- function(effect_size=0) { 
    ## In this function, there is still the improvement over time,
    ## but there is no treatment effect.
    
    NROWS = 100

    d <- data.table(
        id = rep(1:NROWS, each = 2)
    )

    d[ , group := rep(LETTERS[1:2], each = .N/2)]
    d[ , time  := rep(0:1)]

    d[group=='A' & time==0, treat := 0]
    d[group=='A' & time==1, treat := 1]
    d[group=='B' & time==0, treat := 1]
    d[group=='B' & time==1, treat := 0]

    d[time==0 , po_control:= runif(.N, -10, 10)]

    ## NOTICE THAT THIS HAS A MEAN ZERO UNDER DEFAULT ARGUMENTS
    d[time==0 , po_treat:= po_control + rnorm(.N, effect_size, 1)] 

    d[ , tmp := po_control[1] + rnorm(.N, 1, 1), by = .(id)][is.na(po_control), po_control := tmp][ , tmp:= NULL]

    ## NOTICE THAT THIS ALSO HAS A MEAN ZERO UNDER DEFAULT ARGUMENTS
    d[is.na(po_treat), po_treat := po_control + rnorm(.N, effect_size, 1)]

    d[treat==0 , Y := po_control]
    d[treat==1,  Y := po_treat]

    ## start pulling p-values
    between_model <- d[ , lm(Y ~ treat)]
    between_subjects_estimate <-  coeftest(between_model)[2,4]

    within_model <- d[ , lm(Y ~ treat + as.factor(id))]
    
    within_no_clustering   <- coeftest(within_model)[2,4]
    within_with_clustering <- coeftest(within_model, vcovCL(within_model, d[, id]))[2,4]

    res_dt <- data.table(between_subjects_estimate, within_no_clustering, within_with_clustering)

    return(res_dt)
}

## FIRST SIMULATE WITH A ZERO EFFECT 
NSIMS = 1000
res_list <- vector(mode='list', length = NSIMS)

for(sim in 1:NSIMS) {
    res_list[[sim]] <- simulate_and_analyze_effect(effect_size=0)
}

res_list <- rbindlist(res_list)

res_list[ , .(
    m1 = mean(between_subjects_estimate < 0.05),
    m2 = mean(within_no_clustering < 0.05),
    m3 = mean(within_with_clustering < 0.05)
)]

## NOW DO IT WITH AN EFFECT THAT IS 1 
NSIMS = 1000
res_list <- vector(mode='list', length = NSIMS)

for(sim in 1:NSIMS) {
    res_list[[sim]] <- simulate_and_analyze_effect(effect_size=1)
}

res_list <- rbindlist(res_list)

res_list[ , .(
    m1 = mean(between_subjects_estimate < 0.05),
    m2 = mean(within_no_clustering < 0.05),
    m3 = mean(within_with_clustering < 0.05)
)]

## How do I interpret this?
##
## In failing to cluster the estiamte means that we have a false
## discovery rate in these experiments that is 20 times higher than
## when we _do_ cluster.
##
## But, when we do cluster, there is no decrease in the power of the test
## to find an effect. At least, not in a sample that is shaped like
## this one. 
