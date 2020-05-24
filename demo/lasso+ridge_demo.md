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

Now let's run our lasso command. Remember that lasso is an algorithm that selects explanatory variables as a function of lamba, a coefficient "penalty". The one option worth noting with this command is: alpha(1). This tells Stata to run a **lasso** algorithm as opposed to ridge (see more explanation in the theory file). I'll include other options that you can see explained in the do file.

```{stata}
lasso2 quality ${winevars}, plotpath(lambda) plotlabel plotvar(${winevars}) plotopt(legend(on)) alpha(1)
```

If we take a look at the full table, we notice that as lambda decreases, more variables are added to our model. (This is because the "pentalty" or adding additional variables decreases as lambda decreases.) We can see this trend by looking at the generated output graph. As lambda increases, the coefficents for our covariates decreases until they reach 0 -- that is, when they are dropped from the model all together. But notice how some variables, such as **citricacid** "drop off" quicker than others, such as **volatileacidity**. One might interpret this as an indication that variables that are "slower" to drop off are better predictors of wine quality; this may be a general rule of thumb but is not always true. The iteration higlighted with a **"*"** will indicate the model with the lowest error (as measured by ebic). 7 variables are included in this model. Let's note the value of lambda that gave us our lowest "error": 51.99287. This is our "selected lambda"

Our next command will run standard OLS with the 7 variable selected by the lasso algorithm. It won't give us the full output we're used to with **reg**, but it will at least give us the value of the coefficients:
```{stata}
lasso2, 		lic(ebic)
```

## Cross-Validation

Cross-validation is a means of testing out-of-sample fit. We want to develop a model that is valid not only for our data in the data, but, in our case, for all wine. We'll do this by dividing the dataset into *k* folds, or a certain number of equal divisions. The standard number is 10, so since our dataset has about 1,600 observations, each *fold* will have about 160 wine samples. The algorithm then takes a large majority of the folds and uses this subset to develop its lasso model as we did above. Then it uses the remaning folds to "test" the model. The assumption is that, with large enough datasets, a randomly-divided dataset will generate enough variance between the "training" and "test" divisions that the "test" portion can approximate the differences of out-of-sample data.

### A side-note on training and test data
This assumption I just explained about gets at what I see as a fundamental problem of applying machine-learning techniques to development problems: heterogeneity in data availability. Let's use an invented example. Let's say I want to predict likelihood of forest fires based on satellite images. I collect my data using the best publicly available images from NASA or NOAA that I can find, develop my theory of change, and maybe use lasso to fine-tune my model. This is great, but suppose NASA has much better quality images of North America than anywhere else. Even if I train my model on images from around the world, can I really say that my "test" data is good enough to create valid model for terrain that has different tree species, different roof coverings, and other differences that aren't captured in the lesser-quality images?

## Back to Cross-validation

Lassopack also includes a cross-validation command called **cvlasso** that works very similarly to **lasso2**. We'll run this command, and also capture the selected varialbes in a global so we can run a better OLS command than last time. Keep in mind that if you type

```{stata, nooutput}
help cvlasso
```
you'll see that you can ajust the number of k-folds in the options.

```{stata}
cvlasso 		quality ${winevars}, plotcv seed(123) lopt alpha(1) postest
global 			lassovars = e(selected)
```
Notice how the graph now is different: we see the natural log of lambda (indicated by a red line) that generated the model with the lowest error. Notice that the corss-validation method gave us a different ideal lambda value: `{stata} %9.1f e(lopt)'. Since we stored the variables the cvlasso command selected, we can run OLS with these variables with
```{stata}
reg 			quality 	${lassovars}
```
Now that we have significance values, we can look and see which chemical components are strong predictors of quality.

## Ridge

Recall that ridge operates very similarly to lasso. The main differences is that, due to squared constraint term, no coveriates will every be *completely* dropped from the model; "unimportant" covariates will only see their coefficents reduced to near-zero.

Let's use a new dataset to explore ridge. This one from Prof. Hastie for predicting rates of prostate cancer. (Btw, his website is here for more info and datasets: http://web.stanford.edu/~hastie/pub.htm)

```{stata, nooutput}
import delimited using "https://web.stanford.edu/~hastie/ElemStatLearn/datasets/prostate.data", clear
```
We'll follow the steps above, except we'll tell stata to set *alpha=0* in the options, which indicates a ridge regression. **Lpsa** is our outcome variable of interest, and we'll group the explanatory variables in a global like last time. Let's run a lasso before ridge so we can compare.

```{stata}
global 			rhsvars 	lcavol lweight age lbph svi lcp gleason pgg45
lasso2 			lpsa ${rhsvars}	, plotpath(lambda) plotlabel plotvar(${rhsvars}) plotopt(legend(on)) alpha(1) lic(ebic) postresults long
global 				lpsalasso  = e(selected)		/* store the variables selected by lasso */
graph export 		"lpsa-lasso-graph.png", replace
```
Note our selected lambda value, and that we have three covariates with that value. Now let's run the same selection of variables with ridge.

```{stata}
lasso2 				lpsa ${rhsvars}	, plotpath(lambda) plotlabel plotvar(${rhsvars}) plotopt(legend(on)) alpha(0) lic(ebic) postresults long
global 				lpsaridge  = e(selected)
graph export 		"lpsa-ridge-graph.png", replace
```
Notice how the ridge graph coefficent paths all approach zero as lambda approaches infinity, but never actually reach it. Likewise, if we compare the two following regressions with the lasso- and ridge-selected variables, we notice that the ridge regression includes all variables.
```{stata}
eststo lasso: reg lpsa ${lpsalasso}
eststo ridge: reg lpsa ${lpsaridge}
```
