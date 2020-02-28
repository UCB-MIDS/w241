R Notebook
================

Think back for a moment to w203 – the introductory stats class in the
program. We spent time in the class talking about *sampling*, which is
the process of drawing data from a population of places that we could
potentially draw that data from.

Consider the following, vector, `population` which is arranged from
lowest to highest.

``` r
population <- rnorm(n = 1000, mean = 10, sd = 5)
population <- sort(population)
```

In this vector, we’ve places 1,000 draws from a Gaussian distribution
with a mean of 10 and a standard deviation of 5. In this case, we can
know that the population *parameter* **mean** is just:

``` r
mean(population)
```

    ## [1] 9.887431

(Which, incidentally we can write in line as 9.8874314.)

There isn’t any value statement that we are attaching to this parameter
value, it just is the average of the population.

What if, for some reason, we couldn’t actually observe all of the values
in the population. Either it would take too much time, or cost too much
money. How could we produce an *estimate* of the population parameter
that we’re interested in?

1.  A *bad* estimate might just take the first 10 data value that we
    observe, and add them up. `sum(population[1:10])`. Why is this a bad
    estimate? Well, there just isn’t any clear relationship between the
    **sample** that we’re drawing and then applying a function across,
    and the parameter that we’re interested in. That is, the *estimator*
    that we’ve produced just doesn’t provide us an unbiased estimate of
    the population parameter. In particular, it is always going to
    underestimate the true value.

<!-- end list -->

``` r
sum(population[1:10])
```

    ## [1] -34.88506

2.  The choice to sum those values seems pretty illogical, right? What
    if, instead, we were to take the average of them. Would this
    estimator produce an estimate of the population parameter we’re
    looking for that is any less biased?

<!-- end list -->

``` r
mean(population[1:10])
```

    ## [1] -3.488506

Not really. Although there is a more natural relationship between the
function we’re applying to the sample and the population parameter we’re
looking for – the population average – the sample we’re drawing from is
still systematically different from the population. Specifically, it is
always on the *low* side of the average, right?

And so, this estimator is going to remain a **biased estimator** for any
sample size that is smaller than the whole population.

Interestingly, however, as the size of the sample gets larger, the
estimate that the estimator produces gets closer to the truth. When this
is the case, we say that the estimator is **consistent.** Although it
might be biased in any finite sample, it produces a consistent estimate
in an infinite sample.

``` r
sample_1 <- mean(population[1:10])
sample_2 <- mean(population[1:100])
sample_3 <- mean(population[1:999])
```

| Sample 1    | Sample 2  | Sample 3  |
| ----------- | --------- | --------- |
| \-3.4885058 | 1.4539552 | 9.8713229 |

Would you say that the first estimator we were using – the sum of the
sample – was a consistent estimator? Why or why not?

# A natural estimator

Of course, the natural estimator that you probably had in mind was:

1.  Take a random sample, and
2.  Apply the sample mean function onto that sample.

Good idea\! This is estimator – the sample mean – is going to be an
unbiased, consistent estimate of the population parameter we’re
interested in.

One way to make the random sample is just to use the `sample` function,
and to provide a vector of integers that we want to sample from.

``` r
sample(x = 1:10)
```

    ##  [1]  6  2  5  4  3 10  9  1  8  7

If we call for this, with out any other arguments, we’re going to pull a
sample without replacement that is the same size as the vector that it
is sampling. You might think of this as a shuffle of the vector, or a
permutation of the vector.

``` r
sample(x = 1:10, size = 5)
```

    ## [1]  8  2 10  5  1

If you pass a size argument, you’ll pull a sample that is of that size.
We can use these values as positional indexes in the vector that we’re
sampling from. For example, if our population is the set of the first
ten letters,

``` r
letter_population <- LETTERS[1:10]
```

Then we can pull the third letter using a positional index

``` r
letter_population[3]
```

    ## [1] "C"

And so we can pull a sample of the letters by calling for

``` r
letter_population[sample(x = 1:10, size = 5)]
```

    ## [1] "H" "F" "E" "D" "B"

``` r
sample_mean_1  <- mean(population[sample(x = 1:1000, size = 10)])
sample_mean_2a <- mean(population[sample(1:1000, 100)])
sample_mean_2b <- mean(population[sample(1:1000, 100)])
sample_mean_3  <- mean(population[sample(1:1000, 999)])

sample_mean_1
```

    ## [1] 12.35701

``` r
sample_mean_2a
```

    ## [1] 9.766647

``` r
sample_mean_2b
```

    ## [1] 9.207066

``` r
sample_mean_3
```

    ## [1] 9.884851

# Questions for Understanding

1.  Are you surprised that the values are not all the same? Why or why
    not? Are you surprised that the `sample_mean_2a` and
    `sample_mean_2b` are not exactly the same? Aren’t they the same
    size?

2.  As the size of the sample that you take gets larger, will the
    estimate that you calculate tend to get closer to the truth, farther
    from the truth, or stay the same distance from the truth? Why?
