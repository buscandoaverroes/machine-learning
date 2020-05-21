/*___________________________________________________________________________________________________
| Name: lasso+ridge_demo.do
| Date: May, 2020
| Author: Tom
| Description: Walks through a series of lasso and ridge techniques
|___________________________________________________________________________________________________*/

/*Note: This file will automatically downloaded files found on University of California's
		Machine Learning Respository, here: https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/
*/



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

*3. ML example  _______________________________________________________________________


import delimited using "https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.names", clear
*---> name file maniuplation

	drop 		if v2 != ""			// keep only the names
	drop 		if v1 == ""
	assert 		_N 	  == 57			// make sure ther are 57 obs
	split 		v1 , parse(:) generate(v_) // split the var at ":"
	keep 		v_1					// keep only the first var Generated
	tempfile	names db

	levelsof 			v_1 ///
						, clean local(lbls) 	// store the labels in local
	tokenize 			"`lbls'"				// tokenize
	save 		`names', replace		// save tempfile



* download ML dataset
import delimited 	///
		using "https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.data" ///
		, clear

ds
return list
local 	varlist = r(varlist)	//store list of vars in varlist
local 	length: list sizeof varlist // store no of vars in this local

** define label values first then apply?
forvalues v = 1/`length' {
	label variable  v`v' "``v''"		// apply each label to each variable
}

* save the dataset
save 	`db', replace

* save our explanatory variables in a local
global 	explvars v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 ///
				v11 v12 v13 v14 v15 v16 v17 v18 v19 v20 ///
				v21 v22 v23 v24 v25 v26 v27 v28 v29 v30 ///
				v31 v32 v33 v34 v35 v36 v37 v38 v39 v40 ///
				v41 v42 v43 v44 v45 v46 v47 v48 v49 v50 ///
				v51 v52 v53 v54 v55 v56 v57

* run Lasso
lasso2 v58 $explvars, plotpath(lambda) plotlabel plotvar($explvars) plotopt(legend(off)) alpha(1)

* cv
cvlasso v58 $explvars, plotcv seed(123) lopt alpha(0) postest
gl lassoVars=e(selected) //Save variables selected by lasso, where gl is global
reg v58 $lassoVars
******


import delimited using "/Users/tommosher/Downloads/100 leaves plant species/data_Mar_64.txt", clear
