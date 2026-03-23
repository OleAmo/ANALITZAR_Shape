
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


#   ---- SUMARIZE ----
#   ------------------

#   AGRUPO per COMARQUES
#   CALCULO 
#      .-) la MITJA de LONGITUDS
#      .-) la SUMA de LONGITUDS x COMARCA
#      .-) El NÚMERO de FILES x selecció =  n()

#      .-) Ho transformo a DATAFRAME
#      .-) Li TREC GEOMETRIA 

intersection_COMARAQUES <- intersection %>%
  group_by(NOMCOMAR) %>%
  summarise(
    suma_longitud = sum(longitud),      # SUMA
    mitjana_longitud = mean(longitud),  # MITJA
    numero = n()                        # NÚMERO de FILES x = COUNT() de SQL
  ) %>% data.frame()%>%
  select(-geometry)                     # Li TREC GEOMETRY


#   AGRUPO per RIUS
#   CALCULO 
#      .-) la MITJA de LONGITUDS
#      .-) la SUMA de LONGITUDS x COMARCA

#      .-) Ho transformo a DATAFRAME
#      .-) Li TREC GEOMETRIA

intersection_RIUS <- intersection %>%
  group_by(nom_final) %>%
  summarise(
    numero = n()
  ) %>% data.frame()%>%
  select(-geometry)

intersection_COMARAQUES
intersection_RIUS


  



