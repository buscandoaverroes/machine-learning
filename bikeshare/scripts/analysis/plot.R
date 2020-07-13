# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
# Name: plot.R
# Description: creates some plots
#
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
  

                                    
                                    #-------------#
                                    # plot set 1  # ----
                                    #-------------#



ggplot(data = byhour) + 
  geom_point(mapping = aes(x = hourstart, y = count, color = mbr_ratio))
                                    
                                    
ggplot(data = byhour) + 
  geom_point(mapping = aes(x = hourstart, y = count), color = "blue")
