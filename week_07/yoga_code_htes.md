Coding HTEs for Teacher Incentives
================
Alex

# An introduction to start

I know that this is a little bit in the middle of a number of tasks:

  - David Reiley is lecturing
  - You’re reading
  - You’re taking quizzes, *and*
  - Now I’m asking you to code.

If this is too much to do all at once, then feel free to come back to
this later.

# The task

The data that you’re using here is the very same data that is provided
by the authors of the paper that we’re discussing with David right now.
And, take our word for it, the data is *ugly*. We don’t mean to cast
shade at the past, but this data is stored in a totally wild way.

We begin by loading the data.

``` r
library(data.table)
library(foreign)
library(sandwich)
library(stargazer)
library(lmtest)
```

``` r
d <- read.dta('./jpe_data.dta')
d <- data.table(d)
```

``` r
get_cluster_se <- function(model, cluster) { 
  ## this is hardcoded against the apfschool code
  ## if generalized, it would have to take an additional argument.
  sqrt(diag(vcovCL(model, cluster = d[ , apfschoolcode])))
  }
```

There are a set of conditions that we’re going to scope out of the
analysis. We’re going to throw out the sets of students who either (a)
cheated or (b) had a weird teacher.

This is a choice that the authors of the papers made, and one that we’re
not entirely keen about. Perhaps there was something about the treatment
that led people to cheat? It is probably not the case that being
assigned to treatment affected a students’ teacher.

``` r
d <- d[cheaters_y2==0 & teacher_group == 0 & t_deg %in% c('head master', 'regular teacher')]
```

And then, in the *worst* data practices, we’re going to make the
**incredible** assumption that we the ordinal data we have measured can
be thought of as belonging on a linear scale. Steve and Mike in RDADA;
Coye, Paul, and Alex in 203; and Jeffrey in 271 and I all cringe. This
is a bad idea, but it reproduces the tables that you’re looking at in
the text.

``` r
# recode education to create a 'numeric' 
d[t_education == 'matriculation passed (10th)', t_education_n := 1]
d[t_education == 'higher secondary passed (12th)', t_education_n := 2]
d[t_education == 'College (Bachelors)', t_education_n := 3]
d[t_education == 'Masters/Other post graduation', t_education_n := 4]

# recode training to create a 'numeric'
d[t_training == 'None', t_training_n := 1]
d[grepl(pattern = 'Diploma Education', t_training), t_training_n := 2]
d[t_training == 'Bachelors Education', t_training_n := 3]
d[t_training == 'Masters Education', t_training_n := 4]
```

Eww. Say a prayer of absolution for that crime against data.

# The core task

The form of the models that we’re interested in fitting are all the
same:

  - We’ve measured students in the post-treatment time period: `nts`
  - We have a measurement of their performance in the pre-treatment time
    period: `lagged_nts`
  - We know where they live: `U_MC` (this is a categorical variable)
  - We know which treatment they received: `incentive`

Let’s start by checking on whether including the students’ previous
scores, measured in `lagged_nts` improves the model.

``` r
simplest_model <- d[!is.na(lagged_nts) , lm(nts ~ incentive + as.factor(U_MC))]
improved_model <- d[ , lm(nts ~ incentive + lagged_nts + as.factor(U_MC))]

stargazer(
  simplest_model, improved_model, 
  type = 'text', omit = 'U_MC')
```

    ## 
    ## ===========================================================================
    ##                                       Dependent variable:                  
    ##                     -------------------------------------------------------
    ##                                               nts                          
    ##                                 (1)                         (2)            
    ## ---------------------------------------------------------------------------
    ## incentive                    0.160***                    0.152***          
    ##                               (0.009)                     (0.008)          
    ##                                                                            
    ## lagged_nts                                               0.503***          
    ##                                                           (0.004)          
    ##                                                                            
    ## Constant                       0.016                      -0.027           
    ##                               (0.030)                     (0.026)          
    ##                                                                            
    ## ---------------------------------------------------------------------------
    ## Observations                  54,142                      54,142           
    ## R2                             0.105                       0.289           
    ## Adjusted R2                    0.104                       0.288           
    ## Residual Std. Error     0.958 (df = 54091)          0.854 (df = 54090)     
    ## F Statistic         126.303*** (df = 50; 54091) 430.384*** (df = 51; 54090)
    ## ===========================================================================
    ## Note:                                           *p<0.1; **p<0.05; ***p<0.01

