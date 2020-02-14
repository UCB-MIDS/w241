Yoga: Attrition
================
Alex
2/8/2020

``` r
library(data.table)
library(stargazer)
library(sandwich)
library(lmtest)
library(ggplot2)

theme_set(theme_minimal())

robust_se <- function(mod, type = 'HC3') { 
  sqrt(diag(vcovHC(mod, type)))
  }
```

# Problem Setup

Let’s begin by creating the right-hand side data that will feed into the
determination about whether a unit is observed or not. Because we are
dealing with relatively finicky estimates, let’s create quite a bit of
data. This way, *when* thing go wrong, we’ll be certain that it isn’t
the sampling process that has caused the problem.

``` r
d <- data.table(id = 1:10000)

d[ , ':='(
  x1 = runif(n = .N, min = 0, max = 5),
  d  = sample(c(0L,1L), size = .N, replace = TRUE),
  missing = 0L)
  ]
```

Notice that, as a baseline, we’ve decided to make *none* of the data be
missing. That is, all of this data is observed.

If we have the right hand side data built, we can now write down the
function that creates the outcome data.

``` r
d[ , y := 1 + (2 * x1) + (2 * d) + rnorm(.N)]
```

Rather unsurprisingly, with all of the data fully observed, the simple
OLS regression estimator produces an unbiased estimate of the treatment
effect. And, when we include a predictive (good) covariate the
efficiency of the estimate increases, and the treatment effect does not
change.

``` r
mod_fully_observed_1 <- d[ , lm(y ~ d)]
mod_fully_observed_2 <- d[ , lm(y ~ d + x1)]

stargazer(
  mod_fully_observed_1, mod_fully_observed_2, 
  type = 'text', 
  se = list(
    robust_se(mod_fully_observed_1), 
    robust_se(mod_fully_observed_2)
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
    ## d               2.009***      2.015***   
    ##                 (0.061)        (0.020)   
    ##                                          
    ## x1                            1.995***   
    ##                                (0.007)   
    ##                                          
    ## Constant        5.988***      1.023***   
    ##                 (0.043)        (0.023)   
    ##                                          
    ## -----------------------------------------
    ## Observations     10,000        10,000    
    ## R2               0.098          0.902    
    ## Adjusted R2      0.098          0.902    
    ## =========================================
    ## Note:         *p<0.1; **p<0.05; ***p<0.01

# Attrition at random

The best case of a bad problem is that attrition occurs completely at
random. Suppose that we have a **really** bad case of the data-dropsies
and 80% of our sample attrits. *But*, suppose that they drop out in a
way that is not related to treatment assignment.

``` r
d_random_attrition <- d[sample(1:.N, size = 2000), ]
```

Among these folks, we can estimate the same model as before.

``` r
mod_random_attrition <- d_random_attrition[ , lm(y ~ d + x1)]

