/*ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
| File: construct.do															|
| Date: May, 2020																		|
| Author: buscandoaverroes																|
| Description: constructs all variables 		 			|
| ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー*/


						/* - - - - - - - - - - - - - - - - - - - -
									Table of Contents
							1. Load
							2. variable construction


						 - - - - - - - - - - - - - - - - - - - - */

						 /* Note that this will eventually be converted into a loop. */

	* settings
	local source 				= 2

	* locals
	local date 					startdate enddate
	local dt 					start

	local dropvars 				startdate enddate membertype

/*		- - - - -
						 ||		1.	Import the 	.dta file	||
						 												- - - - -				*/


	if `source' == 1 {

		use 	"${d2019}/2019-10.dta", clear

}
	if `source' == 2 {

		use 	///
				"/Users/tommosher/Documents/dta/bikeshare/MasterData/2019/2019-10.dta" ///
				, clear

	}


/*		- - - - -
							 ||		2.	Variable Construction 	||
							 												- - - - -				*/


								* ||	 value labels 	|| *

	la def 			month 	1 "January" ///
							2 "February" ///
							3 "March" ///
							4 "April" ///
							5 "May" ///
							6 "June" ///
							7 "July" ///
							8 "August" ///
							9 "September" ///
							10 "October" ///
							11 "November" ///
							12 "December"

	la def 			dow 	0 "Sunday" ///
							1 "Monday" ///
							2 "Tuesday" ///
							3 "Wednesday" ///
							4 "Thursday" ///
							5 "Friday" ///
							6 "Saturday"



								*||		Time variables  	||*


	// minutes
	gen 			min = duration / 60

	// hours
	gen 			hour = min / 60

	// labels
	label var 		min "Duration in Minutes"
	label var 		hour "Duration in Hours"

	// compress + format
	recast 			float ///
					min hour ///
					, force

	format 			%9.2f ///
					min hour





							*||			Dates			||*

	// begin loop
	foreach v in startdate enddate {

		if `v' == enddate {

			// change the tag
			local dt end
		}

	// generate a %tC variable that accounts for leap seconds
	gen 			double datetime`dt' ///
					= Clock(`v', "YMD hms")

	format 			datetime`dt' %tC

	// generate a %td variable (without time)
	gen 			date`dt' = date(`v', "YMD###")
	format 			date`dt' %td

	// generate year, mo, day etc
	gen				year`dt' = year(date`dt')
	gen 			month`dt' : month = month(date`dt')
	gen 			day`dt' = day(date`dt')

	gen 			hour`dt' = hh(datetime`dt')
	gen 			min`dt' = mm(datetime`dt')

	gen 			quarter`dt' = quarter(date`dt')
	gen 			week`dt' = week(date`dt')
	gen 			dow`dt' : dow = dow(date`dt')
	gen 			doy`dt' = doy(date`dt')

	// var labels
	la var 			datetime`dt' 	"`dt' date and time"
	la var 			date`dt' 		"`dt' date"
	la var 			year`dt' 		"`dt' year"
	la var 			month`dt' 		"`dt' month"
	la var 			day`dt' 		"`dt' day"
	la var 			hour`dt' 		"`dt' hour"
	la var 			min`dt' 		"`dt' minute"
	la var 			quarter`dt'		"`dt' quarter of year"
	la var 			week`dt' 		"`dt' week of year"
	la var 			dow`dt' 		"`dt' day of week"
	la var 			doy`dt' 		"`dt' day of year"



	}








							*||		Member Type		||*

	// make sure there are only two member types
	levelsof 		membertype
	assert 			r(r) == 2

	// define label
	la def 			mbr 0 "Guest" ///
						1 "Member"

	// gen var with this label
	gen 			int member: mbr = (membertype == "Member")
	label var 		member "Member or Guest"




***		drop variables *****

	drop 			`dropvars'

	save 			"${d2019}/2019-10.dta", replace