Although there isn’t an observable increase on the treatment indicator,
the model does fit better overall, observable in the \(\Delta R^2\). We
can test this formally, using an F-test.

``` r
anova(simplest_model, improved_model, test = "F")
```

    ## Analysis of Variance Table
    ## 
    ## Model 1: nts ~ incentive + as.factor(U_MC)
    ## Model 2: nts ~ incentive + lagged_nts + as.factor(U_MC)
    ##   Res.Df   RSS Df Sum of Sq     F    Pr(>F)    
    ## 1  54091 49617                                 
    ## 2  54090 39415  1     10202 14000 < 2.2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

In the model that we’ve fit above, however, we have not accounted for
the fact that entire classrooms all get the same treatment. This is a
classic case of clustering, and means that we’ve got to correct our
analysis accordingly.

As we’ve seen in the code that introduced the `sandwich` package, we can
calculate a clustered vcov pretty easily using the `vcovCL` function
call. We can print a direct test using `coeftest` that provides all the
model introspecting that we would like. And, we can pretty print a
version for readers using `stargazer`.

``` r
vcovCL(improved_model, cluster = d[ , apfschoolcode])[1:5,1:5]
```

    ##                      (Intercept)     incentive    lagged_nts as.factor(U_MC)120
    ## (Intercept)         6.992967e-03 -0.0009677912 -5.772467e-06      -0.0063946966
    ## incentive          -9.677912e-04  0.0012052731 -4.427240e-05       0.0002819707
    ## lagged_nts         -5.772467e-06 -0.0000442724  2.567488e-04      -0.0001146974
    ## as.factor(U_MC)120 -6.394697e-03  0.0002819707 -1.146974e-04       0.0274196075
    ## as.factor(U_MC)121 -6.457133e-03  0.0003306736 -6.364692e-06       0.0062026394
    ##                    as.factor(U_MC)121
    ## (Intercept)             -6.457133e-03
    ## incentive                3.306736e-04
    ## lagged_nts              -6.364692e-06
    ## as.factor(U_MC)120       6.202639e-03
    ## as.factor(U_MC)121       1.303219e-02

``` r
coeftest(x = improved_model, vcov. = improved_model$cluster_vcov)[1:5]
```

    ## [1] -0.02709233  0.15210459  0.50324825  0.08030607  0.24103990

# The First Model: Teacher Education

``` r
model_1 <- d[ , lm(nts ~ incentive + t_education_n + incentive * t_education_n 
                   + lagged_nts + as.factor(U_MC))]

stargazer(
  model_1, type = 'text', 
  se = list(get_cluster_se(model_1)), 
  omit = 'U_MC'
)
```

    ## 
    ## ===================================================
    ##                             Dependent variable:    
    ##                         ---------------------------
    ##                                     nts            
    ## ---------------------------------------------------
    ## incentive                         -0.113           
    ##                                   (0.163)          
    ##                                                    
    ## t_education_n                      0.003           
    ##                                   (0.032)          
    ##                                                    
    ## lagged_nts                       0.502***          
    ##                                   (0.016)          
    ##                                                    
    ## incentive:t_education_n           0.086*           
    ##                                   (0.050)          
    ##                                                    
    ## Constant                          -0.052           
    ##                                   (0.135)          
    ##                                                    
    ## ---------------------------------------------------
    ## Observations                      53,737           
    ## R2                                 0.291           
    ## Adjusted R2                        0.290           
    ## Residual Std. Error         0.853 (df = 53683)     
    ## F Statistic             415.257*** (df = 53; 53683)
    ## ===================================================
    ## Note:                   *p<0.1; **p<0.05; ***p<0.01

Take some time to think about that model.

  - What are we learning about the effect of the incentive? For whom?
  - Can we think about the effect of the incentive without at the same
    time thinking about the level that `education` of the teacher is at?
  - Suppose that you had the opportunity to choose which kind of school
    that your kid was at. Would you want a treatment school or not?
    Note, the answer to this question is not that straightforward.

# The Second Model: Teacher Training

