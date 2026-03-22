
# install.packages(c("sf", "terra", "tmap", "ggplot2", "dplyr", "readr"))

library(sf)
library(terra)
library(tmap)
library(ggplot2)
library(dplyr)
library(readr)

# llegir un shape

riu <- st_read("data/raw/xxxxxx.shp")
comarques <- st_read("data/raw/xxxxxxx.shp")



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

municipis <- urbanisme %>% select(CODIMUNI, NOM)


municipis_area <- municipis %>%   # Aqui creo columna Area_Ha
  mutate(                         
    Area_m2 =round(st_area(geometry),2),
    Area_Ha =round((st_area(geometry)/10000),2)
  )



#    CONDICIONAL
#    -------------

#    Crear columnes amb CONDICIONAL
#    Usaré el ELSEIF
#    NECESSITA MUTATE si uso el %>%

#    Crear COLUMNA CONDICIO_ALELLA
#    Si és més gran = GRAN
#    Si és més petita = PETITA

A