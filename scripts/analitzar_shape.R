
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


# Creo Vectors DSITÀNCIA M
# Creo Vector DISTÀNCIA KM

dist_m <- c()
dist_km <- c()
for (i in 1:length(municipis$NOM)){
  d_km <- round(st_distance(bcn, municipis[i,])/1000,2)
  d_m <- round(st_distance(bcn, municipis[i,]),1)
  
  dist_m <- c(dist_m,d_m)
  dist_km <- c(dist_km, d_km)
}

dist_m
dist_km 


# Un cop creat dels de de ADJUNTAR D'ALGUNA FORMA a MUNICIPIS
# Com a COLUMNA M i COLUMNA KM



municipis %>%         # Aqui creo columna DIST_BCN_M
  mutate(             # Aquesta columna és la DIST de BCN al MUNICIPI 22
    Dist_BCN_m =
      round(st_distance(bcn, municipis[22,])/1000)
      
      )  

# No se com AUTOMATIZAR el omplir columenes fent lso de ST_DISTANCE



