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

	reg 	mpg 			/*outcome variable*/	///
			foreign weight /*explanatory variables*/

*3. Baisc ML example  _______________________________________________________________________
}
/*
import delimited using ///
 				"http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv" ///
 				, clear
				*/

	import delimited using "/Users/tommosher/Downloads/winequality-white.csv" ///
					, clear

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

	lasso2, 		lic(ebic)							/* where lambda == 36.06796228930389 */

* cross validation
	cvlasso 		quality ///							/* outcome variable */
	 					${winevars}	///					/* explanatory vars */
							, plotcv ///				/* plots the error as a function of lambda */
							seed(123) /// 				/* sets a random seed */
							lopt /// 					/* tells stata to estimate the model with the ideal lambda */
							alpha(1) /// 				/* sets method to lasso */
							postest 					/* allows for more postestimation things  */

	global 			lassovars = e(selected)				/* stores the variables selected by the ideal model */
														/* now selected lambda == 10.761 */

	reg 			quality 	${lassovars}			/* runs OLS with the variables selected */
