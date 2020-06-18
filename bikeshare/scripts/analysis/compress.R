# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: compress.R
# Description: compresses the .dta file into R, hopefully faster.
#
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
                  


      
# examples ----
      
      
      # 
      # library(parallel)
      # library(MASS)
      # 
      # starts <- rep(100, 40)
      # fx <- function(nstart) kmeans(Boston, 4, nstart=nstart)
      # numCores <- detectCores()
      # numCores
      # 
      # 
      # 
      # 
      # system.time(
      #   results <- lapply(starts, fx)
      # )
      # 
      # 
      # system.time(
      #   results <- mclapply(starts, fx, mc.cores = numCores)
      # )
      # 
      # 
      # 
      # for (i in 1:3) {
      #   print(sqrt(i))
      # }
      
                        

                        # ---- Import the dta file ----
     
      
      if (size == 1) {
      
    bks <- read.dta13(file.path(tiny),
                      convert.factors = TRUE,
                      nonint.factors = TRUE) # keep the factor labels for all

      }
      
      
      if (size == 2) {
        
    bks <- read.dta13(file.path(master),
                        convert.factors = TRUE,
                        nonint.factors = TRUE) # keep the factor labels for all
      
      }
      
      
      
      
                       # ---- Prepare datasets for sum stats ----
     
      
      
    # general manipulations 
    bks <- mutate(bks,
                  yrmember = (member == "Member") )
      