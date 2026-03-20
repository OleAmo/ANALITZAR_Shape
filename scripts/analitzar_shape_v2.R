
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
# APRENDRE A MODIFICAR UNA SOLA FILA

# Per cada FILA calculare l'àrea del POLIGON
# Calculo l'Àrea de cada polígon

municipis <- urbanisme %>% select(CODIMUNI, NOM)

municipis_area <- municipis %>%   # Aqui creo columna Area_Ha
  mutate(                         
    Area_Ha =round((st_area(geometry)/10000),2)
  )

# Després faré un FOR
# Si és més gran que 1/4 de l'area de BCN = diré = MÉS GRAN sino MÉS PETITA

Alella <- municipis %>%
  filter(NOM == 'Alella')

Alella_area <- round(st_area(Alella)/10000,2)

municipis_area[33,]

for (i in 1:length(municipis$geometry)){
  area <- municipis_area$Area_Ha[i]
  
  if (area < Alella_area){
    municipis_area[i,] <- municipis_area[i,] %>%   # Aqui creo columna COMPARACIÓ
      mutate(                         
        comparació = 'mes petita'
      )
  } else {
    
    municipis_area[i,] <- municipis_area[i,] %>%   # Aqui creo columna COMPARACIÓ
      mutate(                         
        comparació = 'mes gran'
      )
    
  }
 
}



# --------- ERROOOOOOOOOOOOR ----
# -------------------------------

# SHA DE FER:

municipis_area <- municipis_area %>%
  mutate(
    comparació = ifelse(Area_Ha < Alella_area, "mes petita", "mes gran")
  )

# --------------------------


View(municipis_area)



 