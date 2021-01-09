# More Yoga!

In *Field Experiments* Green and Gerber make the claim that estimating with inverse probability weights might be able to recover causal estimates, even in the presence of missingness that is **not** independent of treatment assignment. 

Let us level with you for a moment: 

- No. 
- It. 
- Doesn't. 

To say that it is possible to produce estimates that are unbiased in the presence of selection requires the same heroic assumption that every purported savior makes: you've got the "magic bullet" model that gets rid of confounding. 

In the last set of models (which you likely still have open in the datahub), when you failed to include the `x1` feature in the presence of attrition you got **wildly** biased estimate (significant negative estimates despite the truth being a positive treatment effect). Including the `x1` feature resolved a substantial amount of this bias, but *not* all of it. 

# Ambition
If you are ambitious, go back to the `demo_of_attrition.Rmd` file and build the attrition so that rather than being based on the measurable feature `x1`, instead it is based on _epsilon_. To do so, you might do the following: 

- In the `make data` chunk make a new variable that is called `epsilon` that has draws from the normal distribution. 
- In the `make outcomes` chunk, build the outcome y so that rather than being build on `rnorm(.N)` instead, it is built on `3 * epsilon` (the feature you've just created. 

Since the idea is that you'll never be able to measure what is in these features, this demonstration should give you a sense for what happens when you correct for some, but not all, the features that are leading to attrition. 

# Extreme Values Bounds 
While we cannot *fix* the estimates in the presence of attrition, we can produce a reasonable statement about *just how bad it might be*. In the next short yoga, you will learn about how to make a set of assumptions about the data that are reasonably agnostic, and to essentially **fill in data**. 

This method, sometimes called extreme values bounds, and sometime given the name Manski Bounds, makes *very* clear just how strong are the assumptions one must make when facing attrition. 

# Do Some Short Yoga! 

Head to the datahub to work on an exercise. 

- If you want to pull all new changes from the master repo into the datahub, follow [this link](http://r.datahub.berkeley.edu/hub/user-redirect/git-pull?repo=https://github.com/UCB-MIDS/w241&branch=master&urlpath=rstudio). 
- If you have set up your datahub to work off a fork that you are managing, instead follow [this link](https://r.datahub.berkeley.edu/). 

Once on the UCB Datahub, navigate to `week_12>extreme_values_bounds.Rmd`
