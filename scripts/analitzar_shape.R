
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


# OPERACIONS BÀSIQUES

#   -) SELCCIÓ COLUMNES
#   -) FILTRAR
#   -) AFEGIR COLUMNES

# EXERCICI 1:

# Creeo un DATAFRAME de MUNICIPIS 
# FILTRO = CODIMUNI, NOM i Geometria


municipis <- urbanisme %>% select(CODIMUNI, NOM)

bcn <- municipis %>%
  filter(NOM == "Barcelona")

plot(bcn)

# EXERCICI 2:

# Creeo dues columens NOVES al DATAFRAME de MUNICIPIS 
# Serà la distància a BCN en metres i Km
# Dist_BCN_m i Dist_BCN_Km

bcn <- municipis %>%
  filter(NOM == "Barcelona")


municipis %>%         # Aqui creo columna DIST_BCN_M
  mutate(             # Aquesta columna és la DIST de BCN al MUNICIPI 22
    Dist_BCN_m =
      round(st_distance(geometry, bcn),1),
    Dist_BCN_Km =
      round(Dist_BCN_m/1000,2)
    
  ) 

