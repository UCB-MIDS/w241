Extreme Values Bounds
================
Alex
2/8/2020

``` r
library(data.table)
library(sandwich)
library(stargazer)

robust_se <- function(mod, type = 'HC3') { 
  sqrt(diag(vcovHC(mod, type)))
  }
```

In this yoga, you are going to learn about extreme values bounds.

Let’s start with the data that we finished using in the last yoga.
Recall:

1.  The actual treatment effect is 2.
2.  When there was no attrition, we were able to easily estimate this
    effect. 3. When there was random attrition, we were less efficient
    in our estimates, but we were not biased.
3.  When attrition was associated with outcomes and the treatment – the
    highest people in treatment got bored and chose to leave the
    experiment – all bets were off. Estimates in this space are
    potentially arbitrarily distant from zero.

# Recreate the same data

``` r
d <- data.table(id = 1:10000)

d[ , ':='(
  x1 = runif(n = .N, min = 0, max = 5),
  d  = sample(c(0L,1L), size = .N, replace = TRUE),
  missing = 0L)
  ]
```

``` r
d[ , y := 1 + (2 * x1) + (2 * d) + rnorm(.N)]
```

``` r
mod_fully_observed_1 <- d[ , lm(y ~ d)]
mod_fully_observed_2 <- d[ , lm(y ~ d + x1)]
```

``` r
d[d == 0, missing := rbinom(.N, 1, .25)]
d[d == 1, missing := rbinom(.N, 1, .25)]
d[d == 1 & y > 7 , missing := rbinom(.N, 1, .9)]
```

Differently than last time, in this file, we are going to represent
missing data differently. Rather than that person simply not creating a
row in our data frame (as was the case last time), suppose that the
person creates an initial record, but then does not produce any further
records.

That is, suppose that this person’s value for `y` are NA if they are an
attriter.

``` r
d[missing == 1, y := NA]
```

# Reminder of the problem

When one estimates in the presence of nonrandom attrition, if they have
the *magic bullet* covariate that explains everything, then they might
be able to recover a reliable estimate. But, I’d like to wish for a pony
while I’m at it.

``` r
mod_nonrandom_attrition_1 <- d[ , lm(y ~ d)]
```

``` r
stargazer(
  mod_fully_observed_1, 
  mod_nonrandom_attrition_1,
  type = 'text', 
  se = list(
    robust_se(mod_fully_observed_1), 
    robust_se(mod_nonrandom_attrition_1)
  ), 
  omit.stat = c('ser', 'F')
)
```

    ## 
    ## =========================================
    ##                  Dependent variable:     
    ##              ----------------------------
    ##                           y              
    ##                   (1)            (2)     
    ## -----------------------------------------
    ## d               1.986***      -0.269***  
    ##                 (0.061)        (0.075)   
    ##                                          
    ## Constant        5.987***      5.999***   
    ##                 (0.043)        (0.050)   
    ##                                          
    ## -----------------------------------------
    ## Observations     10,000         5,585    
    ## R2               0.096          0.002    
    ## Adjusted R2      0.096          0.002    
    ## =========================================
    ## Note:         *p<0.1; **p<0.05; ***p<0.01

# Extreme Values Bounds

Extreme values bounds use a lucid set of assumptions to characterize
*how large or small* a treatment effect *might have been* if it had been
possible to observe all of the data.

The algorithm for producing these bounds follows these steps:

1.  Assume that all of the data that you did not observe was actually a
    very small value.
    1.  Fill in the missing values with this very small value.
    2.  Estimate your treatment estimator with this data filled in.
2.  Assume that all of the data that you did not observe was actually a
    very large value.
    1.  Fill in the missing values with this very large value.
    2.  Estimate your treatment estimator with this data filled in.

Left to the data scientist is *just how small* and *just how large* are
those values that are being filled in.

  - For this yoga, assume that the people who did not report their data
    were drawn from the 100% quantile of the observed data.

## Fill with low values

``` r
small_y <- d[ , min(y, na.rm = TRUE)]

d[ , y_low := y]
d[is.na(y_low), y_low := small_y]

mod_nonrandom_attrition_low <- d[ , lm(y_low ~ d)]
```

## Fill with high values

``` r
large_y <- d[ , max(y, na.rm = TRUE)]

d[ , y_high := y]
d[is.na(y_high), y_high := large_y]

mod_nonrandom_attrition_high <- d[ , lm(y_high ~ d)]
```

``` r
stargazer(
  mod_fully_observed_1, 
  mod_nonrandom_attrition_1, 
  mod_nonrandom_attrition_low, 
  mod_nonrandom_attrition_high,
  type = 'text', 
  se = list(
    robust_se(mod_fully_observed_1), 
    robust_se(mod_nonrandom_attrition_1),
    robust_se(mod_nonrandom_attrition_low),
    robust_se(mod_nonrandom_attrition_high)
  ), 
  omit.stat = c('ser', 'F')
)
```

    ## 
    ## ==================================================
    ##                       Dependent variable:         
    ##              -------------------------------------
    ##                      y            y_low    y_high 
    ##                (1)       (2)       (3)      (4)   
    ## --------------------------------------------------
    ## d            1.986*** -0.269*** -3.179*** 3.463***
    ##              (0.061)   (0.075)   (0.084)  (0.096) 
    ##                                                   
    ## Constant     5.987*** 5.999***  4.013***  8.296***
    ##              (0.043)   (0.050)   (0.062)  (0.068) 
    ##                                                   
    ## --------------------------------------------------
    ## Observations  10,000    5,585    10,000    10,000 
    ## R2            0.096     0.002     0.126    0.115  
    ## Adjusted R2   0.096     0.002     0.126    0.115  
    ## ==================================================
    ## Note:                  *p<0.1; **p<0.05; ***p<0.01

# Reasoning

Was it reasonable to assume that the data we didn’t see was drawn from
the 100th percentile? Maybe. It could have been the case that the people
who attrited were attriters from the 110th percentile of the observed
distribution. Or, it could be that they were from the 50th percentile of
the observed distribution.

You can try to do some sleuthing; and, you could create a model that
predicts the levels of the outcome that the person *would have had* if
they had reported their data. But, ultimately, because you lack ground
truth data on this, it would be impossible to ever know how well your
model is doing.

## Try it yourself

Rather than setting `y_low` and `y_high` to be the 100th percentile of
the observed values, instead, set them to be at the 25th and 75th
percentile values.

What should the consequences of this **much stronger** set of
assumptions be for these estimates? Should the bounds that you estimate
be larger, smaller, or unchanged?
