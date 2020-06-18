# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: year.R
# Description: creates dataset where observations are by year
#
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #



                                 #-------------#
                                 # cumulative  # ----
                                 #-------------#

      # keep only obs we need (those that can/need be collapsed by year)
         keep <- c("duration",
                   "min",
                   "hour")                        
     
    # select key variables 
     bks_sml <- select(bks, duration,
                          min,
                          hour,
                          yearstart,
                          startstationnumber,
                          yrmember)
     
     
     # collapse by year
     byyear <- bks_sml %>%
       group_by(yearstart) %>%
       summarise( count = n(),
                  nstation = n_distinct(startstationnumber),
                  mbr_ratio = mean(yrmember, na.rm = TRUE),
                  av_dur = mean(duration, na.rm = TRUE),
                  av_min = mean(min, na.rm = TRUE), 
                  av_hour = mean(hour, na.rm = TRUE),
                  med_dur = median(duration, na.rm = TRUE),
                  med_min = median(min, na.rm = TRUE), 
                  med_hour = median(hour, na.rm = TRUE)
      )
          # create a most visited station by year? or top 3?
     

     # this will work if you reinstall the dplyr package manually...
     #iris %>% select(!c(Sepal.Length, Petal.Length))
     
      
     
     
  
    
     