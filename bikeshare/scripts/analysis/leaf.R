# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: leaf.R
# Description: explores leaflet
#
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #

       library(leaflet)                     
                            
                            #-------------#
                            # plot set 1  # ----
                            #-------------#
                            
                            
      m <- leaflet() %>%
        addTiles() %>%
        addMarkers(lng=174.786, lat=-36.852, popup = "I could go here")
      m
      