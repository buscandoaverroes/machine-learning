# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: construct.R
# Description: creates dataset where observations are by year
#
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #



                                 #-------------#
                                 # create      # ----
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
      bks <- readRDS(file.path(MotherData, "motherdata.Rda"))
      
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
      
      byhouryr <- bks %>%
        group_by(yearstart, hourstart) %>%
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
        byhouryr$year <- factor(byhouryr$yearstart, ordered = TRUE)
        
        
    
      
      # create dlyrd: one row is average for each day since opening ----
      dlyrd <- bks %>%
        group_by(yearstart, doystart) %>%
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
      
      dlyrd_mbr <- bks %>%
        group_by(yearstart, doystart, member) %>%
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
      # sort on year and day of year
      dlyrd <- arrange(dlyrd, yearstart, doystart)
      dlyrd_mbr <- arrange(dlyrd, yearstart, doystart)
      # create a numer == to _n for day of operation, rearrange
      dlyrd <- arrange(dlyrd, yearstart, doystart) 
      dlyrd_mbr <- arrange(dlyrd, yearstart, doystart)
      
      dlyrd$dayid <- seq_len(nrow(dlyrd))
      dlyrd_mbr$dayid <- seq_len(nrow(dlyrd_mbr)) # every row here should skip
      
      dlyrd <- arrange(dlyrd, dayid, yearstart, doystart)
      dlyrd_mbr <- arrange(dlyrd, dayid, yearstart, doystart)
      
      dlyrd$year <- factor(dlyrd$yearstart, ordered = TRUE)
      dlyrd_mbr$year <- factor(dlyrd$yearstart, ordered = TRUE) 
      
      
      
      
                
      
                                        #-------------#
                                        # export as Rda # ----
                                        #-------------#
      
      # # create object of names 
      # files <- c("bydow",
      #            "bydoy",
      #            "byhour",
      #            "byhouryr",
      #            "bymo",
      #            "bymodow",
      #            "bywoy",
      #            "byyear",
      #            "byyearmo",
      #            "dlyrd",
      #            "dlyrd_mbr")
      # 
      # # set working directory
      # setwd(file.path(kpop))
      # 
      # # create a vector with the length == no of names 
      # lst <- vector("list", # tells R the type of vector (list)
      #               length(files)) # with a length of object files
      # 
      # # use a for loop to iterate over the names 
      # for (i in seq_along(files)) {
      #   print(files[i])
      #   saveRDS(lst[[i]], # where object cycles through list
      #           file.path(kpop, # start in this directory
      #                    paste0(files[i], ".Rda" ))) #concatenate the following strings
      #   #cat("*")
      # }
      # 
      # 
      # 
      # lapply(names(lst), function(i) {
      #   i1 <- lst[[i]]  # store the name of each item in i1
      #   save(i1,
      #           file = paste0(getwd(), '/', i, '.Rda'))
      # })
      # 
      # test1 <- readRDS(file.path(kpop,
      #         "byhour.Rda"))
      
      


      saveRDS(bydow,
              file.path(kpop, "bydow.Rda"))
      saveRDS(bydoy,
              file.path(kpop, "bydoy.Rda"))
      saveRDS(byhour,
              file.path(kpop, "byhour.Rda"))
      saveRDS(byhouryr,
              file.path(kpop, "byhouryr.Rda"))
      saveRDS(bymo,
              file.path(kpop, "bymo.Rda"))
      saveRDS(bymodow,
              file.path(kpop, "bymodow.Rda"))
      saveRDS(bywoy,
              file.path(kpop, "bywoy.Rda"))
      saveRDS(byyear,
              file.path(kpop, "byyear.Rda"))
      saveRDS(byyearmo,
              file.path(kpop, "byyearmo.Rda"))
      saveRDS(dlyrd,
              file.path(kpop, "dlyrd.Rda"))
      saveRDS(dlyrd_mbr,
              file.path(kpop, "dlyrd_mbr.Rda"))
