The effects of leaving a tip
================

Do the practice exercise that is provided to us in question 9.6 of
*Field Experiments*.

> Rind and Bordia studied the tipping behavior of lunchtime patrons of
> an “upscale Philadelphia restaurant” who were randomly assigned to
> four experimental groups (Rand and Bordia 1996). One factor was server
> gender, and a second factor was whether the server draws a “happy
> face” on the back o the bill presented to customers.

``` r
library(foreign)
library(data.table)
```

    ## Warning: package 'data.table' was built under R version 3.5.2

First, load the data.

``` r
d <- read.dta("http://hdl.handle.net/10079/vmcvdzs")
head(d)
```

    ##   female happyface   tip xhappy tipround
    ## 1 Female      None 44.78      0       45
    ## 2 Female      None 27.55      0       28
    ## 3 Female      None 18.12      0       18
    ## 4   Male      None  0.00      0        0
    ## 5 Female      None 30.08      0       30
    ## 6   Male      None 16.28      0       16

There are only three fields that we care about in this table:

  - `female`: is the server a ‘female’ or ‘male’ server
  - `happyface`: does the server, at random, place a happyface onto the
    bill of a patron
  - `tip`: the amount of tip that is left on on the bill.

# Questions to Answer

1.  Write down a regression model that depicts the effect of the sex of
    the waitstaff, whether they put a happyface on the bill, and the
    interaction of these two terms. Test, using an `anova( ... , test =
    'F')` for whether the interaction is necessary. This is going to
    compare a longer model to a shorter model.
2.  How much does a female server make, on average?
3.  How much does a male server make, on average? (Note, for both of
    these questions, think carefully about what the coefficients in your
    table are reporting. It requires more than a passing glance to
    interpret these correctly)
