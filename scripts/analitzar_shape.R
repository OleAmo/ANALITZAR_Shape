# install.packages("sf")
# install.packages("dplyr")
# install.packages("readr")

library(sf)
library(dplyr)

# llegir un shape

riu <- st_read("data/raw/RIUS/PROVA/prova.shp")
