# Load packages
library(leaflet)
library(tigris)
library(sf)
library(dplyr)

options(tigris_class = "sf")

# Get county shapes for Alabama
alabama_counties <- counties(state = "AL", year = 2020)

# Filter counties around Auburn
selected_counties <- alabama_counties %>%
  filter(NAME %in% c("Lee", "Chambers", "Macon", "Russell"))

# Get roads and water features
lee_roads <- roads(state = "AL", county = "Lee", year = 2020)
lee_water <- area_water(state = "AL", county = "Lee", year = 2020)

# Define Camphill Facility point
camphill <- data.frame(
  name = "Camphill Facility",
  lat = 32.81883,
  lng = -85.63932
)

# Create map
leaflet() %>%
  addProviderTiles(providers$CartoDB.Positron) %>%  # Topographic base #providers$Esri.WorldTopoMap/WorldImagery/CartoDB.Positron/Stadia.StamenToner/StamenTerrain
  addPolygons(data = selected_counties,
              color = "blue", weight = 2,
              fillColor = "lightblue", fillOpacity = 0.3,
              label = ~NAME) %>%
  addPolylines(data = lee_roads,
               color = "darkgray", weight = 1, opacity = 0.8,
               group = "Roads") %>%
  addMarkers(data = camphill,
             lng = ~lng, lat = ~lat,
             popup = ~name,
             label = ~name,
             icon = makeIcon(
               iconUrl = "https://cdn.jsdelivr.net/npm/leaflet@1.7.1/dist/images/marker-icon.png",
               iconWidth = 25, iconHeight = 41,
               iconAnchorX = 12, iconAnchorY = 41
             )) %>%
  addPolygons(data = lee_water,
              fillColor = "lightblue", color = "blue", weight = 1,
              fillOpacity = 0.6,
              group = "Water") %>%
  setView(lng = -85.5, lat = 32.6, zoom = 10) %>%
  addLayersControl(overlayGroups = c("Roads", "Water"),
                   options = layersControlOptions(collapsed = FALSE))

