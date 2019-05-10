Problem Set 2
================
Experiments and Causality

<!--

Some guidelines for submitting problem sets in this course:

- Please submit a PDF document rather than a Word document or a Google document.
- Please put your name at the top of your problem set.
- Please **bold** or *highlight* your numerical answers to make them easier to find.
- If you'll be using `R` or `Python` code to calculate your answers, please put the code and its output directly into your Problem Set PDF document.
- It is highly recommended, although not required, that you use the RMarkdown feature in RStudio to compose your problem set answers. RMarkdown allows you to easily intermingle analysis code and answers in one document. It is of a similar design as `jupyter` and an ipython notebook.
- You do not need to show work for trivial calculations, but showing work is always allowed.
- For answers that involve a narrative response, please feel free to describe the key concept directly and briefly, if you can do so, and do not feel pressure to go on at length.
- Please ask us questions about the problem set if you get stuck. **Don’t spend more than 20 minutes puzzling over what a problem means.** 
- Please ensure that someone (us!) can compile your solution set. The best way is to use the web-hosted links we've provided. 
-->

# 1\. What happens when pilgrims attend the Hajj pilgrimage to Mecca?

On the one hand, participating in a common task with a diverse group of
pilgrims might lead to increased mutual regard through processes
identified in *Contact Theories*. On the other hand, media narritives
have raised the spectre that this might be accompanied by “antipathy
toward non-Muslims”. [Clingingsmith, Khwaja and Kremer
(2009)](https://dash.harvard.edu/handle/1/3659699) investigates the
question.

Using the data here, test the sharp null hypothesis that winning the
visa lottery for the pilgrimage to Mecca had no effect on the views of
Pakistani Muslims toward people from other countries. Assume that the
Pakistani authorities assigned visas using complete random assignment.
Use, as your primary outcome the `views` variable, and as your treatment
feature `success`. If you’re ambitious, write your fucntion generally so
that you can also evaluate feeligns toward specific nationalities.

``` r
d <- read.csv("./data/Clingingsmith.2009.csv", stringsAsFactors = FALSE)
```

1.  Using either `dplyr` or `data.table`, group the data by `success`
    and report whether views toward others are generally more positive
    among lottery winners or lottery non-winners.

<!-- end list -->

``` r
d <- data.table(d)
d[ ,.(named_variable = mean(views)), keyby = .(success)]
```

    ##    success named_variable
    ## 1:       0       1.868304
    ## 2:       1       2.343137

2.  But is this a meaningful difference, or could it just be
    randomization noise? Conduct 10,000 simulated random assignments
    under the sharp null hypothesis to find out. (Don’t just copy the
    code from the async, think about how to write this yourself.)

3.  How many of the simulated random assignments generate an estimated
    ATE that is at least as large as the actual estimate of the ATE?

4.  What is the implied *one-tailed* p-value?

5.  How many of the simulated random assignments generate an estimated
    ATE that is at least as large *in absolute value* as the actual
    estimate of the ATE?

6.  What is the implied two-tailed p-value?

# 2\. Term Limits Aren’t Good.

Naturally occurring experiments sometimes involve what is, in effect,
block random assignment. For example, [Rocio
Titiunik](https://sites.google.com/a/umich.edu/titiunik/publications) ,
in [this
paper](http://www-personal.umich.edu/~titiunik/papers/Titiunik2016-PSRM.pdf)
studies the effect of lotteries that determine whether state senators in
TX and AR serve two-year or four-year terms in the aftermath of
decennial redistricting. These lotteries are conducted within each
state, and so there are effectively two distinct experiments on the
effects of term length.

The “thoery” in the news (such as it is), is that legislators who serve
4 year terms have more time to slack off and not produce legislation. If
this were true, then it would stand to reason that making terms shorter
would increase legislative production.

One way to measure legislative production is to count the number of
bills (legislative proposals) that each senator introduces during a
legislative session. The table below lists the number of bills
introduced by senators in both states during 2003.

``` r
library(foreign)

d <- read.dta("./data/Titiunik.2010.dta")
head(d)
```

    ##   term2year bills_introduced texas0_arkansas1
    ## 1         0               18                0
    ## 2         0               29                0
    ## 3         0               41                0
    ## 4         0               53                0
    ## 5         0               60                0
    ## 6         0               67                0

1.  Using either `dplyr` or `data.table`, group the data by state and
    report the mean number of bills introduced in each state. Does Texas
    or Arkansas seem to be more productive? Then, group by two- or
    four-year terms (ignoring states). Do two- or four-year terms seem
    to be more productive? **Which of these effects is causal, and which
    is not?** Finally, using `dplyr` or `data.table` to group by state
    and term-length. How, if at all, does this change what you learn?

2.  For each state, estimate the standard error of the estimated ATE.

3.  Use equation (3.10) to estimate the overall ATE for both states
    combined.

4.  Explain why, in this study, simply pooling the data for the two
    states and comparing the average number of bills introduced by
    two-year senators to the average number of bills introduced by
    four-year senators leads to biased estimate of the overall ATE.

5.  Insert the estimated standard errors into equation (3.12) to
    estimate the stand error for the overall ATE.

6.  Use randomization inference to test the sharp null hypothesis that
    the treatment effect is zero for senators in both states.

7.  **IN Addition:** Plot histograms for both the treatment and control
    groups in each state (for 4 histograms in total).

# 3\. Cluster Randomization

Use the data in *Field Experiments* Table 3.3 to simulate cluster
randomized assignment. (*Notes: (a) Assume 3 clusters in treatment and 4
in control; and (b) When Gerber and Green say `simulate'', they do not
mean`run simulations with R code’‘, but rather, in a casual sense
\`\`take a look at what happens if you do this this way.’’ There is no
randomization inference necessary to complete this problem.*)

``` r
## load data 
d <- read.csv("./data/ggChapter3.csv", stringsAsFactors = FALSE)
```

1.  Suppose the clusters are formed by grouping observations {1,2},
    {3,4}, {5,6}, … , {13,14}. Use equation (3.22) to calculate the
    standard error assuming half of the clusters are randomly assigned
    to treatment.

2.  Suppose that clusters are instead formed by grouping observations
    {1,14}, {2,13}, {3,12}, … , {7,8}. Use equation (3.22) to calculate
    the standard error assuming half of the clusters are randomly
    assigned to treatment.

3.  Why do the two methods of forming clusters lead to different
    standard errors? What are the implications for the design of cluster
    randomized experiments?

# 4\. Sell Phones?

You are an employee of a newspaper and are planning an experiment to
demonstrate to Apple that online advertising on your website causes
people to buy iPhones. Each site visitor shown the ad campaign is
exposed to $0.10 worth of advertising for iPhones. (Assume all users
could see ads.) There are 1,000,000 users available to be shown ads on
your newspaper’s website during the one week campaign.

Apple indicates that they make a profit of $100 every time an iPhone
sells and that 0.5% of visitors to your newspaper’s website buy an
iPhone in a given week in general, in the absence of any advertising.

1.  By how much does the ad campaign need to increase the probability of
    purchase in order to be “worth it” and a positive ROI (supposing
    there are no long-run effects and all the effects are measured
    within that week)?

2.  Assume the measured effect is 0.2 percentage points. If users are
    split 50:50 between the treatment group (exposed to iPhone ads) and
    control group (exposed to unrelated advertising or nothing;
    something you can assume has no effect), what will be the confidence
    interval of your estimate on whether people purchase the phone?

<!-- end list -->

  - **Note:** The standard error for a two-sample proportion test is
    \(\sqrt{p(1-p)*(\frac{1}{n_{1}}+\frac{1}{n_{2}})}\) where
    \(p=\frac{x_{1}+x_{2}}{n_{1}+n_{2}}\), where \(x\) and \(n\) refer
    to the number of “successes” (here, purchases) over the number of
    “trials” (here, site visits). The length of each tail of a 95%
    confidence interval is calculated by multiplying the standard error
    by 1.96.

<!-- end list -->

3.  Is this confidence interval precise enough that you would recommend
    running this experiment? Why or why not?

4.  Your boss at the newspaper, worried about potential loss of revenue,
    says he is not willing to hold back a control group any larger than
    1% of users. What would be the width of the confidence interval for
    this experiment if only 1% of users were placed in the control
    group?

# 5\. Sports Cards

Here you will find a set of data from an auction experiment by John List
and David Lucking-Reiley
([2000](https://drive.google.com/file/d/0BxwM1dZBYvxBNThsWmFsY1AyNEE/view?usp=sharing)).

``` r
d2 <- read.csv("./data/listData.csv", stringsAsFactors = FALSE)
head(d2)
```

    ##   bid uniform_price_auction
    ## 1   5                     1
    ## 2   5                     1
    ## 3  20                     0
    ## 4   0                     1
    ## 5  20                     1
    ## 6   0                     1

In this experiment, the experimenters invited consumers at a sports card
trading show to bid against one other bidder for a pair trading cards.
We abstract from the multi-unit-auction details here, and simply state
that the treatment auction format was theoretically predicted to produce
lower bids than the control auction format. We provide you a relevant
subset of data from the experiment.

1.  Compute a 95% confidence interval for the difference between the
    treatment mean and the control mean, using analytic formulas for a
    two-sample t-test from your earlier statistics course.

2.  In plain language, what does this confidence interval mean?

3.  Regression on a binary treatment variable turns out to give one the
    same answer as the standard analytic formula you just used.
    Demonstrate this by regressing the bid on a binary variable equal to
    0 for the control auction and 1 for the treatment auction.

4.  Calculate the 95% confidence interval you get from the regression.

5.  On to p-values. What p-value does the regression report? Note:
    please use two-tailed tests for the entire problem.

6.  Now compute the same p-value using randomization inference.

7.  Compute the same p-value again using analytic formulas for a
    two-sample t-test from your earlier statistics course. (Also see
    part (a).)

8.  Compare the two p-values in parts (e) and (f). Are they much
    different? Why or why not? How might your answer to this question
    change if the sample size were different?
