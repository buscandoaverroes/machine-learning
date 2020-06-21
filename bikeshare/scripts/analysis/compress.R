# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: compress.R
# Description: compresses the .dta file into R, hopefully faster.
#
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
                  


      
# examples ----
      
      

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

      # registerDoParallel(numCores)
      # foreach (i = 1:3, .combine = rbind) %dopar% {
      #   sqrt(i)
      # } 
      # 
                        

                        # ---- Import the dta file ----
     
      
      if (size == 1) {
      
    bks2 <- read.dta13(file.path(tiny),
                      convert.factors = TRUE,
                      nonint.factors = TRUE) # keep the factor labels for all

      }
      
      
      if (size == 2) {
        
    bks <- read.dta13(file.path(master),
                        convert.factors = TRUE,
                        nonint.factors = TRUE) # keep the factor labels for all
      
      }
      
      
      if (size == 3) {
        
        bks <- data.table::fread(file.path(csv),
                                 header = TRUE,
                                 na.strings = ".",  # tell characters to be read as missing
                                 stringsAsFactors = TRUE,
                                 showProgress = TRUE, 
                                 data.table = FALSE
                                 ) # return data frame, not table   
      }
      
      # clean up member, dummy

      
      
                       # ---- Prepare datasets for sum stats ----
     
      
      
    # general manipulations 
  
       # bks <- mutate(bks,
       #            yrmember = (member == "Member") )   not needed since fixed in stata?
      