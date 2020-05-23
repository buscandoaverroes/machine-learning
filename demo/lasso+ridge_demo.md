#A tutorial/walkthrough of basic lasso and ridge model selection techniques

This is a stylized version of a lasso and ridge commands in Stata. The best way to follow along is to download the accompanying "lasso+ridge.do" script which includes on the Stata commands from this file. Be sure to change the file paths to match those of your computer.

## Introduction

From what little I know about machine learning (ML) is that Stata has been somewhat slow to the game. Version 16, released less than a year ago in the summer of 2019, finally included an in-house command **lasso** that performs many of the functions that were previously found only in community-written packages. I learned using one of these packages called lassopack -- which includes the command **lasso2**. This packages is available on SSC and we'll use that package here to demonstrate lasso and ridge algorithms. I don't have much experience with the in-house command built into version 16 and the few times I have used it, I get results that I don't expect. When I have time I'll include a separate script that directly compares the results from **lasso2** and **lasso**. In short, I'm skeptical of **lasso** because the command doesn't produce results that I know I should be getting, but I'm very very open to the possibility that I'm not doing something right. If that's the case, please comment and/or show me how to actually use **lasso** properly.

## Getting Started

Anyway, The first thing we need to do is download lassopack from the SSC. We could do so by running the install command from the ssc, which would look like this
```{stata, nooutput}
ssc install pdslasso
```

However, the authors of this particular package (see https://statalasso.github.io/) note that they update their GitHub-hosted version more frequently than that on the SSC. We'll install directly from GitHub instead and use

```{stata, nooutput}
net install lassopack, from("https://raw.githubusercontent.com/statalasso/lassopack/master/lassopack_v131/") replace
```

We'll also be using the estout package to store results from the lasso commands. You probably know about estout but, if not, I highly recommend familiarizing yourself with it as it will become more and more useful to you over time.
```{stata, nooutput}
ssc install estout, replace
```
Whereas traditional econometrics cares about making sense of relationships between people, actions, and things in the world, the machine-learning approach doesn't really care about any of that. Instead, machine-learning classifies, predicts, and seeks to build the best model independent of theoretical or historical context. Take Google; they just want to know "yes" or "no". Will you click on the ad or not? They've likely got hundreds of variables on "you" and they're pretty good at predicting the answer to that question, for each of us. The World Bank or J-PAL, residing comfortably in the classical econometrical tradition, care much more about making sure the model makes sense in context: does climate change incite violence? Interestingly, from an econometrics perspective, this question becomes very difficult to answer in the affirmative (even though we all know the meteorological and biological evidence of climate change is immense) since very few researchers have told a convincing story that isolates climate change-induced weather variability from other economic or political factors which also affect intermediate factors -- such as food or water insecurity -- that may incite violence. (A fantastic paper by Selby et al that examines climate change and the Syrian Revolution is linked here: https://www.sciencedirect.com/science/article/pii/S0962629816301822) Econometrics cares about "why" and machine-learning cares about what the best model looks like; in a way the former is much harder to do well, in my opinion. But it's also pretty easy to have machine-learning go horribly wrong. The rest of this tutorial will hopefully set us up with some basic conceptual and coding understanding to, at least, not totally mess up machine-learning.

## Traditional Approach

Now we need a dataset. Let's first use one of Stata's built-in datasets to demonstrate an instance where ML won't be as useful.

```{stata, nooutput}
sysuse auto, clear
```

Now let's say we want to predict the car's price. An econometric approach might ask what factors predict price (in miles/gallon) by examining the context of the US auto market in the late 1970s. We might surmise that foreign cars, subject to import tariffs, are likely to be more expensive; also, cars that weigh more might indicate less efficiency. We could run lasso or ridge here, but using our rough "theory of change" we can tell a pretty convincing story already: foreign and weight are two strong predictors using OLS.
```{stata}
reg price	foreign weight
```

## Lasso

Great, but what happens if we have a dataset about which we know very little? Let's take a look at this one about wine quality from the UCI machine learning repository. When you find a dataset you should always keep in mind what the owners allow you to do with it -- here we're ok to use it for research purposes as long as we cite it, so we will: P. Cortez, A. Cerdeira, F. Almeida, T. Matos and J. Reis. Modeling wine preferences by data mining from physicochemical properties. In Decision Support Systems, Elsevier, 47(4):547-553, 2009.

```{stata, nooutput}
import delimited using "http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv" , clear
```

Great -- now let's describe dataset:

```{stata}
describe, short
```

Looks like each observation is a wine sample, and we have 12 variables, including **quality** that tells us how "good" the wine is. Let's see if we can predict quality from the other variables at our disposal. I know nothing about the chemistry of wine, so I can't use my economic background to help me produce any sort of story. We'll use lasso to help us with **model selection**: it will tell us which variables to include minimize the sum of the error term.

We'll use the command called **lasso2** that we downloaded above. We'll focus on model selection here, but I recommend you check out the package website for all that it can do: https://statalasso.github.io/docs/lassopack/. To see the documentation, type

```{stata, nooutput}
help lasso2
```

If you look at the help file, you'll see that we need to tell Stata in order to make the command run: 1) a dependent variable, 2) and a list of candidate explanatory variables from which the algorithm will select the "best fit" model. If we browse, we see that **quality** is the main outcome variable. Let's create a global called **winevars** to store all of the potential explanatory variables.

```{stata, nooutput}
global 	winevars 	fixedacidity volatileacidity citricacid residualsugar chlorides freesulfurdioxide totalsulfurdioxide ph sulphates alcohol
```

Now let's run our lasso command. The one option worth noting here is: alpha(1). This tells Stata to run a **lasso** algorithm as opposed to ridge (see more explanation in the theory file.) I'll include other options that you can see explained in the do file.

```{stata}
lasso2 quality ${winevars}, plotpath(lambda) plotlabel plotvar(${winevars}) plotopt(legend(on)) alpha(1)
```
