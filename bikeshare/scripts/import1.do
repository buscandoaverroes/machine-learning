/*ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
| File: import1.do										|
| Date: May, 2020										|
| Author: buscandoaverroes								|
| Description: plays around with importing a sample file |
| ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー*/

* Import random dataset
 if (0) {
	import delimited 	using  ///
						"/Users/tommosher/Documents/dta/bikeshare/raw/201910-capitalbikeshare-tripdata.csv" ///
						, clear
}

* Check integrity
	ds
	local all 		= r(varlist)
foreach var of local all {
 	qui unique 		`var'
	qui local 		`var'_n = r(N)
	qui local 		`var'_g = r(unique)
	qui mdesc 		`var'
	assert 			r(miss) == 0 // check missings == 0
}

// make assertions
	assert 		`startstationnumber_g' 	== `startstation_g'
	assert 		`endstationnumber_g' 	== `endstation_g'

* explore

sum
	// histogram
preserve
keep if duration < (60*60*1)	// final digit is # hours
hist 	duration if membertype == "Casual" ///
		, bin(80) fraction

restore

	// kernel density
preserve
keep if duration < (60*60*3)	// final digit is # hours
kdensity 	duration if membertype == "Member"


restore
