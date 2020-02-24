RI With a Large Effect
================

Begin this workbook by reloading all functions from the week.

  - These function loads are not echoed into the final `.md` file
  - Better coding practice (but not pedagogical practice) would be to
    place these repeatedly used functions somewhere that is commonly
    available to the project (e.g. `./src/`) and to import them.

<!-- end list -->

``` r
set.seed(2)

d <- make_data(number_of_subjects = 40)
d_experiment <- d[ , .(id, outcomes, condition, group)]
```

# Simulate an experiment with a large effect

We have seen that when there is no effect, our Randomization Inference
regime does a good job at assigning a high probability of observing an
effect size equal to or larger than the ATE we calculate from our
particular randomization.

Recall the steps to conduct randomization inference.

1.  Conduct the experiment, using random assignment to produce two
    unbiased samples of the desired test statistic.
2.  Compute the desired test statistic (here the ATE) on this
    experimental data.
3.  Suppose that the sharp null hypothesis is true, thereby solving the
    *missing data* problem that is at the heart of the fundimental
    problem of causal inference, and permitting the complete observation
    of all potential outcomes under the supposition of the sharp null
    were true.
4.  Repeatedly sample the treatment assignment vector and under each
    assignment, for each sample, compute the test statistic in the same
    manner as in step 1.
5.  Compare the measured treatment effect to the distribution of
    treatment effects under the sharp null supposition and directly draw
    a p-value.

Now, let’s show that when there is a big effect, our Randomization
Inference regime does a good job at assigning a low probability of
observing an effect size equal to or larger that the ATE we calculate in
our regression.

## 1\. Create the universe and assign to treatment and control

Create a universe where there is a *very* large treatment effect.
Specifically, \*\*edit the `make_data` function so that for every
subject, their potential outcomes to treatment are 25 units higher than
their potential outcomes to control.

After you have edited `make_data` run the chunk below.

``` r
set.seed(2)

d <- make_data(number_of_subjects = 40)
d_experiment <- d[ , .(id, outcomes, condition, group)]

d_experiment[1:5]
```

    ##    id outcomes condition group
    ## 1:  1        1 treatment   Man
    ## 2:  2        2   control   Man
    ## 3:  3        3   control   Man
    ## 4:  4        4 treatment   Man
    ## 5:  5        5 treatment   Man

## 2\. Calculate ATE

Use `data.table` to calculate the average of the realized potential
outcomes, grouped by whether a unit was in treatment or control. Then,
compute the difference between these two means.

## 3\. Conduct Randomization Inference

From the observed outcomes, create a randomization inference
distribution of how large or small the treatment effects could have been
if the sharp null were true.

1.  Think back to the last worksheet – in this data the treatment effect
    is *much* larger than before.
2.  How do you think the shape of the RI distribution will change as a
    result of this much larger treatment effect?
    1.  Will the distribution become more dispersed?
    2.  Will the distribution become less dispersed?
    3.  Will the distribution not change?

## 5\. Generate a p-value

Finally, generate a two sided p-value that makes a probabilisitc
statement about the proportion of treatment assignments that could have
produced a treatment effect larger than the observed `ate`, even if the
sharp null hypothesis were true.

Given this p-value, would you say that the data suggests that the
supposition of the sharp null leads to an absurd conclusion?
