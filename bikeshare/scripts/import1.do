/*ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
| File: import1.do															|
| Date: May, 2020																		|
| Author: buscandoaverroes																|
| Description: plays around with importing a sample file  		 			|
| ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー*/


						/* - - - - - - - - - - - - - - - - - - - -
									Table of Contents
							1. Import and save as .dta


						 - - - - - - - - - - - - - - - - - - - - */

						 /* Note that this will eventually be converted into a loop. */

	* settings
	local source 				= 2

/*		- - - - -
						 ||		Import the sample file		||
						 												- - - - -				*/
	if `source' == 1 {

		import delimited using 	"${raw}/201910-capitalbikeshare-tripdata.csv", clear

}
	if `source' == 2 {

		import delimited ///
				using ///
				"/Users/tommosher/Documents/dta/bikeshare/raw/201910-capitalbikeshare-tripdata.csv" ///
				, clear

	}


	save 		"${d2019}/2019-10.dta", replace
