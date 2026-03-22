
# install.packages(c("sf", "terra", "tmap", "ggplot2", "dplyr", "readr"))

library(sf)
library(terra)
library(tmap)
library(ggplot2)
library(dplyr)
library(readr)

# llegir un shape

rius_cat <- st_read("data/raw/RIUS/PROVA/catalunya_prova.shp")
comarques <- st_read("data/raw/TERRITORI/comarques_prova.shp")



#    --------------------------------------
#    --------------------------------------
#         OBJECTIU: " MODIFICAR FILES "
#    --------------------------------------
#    --------------------------------------


#    FER INTERSECT 
#    FER SUMARIZE amb lo INTERSECTAT
#    -------------------------------

#    VUll crear ÀREA POLÍGON
#    Faig DUES COLUMNES - Area_m2 i Area_Ha

intersection <- st_intersection(rius_cat, comarques)


#    ARA HE D'ANALITZAR la intersecció
#    He de mirar quine columnes tinc i que signigiquen

names(intersection)

#   Aquestes son les columnes




