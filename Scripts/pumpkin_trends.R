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

years <- c("2018", "2019", "2020", "2021")

pumpkins_volume <- pumpkins_volume %>% 
  pivot_longer(Jan:Total, names_to = "Month", values_to = "Imports")

pumpkins_volume <- pumpkins_volume %>% filter(Month %in% months) %>% 
  mutate(Month = factor(Month, levels = months),
         Market.year. = factor(Market.year., levels = years))

pumpkins_volume <- pumpkins_volume %>% 
  filter(!is.na(Market.year.),
         !is.na(Imports))

halloween_colors <- c("#221e22",
                      "#eca72c",
                      "#ee5622",
                      "#941b0c")

#---------------------------------------------------------------------------#
# Visualization                                                             #
#---------------------------------------------------------------------------#


# Get the name and the y position of each label
label_data <- pumpkins_volume
number_of_bar <- nrow(label_data)
angle <- 90 - 360 * (label_data$Imports-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
label_data$hjust <- ifelse( angle < -90, 1, 0)
label_data$angle <- ifelse(angle < -90, angle+180, angle)


png("./Graphs/pumpkingraph.png",
    width = 3000,
    height = 3000,
    res = 500)
pumpkins_volume %>% ggplot(aes(x = Month, 
                               y = Imports, 
                               group = Market.year.,
                               fill = Market.year.)) +
                             geom_bar(stat = "identity",
                                      position = "dodge") +
  coord_polar(start = 0) +
  theme_minimal()+
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm")) +
  scale_fill_manual(values = halloween_colors) +
  ylim(-20000, 43365.7)
dev.off()

   
monthmeans <- pumpkins_volume %>% filter(!(Month %in% c("Sep", "Oct"))) %>% group_by(Month) %>% summarise(mean = mean(Imports))

mean(monthmeans$mean)


31893/3589.727 * 100

31385/3589.727 * 100




