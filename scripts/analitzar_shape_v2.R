
# install.packages(c("sf", "terra", "tmap", "ggplot2", "dplyr", "readr"))

library(sf)
library(terra)
library(tmap)
library(ggplot2)
library(dplyr)
library(readr)

# llegir un shape

riu <- st_read("data/raw/RIUS/PROVA/prova.shp")
urbanisme <- st_read("data/raw/TERRITORI/URBANISME_Cat_prova.shp")



#    --------------------------------------
#    --------------------------------------
#         OBJECTIU: " MODIFICAR FILES "
#    --------------------------------------
#    --------------------------------------


#    CREAR COLUMNA
#    -------------

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

Alella <- municipis_area %>%
  filter(NOM == 'Alella')


municipis_area <-municipis_area %>%
  mutate(
    condicio_alella = ifelse(Area_Ha < Alella$Area_Ha, 'Petita','Gran')
  )
  
# Puc FILTAR els mes PETITS 
# Després els visualtizo

municipis_petits <- municipis_area %>%
  filter(condicio_alella == 'Petita')

municipis_grans <- municipis_area %>%
  filter(condicio_alella == 'Gran')


ggplot() +
  geom_sf(data = municipis_grans, fill = "lightyellow", color = "black") +
  geom_sf(data = municipis_petits, fill = "red", color ="red")



#    --------------------------------------
#    --------------------------------------
#         OBJECTIU: " ESTADÍSTICA "
#    --------------------------------------
#    --------------------------------------


municipis_grans
municipis_petits


#    RESUM GENERAL
#    mínim / màxim / mitjana / mediana / quartils

summary(municipis_grans$Area_Ha)
summary(municipis_petits$Area_Ha)


#   Estadísitica CONCRETA

mean(municipis_grans$Area_Ha)
mean(municipis_petits$Area_Ha)

median(municipis_grans$Area_Ha)
median(municipis_petits$Area_Ha)

min(municipis_grans$Area_Ha)
max(municipis_grans$Area_Ha)

min(municipis_petits$Area_Ha)
max(municipis_petits$Area_Ha)
