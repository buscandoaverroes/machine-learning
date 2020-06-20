# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: year.R
# Description: creates dataset where observations are by year
#
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #



                                 #-------------#
                                 # cumulative  # ----
                                 #-------------#
                                 
                                 # this will work if you reinstall the dplyr package manually...
                                 #iris %>% select(!c(Sepal.Length, Petal.Length))
                                 
                                 # create a most visited station by year? or top 3?
                                 
                                 
    # keep only obs we need (those that can/need be collapsed by year) ----
       
        keep <- c("duration",
                  "min",
                  "hour")                        
    
       
        
    # select key variables  ----
     
        
        
        
        # apparently I get an 'error in select' when i run from mother script
       # bks_sml <- select(bks, duration,
       #                  min,
       #                  hour,
       #                  yearstart,
       #                  monthstart,
       #                  weekstart, 
       #                  dowstart,
       #                  doystart,
       #                  startstationnumber,
       #                  yrmember)
       # 
     
     
     # create byyear: collapse by year ----
    
      byyear <- bks %>%
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
      
      
      
        
      # create bymo: collapse by month averaged across all years ----
      
      bymo <- bks %>%
        group_by(bks$monthstart) %>%
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
      
      
      
      
      # create byyearmo: collapse by year-month ----
      
      byyearmo <- bks %>%
        group_by(monthstart, yearstart) %>%
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
      
      
      
      # create byyearmo: collapse by year-month ----
      
      byyearmo <- bks %>%
        group_by(monthstart, yearstart) %>%
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
      

     
      
     
      # create bydow: collapse by day of the week (1, 2, 3, ) ----
      
      bydow <- bks %>%
        group_by(dowstart) %>%
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
      
      
      
      
      # create bymodow: collapse by day of the week and month ----
      
      bymodow <- bks %>%
        group_by(dowstart, monthstart) %>%
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
      
      
      
      
      # create bydoy: collapse by day of year  ----
      
      bydoy <- bks %>%
        group_by(doystart) %>%
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
      
      
      
      
      
      # create bywoy: collapse by week of year ----
      
      bywoy <- bks %>%
        group_by(weekstart) %>%
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
      
      
      
     
     # variables to create: daily rides, 
      
  
    
     