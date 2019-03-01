library(data.table)
library(plm)

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

mod_0<-  d[ , lm(Y ~ treat)]
summary(mod_0)

## And, the good news is that this does a pretty good job of recovering an unbiased
## estiamte of the treatment effect. However, we're missing the _super_ important information
## about the person's baseline values. What would happen if we include a factor indicator
## for the person's ID? This is going to pull out their average, isn't it?

mod_1 <- d[ , lm(Y ~ treat + as.factor(id))]
summary(mod_1)

## Nice! We can do even better using the time indicator in the model as well.

mod_2 <- d[ , lm(Y ~ treat + time + as.factor(id))]
summary(mod_2)

## But, here's the thing. Because we've got autocorrelaetion through time,
## we're not actually _this_ sure of the location of the estimates.
##
## In particular, the simple OLS regression is treating each of these outcomes
## as being _totally_ unrelated from the othres. This is ok, except for the
## problem that 1/2 of the observations are directly related to the other 1/2
## this is the autocorrelation problem.

## Luckly, the correction for this is relatively simple. Just acknowledge
## that the 'id' variable relates one obseration to another observation.
##
## We could do something tricky with a panel model estimation, but we can get the
## same effect from just estimating with clustered standard errors.

coeftest(mod_2, vcovCL(mod_2, cluster = d[ ,id]))

## You'll notice that our test statistic is slightly smaller than when we
## failed to acknowledge this relationship. This is the penalty that we've
## paid for observing the same person twice.

## But, you'll also notice that this is *WAY WAY WAY* better powered than the
## first model that we fit that did not use the within-person design.

summary(mod_0)
