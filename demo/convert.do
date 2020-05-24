* this file generates html files from source txt files

* set working directory
	local 	repo /Users/tommosher/Documents/GitHub/machine-learning/demo // change to where you store the repo. watch for spaces in file path.

* convert source file into html.
	stmd 	"`repo'/lasso+ridge_demo.md" ///
				, saving("`repo'/lasso+ridge_demo.html") ///
				nostop replace
