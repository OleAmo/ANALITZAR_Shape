
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


# EXERCICI 1:

# Vull saber de cada MUNICIPI
# Quins sons els 5 MUNICIPIS MÉS APROP
# La distància la calculo des de els centroides



municipis <- urbanisme %>% select(CODIMUNI, NOM)



# MODIFICAR UNA SOLA FILA
# Es fa així
# He de implementar un for i recorreho tot

municipis_dist <- municipis[4,1] %>%         # Aqui creo columna DIST_BCN_M
        mutate(                         # Aquesta columna és la DIST de BCN al MUNICIPI 22
          Dist_BCN_m =
            round(
              st_distance(st_centroid(geometry[1]),st_centroid(bcn))
              ,1),
          Dist_BCN_Km =
            round(Dist_BCN_m/1000,2)
    
  ) 

 