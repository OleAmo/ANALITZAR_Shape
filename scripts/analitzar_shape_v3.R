
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

#    VUll crear INTERSECCIÓ
#    RIUS amb COMARQUES

intersection <- st_intersection(rius_cat, comarques)


#    ARA HE D'ANALITZAR la intersecció
#    He de mirar quine columnes tinc i que signigiquen

names(intersection)

#   Ara faig SUMARIZE
#   AGRUPO per COMARQUE
#   Sumo les longituds que intersecten amb cada comarca


intersection %>%
  group_by(NOMCOMAR) %>%
  summarise(
    suma_longitud = sum(longitud),
    mitjana_longitud = mean(longitud)
  )


# Crec que així conto el num de vegades que apareix cada comarca
# En principi això és el numero de rius que intersecten amb cada comarca

# -------------------------
# Ho de comprovar
# -------------------------


intersection %>%
  count(NOMCOMAR)
  





