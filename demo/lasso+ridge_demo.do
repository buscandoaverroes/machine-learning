/*___________________________________________________________________________________________________
| Name: lasso+ridge_demo.do
| Date: May, 2020
| Author: Tom
| Description: Walks through a series of lasso and ridge techniques
|___________________________________________________________________________________________________*/

/*Note: This file will automatically downloaded files found on University of California's
		Machine Learning Respository, here: https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/
*/

if (0) {

* 0. Global settings
	/*You should change these paths to where you want them on your computer.*/

	* output folder
	global 	output 	"/Users/tommosher/Documents/GitHub/machine-learning/output/"

* 1. Download packages _____________________________________________________________________________

	ssc install pdslasso ///
			, replace

	net install lassopack ///
			, from("https://raw.githubusercontent.com/statalasso/lassopack/master/lassopack_v131/") ///
			replace

	ssc install estout ///
			, replace

*2. A quick, non-ML demo _______________________________________________________________________

	sysuse 	auto, clear

	reg 	price 			/*outcome variable*/	///
			foreign weight /*explanatory variables*/

*3. Baisc ML example  _______________________________________________________________________
}

* Lasso

/*
import delimited using ///
 				"http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv" ///
 				, clear
				*/

	import delimited using "/Users/tommosher/Documents/dta/repo-data/ml/wine/winequality-red.csv" ///
					, clear
	describe 		, short
	global 			winevars 	fixedacidity volatileacidity citricacid residualsugar chlorides ///
								freesulfurdioxide totalsulfurdioxide ph sulphates alcohol

	lasso2 			quality ///							/* outcome variable, continuous */
						${winevars}	///					/* potential explanatory variables */
							, plotpath(lambda) ///		/* plots the lambda path	*/
							plotlabel ///				/* puts labels on the lines  */
							plotvar(${winevars}) ///	/* tells stata to plot all the explanatory vars */
							plotopt(legend(on)) ///		/* turns the legend on beneath the graph */
							alpha(1) /// 				/* where =1 means lasso technique, 0 means ridge */
							long						/* turns on full output  */

	graph export 	"Output/wine-lasso-path.png", replace

	lasso2, 		lic(ebic)							/* where lambda == 36.06796228930389 */

* cross validation
	cvlasso 		quality ///							/* outcome variable */
	 					${winevars}	///					/* explanatory vars */
							, plotcv ///				/* plots the error as a function of lambda */
							seed(123) /// 				/* sets a random seed */
							lopt /// 					/* estimate the model with the ideal lambda */
							alpha(1) /// 				/* sets method to lasso */
							postest 					/* allows for more postestimation things  */

	global 			lassovars = e(selected)				/* stores the variables selected by the ideal model */
														/* now selected lambda == 10.761 */

	reg 			quality 	${lassovars}			/* runs OLS with the variables selected */


* Ridge

import delimited using ///
				"https://web.stanford.edu/~hastie/ElemStatLearn/datasets/prostate.data" ///
				, clear

	global rhsvars 	lcavol lweight age lbph svi lcp gleason pgg45


	* first try lasso
	lasso2 			lpsa ///							/* outcome variable, continuous */
						${rhsvars}	///					/* potential explanatory variables */
							, plotpath(lambda) ///		/* plots the lambda path	*/
							plotlabel ///				/* puts labels on the lines  */
							plotvar(${rhsvars}) ///		/* tells stata to plot all the explanatory vars */
							plotopt(legend(on)) ///		/* turns the legend on beneath the graph */
							alpha(1) /// 				/* where =1 means lasso technique, 0 means ridge */
							postresults ///
							lic(ebic) ///
							long						/* turns on full output  */
	global 				lpsalasso  = e(selected)		/* store the variables selected by lasso */

	graph export 		"$output/lpsa-lasso-graph.png", replace

	* now try ridge
	lasso2 			lpsa ///							/* outcome variable, continuous */
						${rhsvars}	///					/* potential explanatory variables */
							, plotpath(lambda) ///		/* plots the lambda path	*/
							plotlabel ///				/* puts labels on the lines  */
							plotvar(${rhsvars}) ///		/* tells stata to plot all the explanatory vars */
							plotopt(legend(on)) ///		/* turns the legend on beneath the graph */
							alpha(0) /// 				/* where =1 means lasso technique, 0 means ridge */
							lic(ebic) ///
							postresults ///
							long						/* turns on full output  */
	global 				lpsaridge  = e(selected)		/* store the variables selected by lasso */

	graph export 		"$output/lpsa-ridge-graph.png", replace

	eststo lasso: reg lpsa ${lpsalasso}
	eststo ridge: reg lpsa ${lpsaridge}
