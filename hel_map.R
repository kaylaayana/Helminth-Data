
library(leaflet)
library(leafletCN) 
library(tidyverse)
library(raster)
library(sf)

data_github <- "https://raw.githubusercontent.com/kaylaayana/Helminth-Data/main/Facility%20Lat%3ALong.csv"


datadb <- read_csv(data_github)

r <- raster(ext = extent(-127, -66, 23, 53), res=c(0.5,0.5))
p <- rasterToPolygons(r) 
p <- st_as_sf(p)
lat1 <- 37
long1 <- -119

leaflet(options = leafletOptions(minZoom = 4, maxZoom = 16)) |>
  addPolygons(data = p, color = "#D8D8D8",opacity = 0.25,highlight = highlightOptions(weight = 7, color = "brown", bringToFront = TRUE))|>
  addProviderTiles("OpenStreetMap", options = providerTileOptions(noWrap = TRUE)) |>
  #addMarkers(data = datadb,
             #lng= ~long,
             #lat= ~lat,
             #popup= ~name) |>
             #popup= ~paste(~name,"<a href=\"",link,"\">",link, "</a>")) |>  #~name) |> #
  addCircleMarkers(data = datadb,
                   lng = ~long,
                   lat = ~lat,
                   #popup = ~paste(label,"<a href=\"",link,"\">",link, "</a>"),
                   #label = ~ as.character(mag),
                   radius = 7,
                   stroke = FALSE, fillOpacity = 0.75) |>#,
                   #color = ~ ifelse(test == "Mandatory", "red","blue")) |>
  setView(long1, lat1, zoom = 5)

