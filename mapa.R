# Cartografía html con librería leaflet. 

# Librerías 

library(dplyr)
library(leaflet) # debe de instalar el paquete leaflet
library(leaflet.extras2) # debe instalar el paquete leaflet.extras2
library(lubridate)
library(sf)

# ------------------------------------------
#importar dataset ap_prov_nqn, regiones, efectores

ap_prov_nqn <- st_read("ap_hosp_prov.gpkg")
regiones <- st_read("regiones.gpkg")
establecimientos <-  st_read("establecimientos.geojson")

ap_prov_nqn <- st_transform(ap_prov_nqn, crs = 4326)
regiones <- st_transform(regiones, crs = 4326)
establecimientos <- st_transform(establecimientos, crs = 4326)


#personalizando el mapa 

pal <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

icons <-  makeIcon(
  iconUrl = "https://www.svgrepo.com/show/83331/placeholder.svg",
  iconWidth = 50*215/230,
  iconHeight = 12, 
  iconAnchorY = 13,
  iconAnchorX = 50*215/230/2)

# Crear mapa html con leaflet

leaflet() %>%
  addTiles() %>% 
  addPolygons(data=regiones,
              fillColor = palette(pal), 
              fillOpacity = 0.4,
              weight = 0.5) %>%
  
  addPolygons(data= ap_prov_nqn,
              weight = 0.5,
              color = "black",
              fillColor =   "white",
              label = paste("AREA PROGRAMA: ",ap_prov_nqn$`ap.hosp`)) %>% 
  
  addMarkers(data = establecimientos, icon = icons,
             label = paste("Efector: ", establecimientos$ident,
                           group = "establecimientos"))