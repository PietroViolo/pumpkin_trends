#---------------------------------------------------------------------------#
# Nom : pumpkin_trends.R                              					            #
# Description : Follows pumpkin imports in the U.S.                         #
# Auteur : Pietro Violo                                                     #
# Date : Oct 21 2022                                                        #
# Modifications :                                                           #
#---------------------------------------------------------------------------#

#---------------------------------------------------------------------------#
# Library                                                                   #
#---------------------------------------------------------------------------#
library(tidyverse)

#---------------------------------------------------------------------------#
# Data cleaning                                                             #
#---------------------------------------------------------------------------#

pumpkins_volume <- read.csv("./Data/pk_volume.csv", sep = ",")

months <- c("Jan", "Feb", "Mar", "Apr",
            "May", "Jun", "Jul", "Aug",
            "Sep", "Oct", "Nov", "Dec")

pumpkins_volume <- pumpkins_volume %>% 
  pivot_longer(Jan:Total, names_to = "Month", values_to = "Imports")

pumpkins_volume <- pumpkins_volume %>% filter(Month %in% months) %>% 
  mutate(Month = factor(Month, levels = months))

#---------------------------------------------------------------------------#
# Visualization                                                             #
#---------------------------------------------------------------------------#

