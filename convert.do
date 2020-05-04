* this file generates html files from source txt files

* set working directory
	local 	repo /Users/tommosher/Documents/GitHub/machine-learning // change to where you store the repo. watch for spaces in file path.

* convert source file into html.
	dyndoc 	"`repo'/lasso+ridge_demo.txt" ///
				, saving("`repo'/lasso+ridge_demo.txt") ///
				nostop replace
