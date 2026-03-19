
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

# Creeo un DATAFRAME de MUNICIPIS 
# FILTRO = CODIMUNI, NOM i Geometria


round(st_distance(municipis[1,], municipis[2,])/1000,1)


