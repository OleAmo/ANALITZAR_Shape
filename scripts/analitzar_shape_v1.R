
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
# La distància la calculo des de els centroides

bcn <- municipis %>%
  filter(NOM == "Barcelona")

alella <- municipis %>%
  filter(NOM == "Alella")

martorelles <- municipis %>%
  filter(NOM == "Martorelles")

municipis_dist <- municipis %>%         # Aqui creo columna DIST_BCN_M
        mutate(                         # Aquesta columna és la DIST de BCN al MUNICIPI 22
          Dist_BCN_m =
            round(
              st_distance(st_centroid(geometry),st_centroid(bcn))
              ,1),
          Dist_BCN_Km =
            round(Dist_BCN_m/1000,2)
    
  ) 

# ----------------------------------------------
# ----------- REPRESENTACIÓ GRÀFICA ------------
# ----------------------------------------------

centroides <- st_centroid(municipis_dist)


ggplot() +
  geom_sf(data = alella, fill = "lightyellow", color = "black") +
  geom_sf(data = martorelles, fill = "lightblue", color = "blue") +
  geom_sf(data = bcn, fill = "red", color = "darkred")

ggplot() +
  geom_sf(data = municipis, fill = "lightyellow", color = "black") +
  geom_sf(data = centroides, fill = "red", color ="red")


# Ara poso etiquetes

etiquetes_ale <- st_point_on_surface(alella)
etiquetes_mart <- st_point_on_surface(martorelles)

ggplot() +
  geom_sf(data = alella, fill = "lightyellow", color = "black") +
  geom_sf(data = martorelles, fill = "red", color ="red")+
  geom_sf_text(data = etiquetes_ale, aes(label = NOM), size = 3) +
  geom_sf_text(data = etiquetes_mart, aes(label = NOM), size = 3)



# --- EXPORTAR A SHAPE
# --------------------

# Es pot fer de dos formes

#   -) SHAPE:
#         -) PROBLEMA = noms de camps ≤ 10 caràcters
#         -) sense accents ni espais

#   -) GEOPACKAGE
#         -) Un sol fitxer
#         -) Sense límit de noms
#         -) Més robust
#         -) QGIS el llegeix perfecte

#   Per SOBREESCRIURE
#   Es fa amb DELETE_LAYER = TRUE

st_write(municipis_dist, "data/processed/URBANISME_Cat_prova_processed.shp")
st_write(municipis_dist, "data/processed/URBANISME_Cat_prova_processed.shp", delete_layer = TRUE)

st_write(municipis_dist, "data/processed/URBANISME_Cat_prova_processed.gpkg")
st_write(municipis_dist, "data/processed/URBANISME_Cat_prova_processed.gpkg", delete_layer = TRUE)

