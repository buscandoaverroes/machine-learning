# Machine Learning Repository
A place for sharing ML knowledge among SFS students and recent grads.

## Introduction
When I was a student at SFS I fell in love with machine learning.  It's technically difficult, often misunderstood, and it raises so many ethical questions. I wanted to understand all of these things, so I created this repository for SFS students/recent grads to collaborate on Machine Learning stuff. Feel free to clone, explore, or add. If something does't work please tell me or make a pull request.

## How to use this repository
If you don't know the math behind lasso and ridge, I reccommend you start by reading the pdf in the theory folder. After that, the demo folder will give you the scripts and output to walk through the basics of the lasso and ridge commands. The lasso+ridge_demo.md file will give you a nice online rendering of the document, but won't provide the output -- for that you'll want the lasso+ridge_demo_output.pdf. Alternatively the lasso+ridge_demo.do script allows you to follow along with the pure Stata do-file, which is conducive to editing etc. Finally, the bikeshare folder is where I'm (slowly) working on publicly-available Capital Bikeshare data to see if I can track the effects of COVID-19 on the system usage. 

## General ML resources/things I've come across
<p>Basically start with anything by Susan Athey (https://athey.people.stanford.edu/research).
<p>Stata's [help file](https://www.stata.com/manuals/lassolassointro.pdf#lassoLassointro) for newly-encorporated lasso command.
<p>The Hastie, Tibshirani, and Friedman textbook (https://web.stanford.edu/~hastie/ElemStatLearn/). It seems to be publicly available but check for specfics on downloading.

## Publicly-Available Datasets (make sure to check conditions before downloading)
<p>1. UC Irvine Machine Learning Repo (http://archive.ics.uci.edu/ml/index.php).
<p>2. Awesome Public Datasets via GitHub (https://github.com/awesomedata/awesome-public-datasets#climate-weather)
<p>3. World Bank Open Data via GitHub (https://github.com/jpazvd/wbopendata) or the World Bank [website](https://data.worldbank.org/). Note that the former leads you to a World Bank-create Stata package that allows you to install publicly available data directly within Stata. In Stata, type "ssc install wbopendata".
<p>4. The Capital Bikeshare [datasets](https://www.capitalbikeshare.com/system-data).
