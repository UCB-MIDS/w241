# Preparing for Live Sessions 

*This document records our plans for class. We do not expect you to work the problems in advance, but we think you may find it useful to look them over in advance so that you can ask clarifying questions.*

*We particularly recommend looking at the questions about the assigned reading; knowing what we intend to ask you about the reading can help you get much more out of the reading assignments that you are doing in advance of class.*

| Week  | Topic |
|------|----------| 
|Week 1 | [The Importance of Experimentation](#week-1-the-importance-of-experimentation) | 
|Week 2 | [Comparing Apples to Apples](#week-2-comparing-apples-to-apples) |  
|Week 3 | [Quantifying uncertainty](#week-3-quantifying-uncertainty) |
|Week 4 | [Blocking and Clustering](#week-4-blocking-and-clustering) |
|Week 5 | [Covariates and Regression](#week-5-covariates-and-regression) |
|Week 6 | [Regression; Multi-Factor Experiments](#week-6-regression-multi-factor-experiments) |
|Week 7 | [Heterogeneous Treatment Effects ](#week-7-heterogeneous-treatment-effects) |
|Week 8 | [Noncompliance](#week-8-noncompliance) |
|Week 9 | [Spillovers](#week-9-spillovers) |
|Week 10 | [Common problems and diagnostics](#week-10-common-problems-and-diagnostics) |
|Week 11 | [Causality from Observational Data (IV, RD)](#week-11---causality-from-observational-data-iv-rd) | 
|Week 12 | [Attrition, Mediation, Generalizability](#week-12---attrition-mediation-generalizability) |
|Week 13 | [Examples of Experiments](#week-13---examples-of-experiments) |
|Week 14 | [Student Presentations](#student-presentations-plan-on-15-20-min-plus-time-for-questions) |

# Week 1: The Importance of Experimentation
## News articles with causal claims

First, read the three news articles that we provided as examples for [*Essay 1*](../assignments/essays/essay1/readme.md):
-   [*Obesity caused by suburban sprawl*](http://www.cbsnews.com/2100-204_162-570634.html) (2013)
-   [Get Fast?](https://www.nytimes.com/interactive/2018/07/18/upshot/nike-vaporfly-shoe-strava.html) (2018)

For each article, please consider the following discussion questions:
- What is the causal claim?
- What is an alternative explanation for the reported correlation?

## Cargo Cult Science

Next read [*“Cargo Cult Science”*](../readings/Feynman.1974.pdf) by Nobel laureate [*Richard P. Feynman*](http://en.wikipedia.org/wiki/Richard_Feynman). As you read this article, consider the following discussion questions:
-   How does data science, as practiced, tend to be different from natural science as practiced?
-   What are characteristics of *true* science?
-   What are ways that individuals fool themselves?
-   How can we, as (data) scientists, train ourselves not to be fooled?
-   What are examples of scientific progress?
-   Provide as many examples of social-science claims as you can.
-   Provide as many examples as you can of social scientists (or data scientists) pretending to be scientists without really being scientists.

Additional questions to think about
-   Related to FE Chapter 1: What are examples of stalemates in policy discussions? Why have these discussions stalemated?
-   What are examples of causal claims that have come up in your work life?
-   What are examples of causal claims that are relevant to your personal life?

# Week 2: Comparing Apples to Apples

## More than Good Intentions

Read [*Karlan and Appel*](http://smile.amazon.com/More-Than-Good-Intentions-Improving/dp/0452297567) chapters 1, 5, 8, 9. (Read the other chapters if you have time; they are excellent.)

We’re going to talk about the intent of the author, or the moral of the story in live session, but to guide your reading in the chapters we have recommended, consider the following questions:
-   Chapter 1:
    -   What does the parable of the monks teach us about anti-poverty programs?
    -   Who cares more about identifiable victims, Econs or Humans?
    -   What two-pronged strategy does Karlan suggest for going beyond mere good intentions?
-   Chapter 5:
    -   What does Karlan claim as the biggest takeaway from the entrepreneurship training experiments? How does this conflict with the point of view of Mohammad Yunus?
    -   What is the two-list elicitation technique useful for? Invent an example of something you might like to learn for yourself by using the technique.
    -   What are the two larger points about the topic of “slippery money” for anti-poverty programs?
-   Chapter 8:
    -   On page 170, find the example of a “heterogeneous treatment effect.” That is, the same treatment produced a larger effect for some subjects than for others. What was it?
    -   What are the two important experiments in this chapter about farmers’ use of fertilizer? What did they find?
    -   What is the O-ring theory of economic development?
-   Chapter 9:
    -   What is the most cost effective treatment discussed in this chapter for increasing education for students? In which two countries was the same experiment replicated?
    -   What were the heterogeneous treatment effects in the ICS school-uniform experiment described on page 200?
    -   What were the two important ingredients of the Seva Mandir program to increase the amount of time teachers spent in Rajasthani schools? How large were the treatment effects of the program?

## Essay 1 critique

We will assign you to two partners to exchange papers and give each other feedback. **Make sure to read your partners’ papers before live session**. You can find them in the forum where you posted your own paper. Consider the following questions:
-   Does the essay complete each of the four requested tasks?
    -   Present a causal question
    -   Describe a story by which the effect would be overestimated or underestimated.
    -   Identify the assumptions required to believe the study results.
    -   Describe the ideal experiment.
-   Are there places where the essay could be made clearer?
-   Does anything seem too vague? Are there places where the essay could be made more vivid by using a more concrete example?
-   Can you find any places where the essay could be improved by adding active verbs?
-   Do you have any other suggestions for improvement?

## FE exercises

As you complete the asynchronous content, you might want to look at some of the exercises. Note that there will be some exercises from Chapter 2 on Problem Set 1; you might want to look at these as you complete the reading, so you can ask questions about them in class. We also intend to look at the following exercises during live session:
-   FE, 2.1 (a)(e)(f). For part (f), try to come up with a concrete example of what Y and D represent.
-   FE, 2.7. In this context, mention the difference between the notation E\[Y<sub>i</sub>(1)|d<sub>i</sub>=1\] and the notation E\[Y<sub>i</sub>(1)|D<sub>i</sub>=1\].
-   FE, 2.11.

# Week 3: Quantifying uncertainty

## Lewis & Rao reading
When doing the reading on Lewis and Rao for live session, please consider the following questions to promote your understanding. We will discuss a subset of these questions in class, depending on our time constraints. Let us know in advance if you want to make sure to discuss one of these in particular.
-   On the topic of statistical power, several questions:
    -   a. What is statistical power?
    -   b. How, or why, can we fail to detect the profitability of a profitable campaign, even with millions of observations?
    -   c. Which two attributes of data reduce the statistical uncertainty of estimates?
    -   d. Why is it harder to show that a campaign is profitable than to show that its effects are statistically significant?

## Exercises we intend to do in class
- We're going to talk through `./week03_apply_these_concepts.Rmd` in live session. Please have worked through this code ahead of time, and be ready to talk about what you think is happening with that distribution of treatment effects under the sharp null. 
-   FE, 3.1, (a), (b), (c), maybe (e) 
-   FE 3.5, a, b, and d (if time)

# Week 4: Blocking and Clustering

## Exercises for discussion: Blocking, or Clustering?
-   Example: Suppose we want to measure the effect of snowplowing on local retail activity. We design an experiment that plows some locations but not others. Which of the following do you prefer? Explain the relative advantages and disadvantages of each option.
    -   On a given street, we randomly assign which businesses we plow in front of.
    -   We randomly assign which streets to plow and which streets not to plow.
    -   We randomly assign which neighborhoods to plow and which neighborhoods not to plow.
-   Do the differences above illustrate blocking, or clustering?
-   Returning to the snowplow example, suppose we have two wealthy neighborhoods, nine middle-class neighborhoods, and four poor neighborhoods available to experiment on. We are worried that if we put both of the wealthy neighborhoods into the treatment group, we will get an overestimate of the treatment effect of snowplowing on retail activity.
    -   We will assign treatment at the neighborhood level. Now consider blocking this experiment based on social class. Describe treatment assignment for the fifteen neighborhoods.
    -   Does blocking reduce bias?
    -   What benefit do we expect blocking to have on our ATE estimator?
-   Blocking or clustering?
    -   Reiley in Berkeley
        -   Reiley walks through Berkeley and observes retail shops. As he goes, he takes each pair of stores he encounters, flips a coin, and goes into one store in each pair to give them a free Pandora ad coupon. He later observes how much each spent on Pandora ads in the month after.
            -   Q. Why might this increase power compared to picking stores totally at random?
        -   Reiley does the same as above, but picks one store on every street only.
        -   Reiley does the same as above, but picks two stores on every street only.
        -   Reiley picks one side of each street to treat on many streets.
    -   Walmart
        -   Always low prices? Imagine that an executive at Walmart gives you the keys to the pricing at the store and asks you to determine how demand for goods changes depending on the pricing of those goods? Basically, does “rolling back prices” lead to increased demand? And by how much?
        -   What are the different *levels* at which you could assign different prices? What are the benefits and limitations of assigning different prices at those levels?

# Week 5: Covariates and Regression

## Teams for Final Project
-   This week, your assignment will be to read each of your classmates’ project proposals and vote for the ones you would most like to work on for the semester.
-   Please make sure that the Essay 2 forum contains a link to your revised project proposal. If your Draft link is outdated, please delete your original forum post and replace it with an updated one, so that your classmates will be able to read the best version of your proposal.
-   Please visit the link to the Google Form for the voting exercise ASAP and make sure that your paper topic is listed. We took all topics from the list of messages in the Essay 2 forum. If your topic is not listed, please email the instructor ASAP.
-   Before Week 6 live session, make sure to submit your votes on the form.

## Opower reading assignment

[*Here's the paper.*](http://www.nber.org/papers/w15386.pdf)

Here are some questions to guide your reading:
-   First breakout
    -   Overall, what do we learn from the article about energy consumption behavior?
    -   Do you see an example of clustered treatment assignment in the article, even though they don’t use that language for it?
    -   In Table 1, which is the treatment variable of interest? What are the covariates in the two sets of regression results?
-   Second breakout
    -   Why does the outcome variable in Table 1 involve a logarithm? What does this mean? (We didn’t cover this explicitly in the course material, so don’t worry if you don’t understand it, but give it a shot.)
    -   Do the coefficients of interest change when we add controls to the regression? Why or why not?
    -   Comparing the first and second regressions, which would you expect to have a tighter 95% confidence interval?
    -   What additional information do we need in order to construct those confidence intervals?
-   Third breakout: Looking at Table
    -   In Table 3, how many different outcome measures are analyzed? What are they?
    -   What are the main coefficients of interest?
    -   Do the coefficients of interest change when we add controls to the regressions? Why or why not?
    -   Comparing the first and second regressions in the table, which would you expect to have a tighter 95% confidence interval? What additional information would you like to see the authors provide in the table?
    -   For the first regression, what’s the best guess you can make as to the confidence interval width, given the information you have?

# Week 6: Regression; Multi-Factor Experiments

Note: While you are preparing for this live session, it would be an excellent time for you to be thinking about Problem Set \#3. By the end of this class, you should be able to answer all of the questions on the problem set.

## Practicing regression with the Colin/José example from FE (p. 304-307)

Note that equation \[9.16\] only gives estimated coefficients, and lacks estimates of those coefficients’ standard errors. Let’s fix this by doing the regression ourselves.
-   The full dataset is described completely in Table 9.1. You will have to figure out how to create a version of this dataset for which you can run the regression. What will that look like? How many rows and columns?
-   Once you have created the data file, run the regression in Equation 9.16. Present the results with standard errors in parentheses.
-   Which of the coefficients are statistically significant at the 5% level, and which are not?
-   How do you interpret the magnitudes of the significant coefficients?
-   Now that you’ve practiced doing a simple regression, it’s a really good thing to get in the habit of using heteroskedasticity-robust standard errors. Re-run your regression model with robust standard errors, and re-answer the previous problems.
-  We work through this in [week4](../week04_demo_of_robust_ses.Rmd)

## Back to the [*Opower article*](http://www.nber.org/papers/w15386.pdf) from last week

-   What is the full experimental design of the Sacramento (SMUD) experiment? (Give dimensions, like 2x2, and describe what the treatments are on each dimension.)
-   Return to Table 1. Note that the title section of the table clarifies that there is “clustering by household ID.” What does this mean?
-   What impact would you expect this clustering to have on the results in the table?

## Reading Montgomery

This is a nice article that both demonstrates treatment effects using the language that we have built in this course, and also the issues that exist when conditioning on ``bad controls.''
-  Section 1: Introduces the problem
-  Section 2: Can be skipped -- it just decribes how prevalent conditioning on post-treatment controls (i.e. bad controls) happens in political science
-  Section 3: Ensure that you can map how we move from the causal notation into the notation of the causal graph in Figures 1 and 2. Do you find this notation useful? Additionally, how does dropping observations based on post-treatment measured variables "ruin" the randomization? Can you follow along with the method of argument in section 3.4? Here, the authors are generating simulated data that has *no* treatment effect (on Y) but does have a treatment effect on the bad-control. How does this show the dangers of bad controls?
-  Section 4: These are instructive examples of when people make a mistake and condition on post-treatment variables (the first example by Dickson, Gordon and Huber (2015)); and do NOT make the mistake (our very own Broockman and Butler (2015)). 

## If time: Fundamentally Unanswerable Questions
-   According to MHE, what constitutes a FUQ? Brainstorm examples of them.

# Week 7: Heterogeneous Treatment Effects


We’ve assigned two readings this week. Several sections of an academic article by Johnson, Lewis, and Reiley on advertising effectiveness, followed by an industry article on A/B testing. Below you’ll find questions to guide your reading. In between those two reading discussions, we will do some practice with estimating heterogeneous treatment effects in R, using the original data from the teacher-incentives experiment by Muralidharan and Sundararaman.

## [*Goodson article*](http://www.qubitproducts.com/sites/default/files/pdf/most_winning_ab_test_results_are_illusory.pdf) on A/B testing

-   What are the three most important messages of the Goodson article?
-   What relationships do you see between these messages and the textbook reading for this week?

## Muralidharan and Sundararaman (Journal of Political Economy, 2011)
There’s no need to read [*the paper*](http://www.jstor.org/stable/10.1086/659655) before class. We’ve already read a good description of the experiment in the textbook. The main reason we refer to the original paper is so that we can see the full set of results (including standard errors!).

We are going to practice reproducing the HTEs obtained by the authors, using original data we’ve obtained from them. Our goal is to estimate heterogenous effects of the incentive treatment by teacher education. That is, we will want to reproduce Column 5 of Table 6A in the paper. You'll need to pay attention to the fact that in the table, they only report three coefficients of interest, but they actually include some other covariates in the specification.

And here you can download the [*full dataset (35MB)*](https://drive.google.com/file/d/0B_Qj0otlErJqTWZsM0VLMVR4ZmM/view?usp=sharing) from Muralidharan and Sundararaman. You will also find [*these variable definitions*](https://docs.google.com/a/davidreiley.com/document/d/15vZWNovMaKnNaMYiIykuMia6nauGesq6VXJ-awfhct0/edit) useful for the exercise we’re about to do.

Questions for Breakout 2:
-   First, let’s ignore clustering and just reproduce the OLS coefficients in Column 5 of the table, on HTEs by teacher education level.
    -   Hint: To generate fixed effects, you’ll want to use *as.factor()* wrapped inside the *lm()* function.
-   Once you’ve done that, try implementing clustered standard errors to see if you can get the same standard errors in the paper. Why do we cluster at the school level?
-   How different are the clustered standard errors from the OLS standard errors? What does this mean about the data?

Questions for Breakout 3:
-   For the previous data, estimate a fully saturated model with interaction effects by parental literacy level.
-   What’s good about this model, compared to the one the authors used in the paper?
-   Which literacy level has the largest treatment effect?
-   Which has the smallest?
-   How can we tell whether these two most extreme groups’ treatment effects are statistically significantly different from each other?

**If time: [*Johnson, Lewis, and Reiley*](http://www.davidreiley.com/papers/LocationLocationLocation.pdf) **

Begin by reading Sections 1, 2, and 3.1. Then, for Section 4.3, you can skip the beginning and end of the section. Read only from the last paragraph of page 23 (“Table 4 presents..”) to the first sentence of page 25 (“... weaker for distance and income.”). We’ll read a bit more of the paper next week.

Questions to think about during your reading (and in Breakout 1):
-   Describe at least two ways that the experimental design differs from the earlier experiment of [*Lewis and Reiley*](http://www.davidreiley.com/papers/OnlineAdsOfflineSales.pdf).
-   What are the different heterogeneous treatment effects (HTEs) examined by the authors?
-   Where might you be skeptical that the authors have gone on a fishing expedition when looking for these heterogeneous treatment effects?

# Week 8: Noncompliance

## Gerber and Green (2005)

-   In Table 1 from the [*article*](../readings/GerberGreen.2005.pdf), what is the meaning of each of the cells? Explain.
-   What do the outcomes for the placebo group who were contacted illustrate about the validity of comparing those contacted in the treatment group to the entire control group?
-   Describe three different ways you could compute an treatment-control difference.
-   Which of these estimates are ATE for everyone, and which are CACE?
-   Which of these three estimators will give the most precision, and why?

<!-- Johnson, Lewis, and Reiley reading on advertising effectiveness -->
<!-- --------------------------------------------------------------- -->
<!-- -   What to read: -->
<!--     -   First review section III.A of the earlier paper by [*Lewis and Reiley*](http://www.davidreiley.com/papers/OnlineAdsOfflineSales.pdf). Pay particular attention to Figure 4. -->
<!--     -   Next read section 3.2 and section 4.1 of [*Johnson, Lewis, and Reiley*](http://www.davidreiley.com/papers/LocationLocationLocation.pdf). -->
<!--     -   David and co-authors use “location” in more than just the physical sense. What do the difference concepualizations measure, and where are the estimates for these conceptualizations located? -->
<!-- -   Discussion questions: -->
<!--     -   Table 2 of Lewis and Reiley includes the ITT and the CACE, though they do not use this particular language to describe them. Which column gives the ITT, and which one gives the CACE? -->
<!--     -   What was the placebo design adopted by the authors in [*Johnson, Lewis, and Reiley*](http://www.davidreiley.com/papers/LocationLocationLocation.pdf) in order to be able to compute a more precise estimate of the CACE? Why does this placebo design give a more precise estimate? -->

## "Experiment Design"

- This notational system is _another_ notational system. But, what might be the benefits of abstracting up from potential outcomes to a "_design based_" system? 
- You can mostly ignore the "Quasi-Experiment" section.
- What are the letters or the vocabulary in this design notation mean? R? O? X? N?
- What are these "threats" that keep coming up in the two-group experiment design section? (If you're unsure, you can look back into the Internal Validity section). Why is a two-group design robust to conerns about history (something else in the world happens that causes our difference), or unit maturation (units change over time), or testing and instrumentation, while a one-group (i.e. no control group) would not be?

## Incomplete Control over Treatment

- While to this point we've been considering only that the people that we assign to treatment take treatment, in practice your units will do everything they can to misbehave. They don't like their vitamins, or the taste of the medicine, or the new layout of the site, or updating their browser, or... the list goes on and on.
- What is the consequence of people failing to get the treatment (when you assign them to take it), if that failure is _completely at random_? 
- What is the consequence of people failing to get the treatment (when you assign them to take it), if the units can selection into failing? (Since randomization is of _paramount_ importance in making a structured comparison between potential outcomes, think about the groups that you're left able to compare -- defined by observables -- and the groups that you're unable to compare.)
- If you don't know that people aren't taking the treatment, can you correct your estimates? 

## FE exercises

-   FE, problem 5.5
-   FE, problem 5.8
    -   First, make a table that organizes all these numbers in a manner that makes it easier to compare relevant groups and estimate quantities of interest. Note that you will be answering part (a), and figure out what you’ll need to use for it.
    -   Next, answer parts (a), (b), and (d).

        -   Note that ITT<sub>D</sub> is the same as *α* from the async video material. We avoided using ITT<sub>D</sub> because we find it confusing notation, but you need to know how to translate in order to understand what the textbook is saying.
    -   Finally, point out two numbers that we did not use in answering parts (a), (b), and (d), despite the fact that they were mentioned in the statement fo the problem. Why did we not use them?

# Week 9: Spillovers


## [*Miguel and Kremer (2004) reading*](../readings/Miguel.2004.pdf)

Think about the following discussion questions to guide your reading of the article.
-   What is the spillover problem in this setting?
-   How did doctors get the wrong answer in randomized trials before economists Miguel and Kremer addressed the spillover problem?
-   When not taken into account correctly, did the spillovers to cause underestimation or overestimation of the treatment effect? Explain why.
-   Which feature do the authors choose to make their experiment less vulnerable to this spillover problem?
-   How do the authors still have a (smaller) spillover problem despite this design decision?
-   What was the compliance rate for those whom the researchers intended to treat in 1998?
-   Name two kinds of noncompliance described in the article, and say which one was largest.
-   Due to noncompliance, we can only measure the CACE rather than the ATE. Why is the CACE just fine for the policy question asked in the article?
-   Do you see an example of a stepped-wedge design in this article? Explain.

## [*Blake and Coey (2014) reading*](../readings/Blake.2014.pdf)


Think about the following discussion questions to guide your reading of the article. 
-   What is the treatment, and how does treatment assignment work?
-   What is the outcome, and how is it measured?
-   How does this experimental setup generate spillovers within an auction?
-   What is the naive research strategy that produces a biased estimate in the presence of the spillover?
-   Tell a story to explain why the within-auction spillovers might give you upward bias in the measured treatment effect.
-   (Optional; harder) How does the experiment generate spillovers between auctions?
-   Tell a story to explain why you might get downward bias from between-auction spillovers.
-   What is the proposed empirical analysis strategy to reduce the bias?
-   What would be a better experimental design to conduct in the first place?
-   Do you see an example of a stepped-wedge design in this article? Explain.

[*Lyft*](https://eng.lyft.com/experimentation-in-a-ridesharing-marketplace-b39db027a66e#.dqcrp06rl) and [*Uber*](https://www.bloomberg.com/view/articles/2016-09-08/computing-the-social-value-of-uber-it-s-high)
--------------------------------------------------------------------------------------------

- How does the booting of Uber in Austin, Tx perform a nice "cluster randomization" for us? Are there spillover concerns? Are there other inference concerns?
- What is the *core* nature of the difficulty with giving people "prime-time" or "rush" pricing if you're trying to estimate the price elasticity of users?
- What is the *specific* nature of the interference or spillover in the Lyft article?
- Challenge question: How would you calculate the emprirical change in the likelihood of rides under this spillover? Is this even possible?
- How does the bias-variance chart presented in the Lyft article strike you? 

## Spillovers in team projects

In a breakout session with your team, we’ll ask you to brainstorm spillovers that might occur in your experiment.
-   Think of at least one possible spillover that could happen in your experiment. You might have to make up something outlandish, or it might be easy.
-   Discuss how the spillover could bias your estimate of the treatment effect.
-   Discuss an experimental design that might help you get a more unbiased answer.
-   Discuss how likely you think this spillover is to occur, and whether you think it is (or would have been) something worth worrying about in your experimental design.

## (If time) FE exercises
-   FE exercise 8.1 (a and b only)
-   FE exercise 8.3 (Clarification: the phrase “causal [*estimand*](http://en.wikipedia.org/wiki/Estimand)” means the treatment effect we’re interested in.)

# Week 10: Common problems and diagnostics

## DiNardo and Pischke (1997), [*The returns to computer use revisited*](../readings/DinardoPischke_1997.pdf).

-   What’s the basic approach of the study by Krueger the authors are critiquing?
-   What’s the “placebo test” here?
-   Why do the results of this “placebo test” make us doubt Krueger’s original conclusion?
-   What is the difference between a placebo test and a placebo design?
-   Think about one of the observational studies you originally critiquest in Week 2.  What placebo test might be conducted to suggest that the correlations weren’t causal?

## Simonsohn, Nelson, and Simmons (2014), [*P-curve: a key to the file drawer*](../readings/Simonsohn.2014.pdf).

-   What is the difference between “publication bias” and “p-hacking”?
-   What does it mean when the authors say, “When a studied effect is nonexistent, every p-value is equally likely to be observed, and p-curve will be uniform”?
-   What does it mean when the authors say, “When a studied effect does exist (i.e., the null is false), the expected distribution of p values of independent tests is right- skewed”?
-   Read the two pages beginning with “A Demonstration” and check out Figure 3. Why is there a difference between the observed p-values in the left and right panels?
-   What would you do if you suspected a colleague of p-hacking?
-   What steps can we take as researchers to avoid p-hacking ourselves?

## Diagnostics applied to team projects

-   What would a covariate balance check look like for the data you are collecting?
-   What would a manipulation check look like for the data you are collecting?

## Inverse probability weighting by probability of treatment assignment

We have prepared a [*document*](https://docs.google.com/a/davidreiley.com/document/d/1P0wVB-QLw9b3WsXyc_sCm8ym_rFxKvKyxVYbax_sJs0/edit#heading=h.3rxkdn36bylv) to explain this concept, which should be useful for exercise FE 8.6. We saw precision weighting in this week’s discussion of meta-analysis; this is another useful kind of weighting when different groups of individuals have different probabilities of treatment assignment.

# Week 11 - Causality from Observational Data (IV, RD)


## The Gift of Time? [Dee and Sievertsen](../readings/Dee.2015.pdf)

- General design questions 
    - What is the design of the study?
    - What is the forcing variable?
    - What is the discontinuity?
- Do you believe that being on one side or another of the cuttoff is
  _plausibly_ random? Why or why not? What are the major strengths
  and weaknesses of this as a form of "exogenation"?
- What is the confound between start age and age at test taking? Why
  is this so serious, and how do the authors get around it?
- The authors make an "external validity" caveat on/about
  page 9. What do they mean by this? Do you still believe the causal
  quantity that they are estimating is _causal_? If so, for whom? If
  not, why not?
- "In each regression, we include school fixed effects, so that we
  are effectively making comparisons among studetns in the same
  school." What do the authors mean? How does this work? Why is this
  sometimes called a "within estimator"?
- Why would a "simple" OLS estimator of the School Starting Age
  (SSA) on the outcome _not_ estimate a causal quantity?
- How does model (2) identify a causal effect?
- What is the manipulation check for this forcing variable? Where is
  this check reported? Does the manipulation check seem to pass or
  fail?
- What is the concern with systematic manipulation around the
  cuttoff? What is the McCrary test for this?
- "Because our estimates are defined by variation around the January
  1st thresh- old, they are necessarily local estimates." What is
  meant by this sentence on page 23. 


## Difference in Differences reading: [*Garbage incinerators and home prices*](https://espin086.wordpress.com/2010/08/08/difference-in-difference-estimation-garbage-incinerators-and-home-prices/)
-   What is the design of the study?
    -   What’s the outcome?
    -   What’s the treatment?
    -   What comparison is made?
-   Why is the inclusion of a comparison group so important?
    -   What incorrect conclusion might we have reached if we had just looked at the trend over time without a comparison group?
-   And why do we need the before-after difference, rather than just comparing the two comparison groups after the incinerator has been built?
-   Think of a critique that one could still make of this design. Can you find a story that would be consistent with the empirical analysis, and also with zero effect of incinerators on home prices?
    -   It may help to start by asking: What kind of alternative stories can one tell about DID designs in general? What’s a key assumption on which DID is based?
    -   Now, how can you imagine that key assumption being violated here? What’s an alternative causal explanation that’s consistent with the statistical result?
-   What did we learn in the paper by [*Lewis and Reiley*](http://www.davidreiley.com/papers/OnlineAdsOfflineSales.pdf) about the costs and benefits of using DID versus (1) a simple observational study, or (2) a simple experimental comparison?

## Natural Experiment reading: [*Adam Glynn and Maya Sen*](../readings/Glynn.2014.pdf)

-   What is the design of the study?
    -   What is the “treatment?”
    -   What is the outcome?
    -   What is the mechanism of random assignment?
-   What does the study find?
-   Why is it important for the authors to condition on the number of children?
-   Give an alternative explanation for the finding of the study (that is, one that questions whether it is a valid causal effect).
-   Imagine you believe that this *is* a valid causal effect. Give an alternative mechanism for the substantive interpretation of the study that having a daughter changes legislators’ personal views.

## Optional Reading: Regression Discontinuity reading: [*Rafael Lalive*](http://www.econstor.eu/bitstream/10419/25810/1/517022656.PDF)

-   We suggest reading the following parts carefully:
    -   Abstract
    -   First three paragraphs of the introduction
    -   Table 1
    -   Figures 1-4
    -   Skim additional sections of Sections 2-3 if needed to understand better.
-   What is the design of the study?
-   What is the “discontinuity”?
-   Why might examining observations just on either side of the discontinuity be better than examining all observations with and without unemployment insurance?
-   Let’s think about whether we can tell a story to invalidate the causal inference from this study. Remember that one thing that can go wrong with RD designs is if people decide to “game” the discontinuity point. The treatment here only applies to the subset of workers who leave a job. Under this unemployment-benefit policy, why might different kinds of people leave jobs when they are 49.9 years old versus 50.1 years old? How would this change your interpretation of the treatment effect?
-   Check out Figure 2 on page 16. What are some reasons Figure 2 is so convincing?
-   What is the placebo test in Figure 4? Do you find it convincing?
x

# Week 12 - Attrition, Mediation, Generalizability

## [*Bates and Glennerster*](../readings/bates_2017.pdf)
- Bates and Glennerster suggest four *misguided approaches*  that might better be called, ways that other people think about generalizability, but the headings are rather misleading. Recast the headings into four more descriptive sentences instead. I'll do the first for you:
    1. An effect learned in a particular context (or location) can never be informative of another location.
    2.
    3.
    4.
- B&G suggest a second four-item way to intead reason about generalizability. 
    - What are these four steps?
    - B&G then illustrate these steps with little more than examples. Can you instead describe what each step means?
	- Now, suppose that you're the decision-maker who has to decide whether to run the experiment signs about towel re-use in Arizona (now for a third trial). How woud you use the four-step framework to evaluate whether to run another experiment?  
- Throughout the async, David Broockman highlights the extreme difficulty in generating data that tests mechanisms. So, isn't the Bates and Glennerster argument tantamount to saying, "Just think about this impossible thing that you're never going to be able to measure?" Or, can you use their framework profitably to generalize to other contexts? 

## [*Allcott and Rogers*](https://drive.google.com/file/d/0BxwM1dZBYvxBR0QwVWc5WmliVjg/view?usp=sharing)
-   What does “action and backsliding” mean?
-   What data is shown in each of the lines in Figure 2?
-   What conclusion should we reach from the “monthly” line in Figure 2?
-   What conclusion should we reach from the contrast between the two lines?
-   What does “Residualized ATE” mean? (Challenge question.)
-   What’s the difference between the “Continued Group” and the “Dropped Group” in Figure 4?
-   Why doesn’t Figure 4 have a line for the control group?
-   Why do the lines in Figure 4 bob up and down?
-   Why does Figure 4 use the ATE instead of the “Residualized ATE”? (Challenge question.)
-   If you were the CEO of a utility company planning to implement OPower’s program for the first time, how would you design the series of mailings to maximize long-run energy savings?
-   What evidence do Allcott and Rogers provide about “physical mechanisms” for these effects? What do they conclude?
-   What “behavioral models” do Allcott and Rogers find more likely based on these data? What is their evidence for this claim?



## Questions from FE on attrition

-   FE 7.7
-   FE 7.8 a, b

## Think about these week’s topics as applied to your project

-   **Mediation.** What is an example of mediation in your project? That is, what is an example of a deeper reason why the treatment effect might occur, and how might you look for data that might be informative about that theory?
-   **Generalizability.** What are some potential limits on the generalizability of your study? Give specific examples. For example:
    -   What’s a population among which your treatment might have a different effect and why? Could it even be of a different sign (that is, negative instead of positive)?
    -   What’s a different version of your treatment that might have different effects? (For example, “music” might mean “punk rock music” instead of “easy listening jazz music.”) Why might it be different?
    -   Might your treatment have a different short-term than long-term effect? Why?
-   **Attrition.** Is there an example of attrition in your project? If so, how might you want to handle it?

# Week 13 - Examples of Experiments


## [*Sherman et al.*](https://drive.google.com/file/d/0B_Qj0otlErJqaXFITWs1MVRsZW8/view?usp=sharing) reading: Police Raids and Crack Houses

-   How were households selected for the experiment, and how many were selected?
-   How was the random assignment physically conducted?
-   What are the main outcome variables of interest?
-   What does Figure 3 suggest about the effect of the intervention on this outcome?
-   What does the pattern in the control group (mentioned at the beginning of the results section) indicate about the importance of the conducting a randomized experiment?
-   What does “displacement” mean and what evidence do the authors give for it?

## Advocating Experimentation

-   Brainstorm examples of experiments that you would like to convince your employers to run.
    -   What is the research question?
    -   What design do you propose?
-   Choose one of the proposed experiments, and collaborate to come up with an argument that will be convincing to the relevant decisionmaker. Consider the following questions:
    -   Why is the question important to the business?
    -   What will be perceived as costly about the experiment?
    -   Are there stakeholders who might not want to know the true answer?
    -   Who in the organization needs to make better decisions based on the answer?
    -   Can you quantify the hypothesized value of the better decisionmaking?

## In Class Discussions

- There are two talks that we might have; one [advertisements](./facebookAds.org) and one about [gun contro](gunControlDebate.pdf)

# Week 14 - 15 Student Presentations


## Student presentations: plan on 15-20 min plus time for questions


## Ethics discussion: [*Professors’ Research Project Stirs Political Outrage in Montana*](http://www.nytimes.com/2014/10/29/upshot/professors-research-project-stirs-political-outrage-in-montana.html)
-   Do you think this research project was ethical? Why or why not? Please consider the following specific aspects:
    -   What do you think about the idea that the experiment might have influenced the outcome of the election?
    -   What do you think about the way the experiment presented the information about the candidates?

**Discussion of [*Freedman reading*](../readings/freedman.1991.pdf)**
-   What does Freedman mean by “shoe leather”?
-   What did John Snow learn by applying shoe leather?
-   At the bottom of page 306, Freedman says “Testing one model on 24 different data sets could open a serious enquiry… Testing 24 models on one data set is less serious.” Restate this idea in your own words. Relate this idea to one of the important concepts we’ve discussed in the course.
-   Is “shoe leather” really necessary in the era of Big Data? Why or why not?

## Final questions and wrap-up
---------------------------
-   What are your big takeaways from the course?
    --------------------------------------------
-   If you have suggestions for improving the course, don’t forget to put them into an extra-credit assignment.


