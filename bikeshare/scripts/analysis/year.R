# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: construct.R
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
      setting <- 0
     # if (setting == 1) {    
     #   
     #    sets <- c("monthstart",
     #              "yearstart", 
     #              "dowstart",
     #              "doystart",
     #              "weekstart" )
     #    bks[,sets]     
     #    
     #    
     #    for (i in sets) {
     #      bks[,i]
     #    }
     #    
     #    # the 'stata' loop 
     #    for (i in sets) {
     #    byi <- bks %>%
     #      group_by(i) %>%
     #      summarise( count = n(),
     #                 nstation = n_distinct(startstationnumber),
     #                 mbr_ratio = mean(member, na.rm = TRUE),
     #                 av_dur = mean(duration, na.rm = TRUE),
     #                 av_min = mean(min, na.rm = TRUE), 
     #                 av_hour = mean(hour, na.rm = TRUE),
     #                 med_dur = median(duration, na.rm = TRUE),
     #                 med_min = median(min, na.rm = TRUE), 
     #                 med_hour = median(hour, na.rm = TRUE)
     #      )
     #    }
     #    
     #    output <- data.frame()
     #    
     # 
     # } # end switch   
     
     
    
                                  #-------------#
                                  # import Rda  # ----
                                  #-------------#
      bks <- readRDS(file.path(MasterData, "motherdata.Rda"))
      
      # create byyear: collapse by year ----
    
      byyear <- bks %>%
       group_by(yearstart) %>%
       summarise( count = n(),
                  nstation = n_distinct(startstationnumber),
                  mbr_ratio = mean(member, na.rm = TRUE),
                  av_dur = mean(duration, na.rm = TRUE),
                  av_min = mean(min, na.rm = TRUE), 
                  av_hour = mean(hour, na.rm = TRUE),
                  med_dur = median(duration, na.rm = TRUE),
                  med_min = median(min, na.rm = TRUE), 
                  med_hour = median(hour, na.rm = TRUE)
      )
      
      
      
        
      # create bymo: collapse by month averaged across all years ----
      
      bymo <- bks %>%
        group_by(monthstart) %>%
        summarise( count = n(),
                   nstation = n_distinct(startstationnumber),
                   mbr_ratio = mean(member, na.rm = TRUE),
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
                   mbr_ratio = mean(member, na.rm = TRUE),
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
                   mbr_ratio = mean(member, na.rm = TRUE),
                   av_dur = mean(duration, na.rm = TRUE),
                   av_min = mean(min, na.rm = TRUE), 
                   av_hour = mean(hour, na.rm = TRUE),
                   med_dur = median(duration, na.rm = TRUE),
                   med_min = median(min, na.rm = TRUE), 
                   med_hour = median(hour, na.rm = TRUE),
                   nwoyyear = n_distinct(weekstart, yearstart),
        )
        
      bydow <- mutate(bydow, 
                      dailyrides = count / nwoyyear )
      
      
      # create bymodow: collapse by day of the week and month ----
      
      bymodow <- bks %>%
        group_by(dowstart, monthstart) %>%
        summarise( count = n(),
                   nstation = n_distinct(startstationnumber),
                   mbr_ratio = mean(member, na.rm = TRUE),
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
                   mbr_ratio = mean(member, na.rm = TRUE),
                   av_dur = mean(duration, na.rm = TRUE),
                   av_min = mean(min, na.rm = TRUE), 
                   av_hour = mean(hour, na.rm = TRUE),
                   med_dur = median(duration, na.rm = TRUE),
                   med_min = median(min, na.rm = TRUE), 
                   med_hour = median(hour, na.rm = TRUE),
                   nyear = n_distinct(yearstart, na.rm = TRUE))
        
      bydoy<- mutate(bydoy, 
             dailyrides = count / nyear)
      
      
      
      
      
      # create bywoy: collapse by week of year ----
      
      bywoy <- bks %>%
        group_by(weekstart) %>%
        summarise( count = n(),
                   nstation = n_distinct(startstationnumber),
                   mbr_ratio = mean(member, na.rm = TRUE),
                   av_dur = mean(duration, na.rm = TRUE),
                   av_min = mean(min, na.rm = TRUE), 
                   av_hour = mean(hour, na.rm = TRUE),
                   med_dur = median(duration, na.rm = TRUE),
                   med_min = median(min, na.rm = TRUE), 
                   med_hour = median(hour, na.rm = TRUE),
                   nyear = n_distinct(yearstart, na.rm = TRUE)
        )
      
    bywoy <-  mutate(bywoy, 
             weeklyrides = count / nyear,
             dailyrides  = (count / (nyear * 7)) )
      
      byhour <- bks %>%
        group_by(hourstart) %>%
        summarise( count = n(),
                   nstation = n_distinct(startstationnumber),
                   mbr_ratio = mean(member, na.rm = TRUE),
                   av_dur = mean(duration, na.rm = TRUE),
                   av_min = mean(min, na.rm = TRUE), 
                   av_hour = mean(hour, na.rm = TRUE),
                   med_dur = median(duration, na.rm = TRUE),
                   med_min = median(min, na.rm = TRUE), 
                   med_hour = median(hour, na.rm = TRUE)
        )
    
      
      # create dlyrd: one row is average for each day since opening ----
      dlyrd <- bks %>%
        group_by(hourstart) %>%
        summarise( count = n(),
                   nstation = n_distinct(startstationnumber),
                   mbr_ratio = mean(member, na.rm = TRUE),
                   av_dur = mean(duration, na.rm = TRUE),
                   av_min = mean(min, na.rm = TRUE), 
                   av_hour = mean(hour, na.rm = TRUE),
                   med_dur = median(duration, na.rm = TRUE),
                   med_min = median(min, na.rm = TRUE), 
                   med_hour = median(hour, na.rm = TRUE)
        )
       