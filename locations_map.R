
library(htmlwidgets)
library(leaflet)
library(dplyr)

data = read.table("./UK_Clock_Club-geolocations.csv", header =TRUE, sep = ",") 

data = select(data, Location, Long, Lat, Number_of_subscriptions)
data = rename(data, Value = Number_of_subscriptions)

dotsColor =  colorBin("plasma", domain = 0:70, bins = 7)


loc_map <- leaflet(data) %>% 
  addTiles() %>% 
  setView(-3.475300, 55.89687, zoom = 6) %>%
  addCircles(lng = data$Long,lat = data$Lat, label = data$Location,
             weight =20, color = ~dotsColor(data$Value), radius = data$Value*100, opacity = 0.7) %>%
  addLegend(data= data,"bottomright",pal = dotsColor, values = data$Value,
                       title = "Subscriptions", opacity = 1)  
  
  
  
saveWidget(widget = loc_map, file = "clock-clubbers.html", ) 

