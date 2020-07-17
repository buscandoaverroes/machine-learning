# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: gps.R
# Description: creates a station name-id-gps dictionary 
#
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #



  library(sp)

                            #-------------#
                            # load stata  # ----
                            #-------------#

                            
      bks <- readRDS(file.path(MotherData, "motherdata.Rda"))
              # load full dataset        
    
    
    
    
                            #-------------#
                            # clean+clpse # ----
                            #-------------#
    
  # obtain a full list of station name/id numbers 
   
    # ensure only 1 unique value of station name string for each station id
    ck <- bks %>%
      group_by(startstationnumber) %>%
      summarise( count = n_distinct(startstation)) #%>%
    # problem here is that there are some ids with multiple unique string values, must 
    # merge because the ids change from 5 digits to 3 when the have gps coordinates 
    # therefore, must do string match
    
    #create a dictionary of all unique stationnames
    oldnames <- bks %>%
            group_by(startstation) %>%
            summarise()
    
    # make a dictionary of all string names with gps coordinate 
    
      # load the raw datasets 
    a2020 <- data.table::fread(file.path(raw, "2020/202004-capitalbikeshare-tripdata.csv"),
                               header = TRUE,
                               na.strings = ".",  # tell characters to be read as missing
                               stringsAsFactors = TRUE,
                               showProgress = TRUE, 
                               data.table = FALSE
                              ) # return data frame, not table   
    m2020 <- data.table::fread(file.path(raw, "2020/202005-capitalbikeshare-tripdata.csv"),
                               header = TRUE,
                               na.strings = ".",  # tell characters to be read as missing
                               stringsAsFactors = TRUE,
                               showProgress = TRUE, 
                               data.table = FALSE,
                               drop = "is_equity") # return data frame, not table  
    
    j2020 <- data.table::fread(file.path(raw, "2020/202006-capitalbikeshare-tripdata.csv"),
                               header = TRUE,
                               na.strings = ".",  # tell characters to be read as missing
                               stringsAsFactors = TRUE,
                               showProgress = TRUE, 
                               data.table = FALSE
                              ) # return data frame, not table  
      # rbind them 
    new2020 <- rbind(a2020, m2020, j2020)
    
      # create list of distinct names and coordinates
     newnames <- new2020 %>%
      group_by(start_station_name, start_lat, start_lng) %>%
      summarise()
    
      # then calculate the distance btween similar points %%
      mutate(newnames, 
             dist = spDists(c(newnames$start_lng, newnames$start_lat), longlat)) 
    
      spDists(c(newnames$start_lng, newnames$start_lat), longlat = TRUE)
     
    library(geosphere)
      
      list1 <- data.frame(lng = newnames$start_lng, lat = newnames$start_lat)
      
      mat <- distm(list1)
        
    gps <- bks %>%
      group_by(startstationnumber, start_station_name) %>%
      summarise(stnid = unique(startstationnumber),
                stnname = unique(start_station_name),
                lat = unique(start_lat),
                lng = unique(start_lng))   # ah but this isn't in bks, only in months
    
    
    # now pull a full list of those with gps coordinates 
    
    
    
    
    
    
                            #-------------#
                            # map to dtas # ----
                            #-------------#
    library(nycflights13)
    
    jan1 <- filter(flights, month == 1 , day == 1)
    
    arrange(flights, year, month, day)
    
    select(flights, year, month, day)
    
    
    
    
    select(gpsd, stnid)  # if select doesn't work then reinstall/reload
    
    
    
    stnyr2 <- readRDS(file.path(kpop, "stnyr.Rda")) %>%
      rename(stnid = startstationnumber) %>%
      select(yearstart, stnid, count, mbr_ratio, med_min)
      
    
    left_join(gpsd, stnyr2, key = "stnid")
                  
    
    
    
    
    
                            #-------------#
                            # add features # ----
                            #-------------#
    
    
    #ie state, county, near metro, etc
    
    
    
    
    
    