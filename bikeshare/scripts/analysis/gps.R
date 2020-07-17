# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: gps.R
# Description: creates a station name-id-gps dictionary 
#
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #





                            #-------------#
                            # load stata  # ----
                            #-------------#

                            
    gps <- readRDS(file.path(kpop, "gps-import.dta"))
                  #assumption is all stations will be in start, no need end
        
    d = data.frame(gps$start_station_name, gps$startstationnumber)
    
    
    
    
    
                            #-------------#
                            # clean+clpse # ----
                            #-------------#
    
  # ensure only 1 unique value of station name string for each station id
      
    c <- gps %>%
      group_by(startstationnumber) %>%
      summarise( count = n_distinct(start_station_name)) %>%
      summarise( max = max(count),
                 min = min(count)) ## result should be 1,1; max is max unique values 
    
    gps.d <- gps %>%
      group_by(startstationnumber, start_station_name) %>%
      summarise(stnid = unique(startstationnumber),
                stnname = unique(start_station_name),
                lat = unique(start_lat),
                lng = unique(start_lng))   # ok idk how to use select() apparently
    
    
    # is this really exhaustive? 
    
    
    
    
    
    
                            #-------------#
                            # map to dtas # ----
                            #-------------#
    
      
    stnyr2 <- readRDS(file.path(kpop, "stnyr.Rda")) %>%
      rename(stnid = startstationnumber)
    
    
    stnyr2 <- select( yearstart, startstationnumber, count, mbr_ratio, med_min)
      
    
    left_join(gps.d, stnyr2, key = "stnid")
                  
    
    
    
    
    
                            #-------------#
                            # add features # ----
                            #-------------#
    
    
    #ie state, county, near metro, etc
    
    
    
    
    
    