stargazer(
  mod_fully_observed_1, mod_fully_observed_2, mod_random_attrition,
  type = 'text', 
  se = list(
    robust_se(mod_fully_observed_1), 
    robust_se(mod_fully_observed_2), 
    robust_se(mod_random_attrition)
  ), 
  omit.stat = c('ser', 'F')
)
```

    ## 
    ## ==========================================
    ##                   Dependent variable:     
    ##              -----------------------------
    ##                            y              
    ##                 (1)       (2)       (3)   
    ## ------------------------------------------
    ## d            2.009***  2.015***  2.033*** 
    ##               (0.061)   (0.020)   (0.045) 
    ##                                           
    ## x1                     1.995***  2.006*** 
    ##                         (0.007)   (0.016) 
    ##                                           
    ## Constant     5.988***  1.023***  0.975*** 
    ##               (0.043)   (0.023)   (0.049) 
    ##                                           
    ## ------------------------------------------
    ## Observations  10,000    10,000     2,000  
    ## R2             0.098     0.902     0.903  
    ## Adjusted R2    0.098     0.902     0.903  
    ## ==========================================
    ## Note:          *p<0.1; **p<0.05; ***p<0.01

Unsurprisingly (hopefully) you’ll see that there is no change in the
parameter estimates for treatment or the covariates.

# Missingness Potentially at Random

In general, it is unlikely to be the case that when there is missingness
it has occurred completely at random. Or at least, because you can’t see
the data for the people who don’t give you their data, you’ll never be
able to credibly, dispositively assert that missingness occurred at
random. :sweat\_smile:.

What happens as a consequence of this missingness? As you might have
anticipated, it breaks the two group estimator so that it now estimates
something that is not guaranteed to be an unbiased estimator of the
causal effect.

## Make Non Random Missingness

Let’s make non random missingness in the following way:

  - For the control, 25% of the population chooses not to respond;
  - For the treatment group, the same 25% of the population chooses not
    to respond; but,
  - In addition, the highest scoring people are also bored with your
    experiment, and so choose not to respond at higher rates.

<!-- end list -->

``` r
d[d == 0, missing := rbinom(.N, 1, .25)]
d[d == 1, missing := rbinom(.N, 1, .25)]
d[d == 1 & y > 7 , missing := rbinom(.N, 1, .9)]

d_nonrandom_attrition <- d[missing == 0]
```

*Question for pondering:*

  - How many people will there be represented in our data now?
  - Which direction do you think that our treatment effect will be
    biased?

<!-- end list -->

``` r
ggplot(d, aes(y, fill = as.factor(d))) + 
  geom_histogram(bins = 10, position = 'dodge')
```

![](demo_of_attrition_files/figure-gfm/plot%20outcomes%20without%20and%20with%20attrition-1.png)<!-- -->

``` r
ggplot(d_nonrandom_attrition, aes(y, fill = as.factor(d))) + 
  geom_histogram(bins = 10, position = 'dodge')
```

![](demo_of_attrition_files/figure-gfm/plot%20outcomes%20without%20and%20with%20attrition-2.png)<!-- -->

Let’s see what the standard two group estimator produces\!

``` r
mod_nonrandom_attrition_1 <- d_nonrandom_attrition[ , lm(y ~ d)]
mod_nonrandom_attrition_2 <- d_nonrandom_attrition[ , lm(y ~ d + x1)]
```

``` r
stargazer(
  mod_fully_observed_1, mod_fully_observed_2, 
  mod_random_attrition, 
  mod_nonrandom_attrition_1, mod_nonrandom_attrition_2,
  type = 'text', 
  se = list(
    robust_se(mod_fully_observed_1), 
    robust_se(mod_fully_observed_2), 
    robust_se(mod_random_attrition), 
    robust_se(mod_nonrandom_attrition_1), 
    robust_se(mod_nonrandom_attrition_2)
  ), 
  omit.stat = c('ser', 'F')
)
```

    ## 
    ## ==========================================================
    ##                           Dependent variable:             
    ##              ---------------------------------------------
    ##                                    y                      
    ##                (1)      (2)      (3)       (4)      (5)   
    ## ----------------------------------------------------------
    ## d            2.009*** 2.015*** 2.033*** -0.213*** 1.843***
    ##              (0.061)  (0.020)  (0.045)   (0.077)  (0.031) 
    ##                                                           
    ## x1                    1.995*** 2.006***           1.987***
    ##                       (0.007)  (0.016)            (0.010) 
    ##                                                           
    ## Constant     5.988*** 1.023*** 0.975*** 6.011***  1.045***
    ##              (0.043)  (0.023)  (0.049)   (0.050)  (0.030) 
    ##                                                           
    ## ----------------------------------------------------------
    ## Observations  10,000   10,000   2,000     5,552    5,552  
    ## R2            0.098    0.902    0.903     0.001    0.877  
    ## Adjusted R2   0.098    0.902    0.903     0.001    0.877  
    ## ==========================================================
    ## Note:                          *p<0.1; **p<0.05; ***p<0.01
