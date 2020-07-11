# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: MOTHERbks.R
# Description: primary script for bikeshare r analysis
#
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #




                              
                              # ---- Opening  ---- 
                              
                              #-------------#
                              # packages    #
                              #-------------#

#   package names
  pacman::p_load(stargazer,
                 tidyverse,
                 readstata13,
                 reshape2,
                 data.table,
                 shiny,
                 readstata13,
                 foreach,
                 doParallel,
                 parallel,
                 MASS,
                 readr)
                              
  # install.packages(dplyr)
 
  # library(dplyr)
  # library(stargazer)
  # library(tidyverse)
  # library(readstata13)
  # library(reshape2)
  # library(data.table)
  # library(foreach)
  # library(doParallel)
  # library(parallel)
  # library(parallel)
  # library(MASS)
                    
  
                            



                              #-------------#
                              # Set User    #
                              #-------------#
                              
                              #     1         buscandoaverroes 
                              #     2         other

  
  user <- 1





                              #-------------#
                              # tiny / main #
                              #-------------#
    
  # size == 1 is tiny 
  # size == 2 is master 
  # size == 3 is csv
  
  size <- 3
                              


                              
                              
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
    # projectFolder  <- 
    
    # data
    # rawData        <- 
  }
  
  
  # same no matter the user.
  scripts           <- file.path(repo,"scripts")
  analysis          <- file.path(scripts, "analysis")
  
  raw               <- file.path(data, "raw")   
  MasterData        <- file.path(data, "MasterData")
    full            <- file.path(MasterData, "full")
    tiny            <- file.path(full, "tinymaster.dta")
    master          <- file.path(full, "master.dta")
    csv             <- file.path(full, "master.csv")

                                  
                                    
                                    
                                    
                                    #-------------#
                                    # run scripts #
                                    #-------------#
  
            s1 <- 1   # import 
            s2 <- 1   # year 
            s3 <- 1   # idk

  # import  
  if (s1 == 1) {
    source(file.path(analysis, "import.R"))
  }
            
  # year  
  if (s2 == 1) {
    source(file.path(analysis, "year.R"))
  }
            
 # so try to re-import main csv, bks$member should be only 0 1. 
 # some empty "" strings in some vars (stationnames )
    
  # add "other" dummy var -- maybe this incldues the low-cost fare
  # gen 30 min or less var dummy 