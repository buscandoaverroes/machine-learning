# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: compres.R
# Description: compresses the .dta file into R, hopefully faster.
#
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
                  



                        # ---- Opening  ---- 
                        
                        #-------------#
                        # packages    #
                        #-------------#

#package names
pacman::p_load(stargazer,
               tidyverse,
               readstata13,
               reshape2,
               data.table,
               shiny,
               readstata13)

                        

                        #-------------#
                        # Set User    #
                        #-------------#
                        
  #     1         buscandoaverroes 
  #     2         other
                        
                        
    user <- 1
                        
                        
                        
    
                        
                        #-------------#
                        # File paths  #
                        #-------------#
                        
              
    if (user == 1) {
      # scripts
      repo  <- "/Users/tommosher/Documents/GitHub/machine-learning/bikeshare" 
      
      # data
      data        <- "/Users/tommosher/Documents/dta/bikeshare" 
      
    }
    
    if (user == 2) {
      # Main folder
     # projectFolder  <- "" # Tom's WB code folder
      
      # data
     # rawData        <- "" # .dta data
    }
    
    
    # same no matter the user.
    scripts           <- file.path(repo,"scripts")
    analysis          <- file.path(scripts, "analysis")
    
    raw               <- file.path(data, "raw")   
    MasterData        <- file.path(data, "MasterData")
      full            <- file.path(data, "full")
    
                        
                        

                        # ---- Import the dta file ----
      
      
      library(parallel)
      library(MASS)
      
      starts <- rep(100, 40)
      fx <- function(nstart) kmeans(Boston, 4, nstart=nstart)
      numCores <- detectCores()
      numCores
      
      
      
      
      system.time(
        results <- lapply(starts, fx)
      )
      
      
      system.time(
        results <- mclapply(starts, fx, mc.cores = numCores)
      )
	
    bks <- read.dta13(file.path(MasterData, "/master.dta"))
                      