``` r
model_2 <- d[ , lm(nts ~ incentive + t_training_n + incentive * t_training_n 
                   + lagged_nts + as.factor(U_MC))]

stargazer(
  model_2, type = 'text', 
  se = list(get_cluster_se(model_1)), 
  omit = 'U_MC'
)
```

    ## 
    ## ==================================================
    ##                            Dependent variable:    
    ##                        ---------------------------
    ##                                    nts            
    ## --------------------------------------------------
    ## incentive                        -0.224           
    ##                                  (0.163)          
    ##                                                   
    ## t_training_n                     -0.051           
    ##                                                   
    ##                                                   
    ## lagged_nts                      0.503***          
    ##                                  (0.016)          
    ##                                                   
    ## incentive:t_training_n          0.138***          
    ##                                                   
    ##                                                   
    ## Constant                          0.102           
    ##                                  (0.135)          
    ##                                                   
    ## --------------------------------------------------
    ## Observations                     53,890           
    ## R2                                0.290           
    ## Adjusted R2                       0.289           
    ## Residual Std. Error        0.854 (df = 53836)     
    ## F Statistic            414.999*** (df = 53; 53836)
    ## ==================================================
    ## Note:                  *p<0.1; **p<0.05; ***p<0.01

  - What is the effect of the treatment among untrained teachers (where
    the value for `t_training_n == 1`)?  
  - What is the effect of the treatment among highly trained teachers
    (where the value for `t_training_n == 4`)?
  - Taken together, should we increase the education of training and
    teachers to increase the effectiveness of the treatment?
  - (*Note*: This *definitely* requires some clear thinking about what
    is, and isn’t causal.)

# The Third Model: Teacher Years of Experience

``` r
model_3 <- d[ , lm(nts ~ incentive + t_service + incentive * t_service 
                   + lagged_nts + as.factor(U_MC))]

stargazer(
  model_3, type = 'text', 
  se = list(get_cluster_se(model_1)), 
  omit = 'U_MC'
)
```

    ## 
    ## ===============================================
    ##                         Dependent variable:    
    ##                     ---------------------------
    ##                                 nts            
    ## -----------------------------------------------
    ## incentive                      0.258           
    ##                               (0.163)          
    ##                                                
    ## t_service                     -0.001           
    ##                                                
    ##                                                
    ## lagged_nts                   0.502***          
    ##                               (0.016)          
    ##                                                
    ## incentive:t_service           -0.009           
    ##                                                
    ##                                                
    ## Constant                      -0.012           
    ##                               (0.135)          
    ##                                                
    ## -----------------------------------------------
    ## Observations                  54,142           
    ## R2                             0.292           
    ## Adjusted R2                    0.292           
    ## Residual Std. Error     0.851 (df = 54088)     
    ## F Statistic         421.633*** (df = 53; 54088)
    ## ===============================================
    ## Note:               *p<0.1; **p<0.05; ***p<0.01

# The Fourth Model: Teacher Salary

``` r
model_4 <- d[ , lm(nts ~ incentive * log(t_salary) 
                   + lagged_nts + as.factor(U_MC))]

stargazer(
  model_4, type = 'text', 
  se = list(get_cluster_se(model_1)), 
  omit = 'U_MC'
)
```

    ## 
    ## ===================================================
    ##                             Dependent variable:    
    ##                         ---------------------------
    ##                                     nts            
    ## ---------------------------------------------------
    ## incentive                        1.775***          
    ##                                   (0.163)          
    ##                                                    
    ## log(t_salary)                     -0.034           
    ##                                                    
    ##                                                    
    ## lagged_nts                       0.503***          
    ##                                   (0.016)          
    ##                                                    
    ## incentive:log(t_salary)          -0.179***         
    ##                                                    
    ##                                                    
    ## Constant                          0.276**          
    ##                                   (0.135)          
    ##                                                    
    ## ---------------------------------------------------
    ## Observations                      53,122           
    ## R2                                 0.292           
    ## Adjusted R2                        0.291           
    ## Residual Std. Error         0.853 (df = 53068)     
    ## F Statistic             413.357*** (df = 53; 53068)
    ## ===================================================
    ## Note:                   *p<0.1; **p<0.05; ***p<0.01

``` r
## model_5 <- d[ , lm(nts ~ incentive * I(t_gender == 'male') + lagged_nts + as.factor(U_MC))]
## summary_no_MC(model_5)
## There's a coding error that we cannot reproduce between the author's tables 
## and the data. Believe us, we tried. 
```

# Large Scale Takeaways

1.  We’d really like you to be comfortable reading, and more importantly
    thinking about these regressions in all the forms that you’re going
    to see them, both printed and while you’re working. Hopefully this
    helps to see things twice or more.
2.  Thinking about what is happening, and what part of it is causal in
    the search for HTEs requires some careful thought.
