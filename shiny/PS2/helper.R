
winner <- function(var) {
  
  ggplot(var, aes(x = province, y=var$Votes.Obtained.Votes.Obtenus)) +
    labs(x = "province", y = "Votes obtained") +
    geom_bar() +
    theme(aspect.ratio = 1)

  
  var <- sf::read_sf("FED_CA_2021_EN.shp", crs = st_crs(4326)) %>%
    sf::st_transform('+proj=longlat +datum=WGS84')
  
  canada_ridings_2021_map <- leaflet(canada_ridings_2021) %>%
    setView(-80, 35.8, 2.1) %>%
    addProviderTiles("MapBox", options = providerTileOptions(
      id = "mapbox.light",
      accessToken = Sys.getenv('MAPBOX_ACCESS_TOKEN')))
  
  labels <- sprintf("<strong>%s</strong><br/>", canada_ridings_2021$ED_NAMEE) %>% 
    lapply(htmltools::HTML)
  
  canada_ridings_2021_map %>% addPolygons(
    data = canada_ridings_2021,
    weight = 1.25,
    opacity = 1,
    color = "darkgray",
    dashArray = "5",
    fillOpacity = 0.25,
    highlightOptions = highlightOptions(
      weight = 1.5,
      color = "red",
      dashArray = "1",
      fillOpacity = 1,
      bringToFront = TRUE),
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto"))
  
}