library(shiny)
library(leaflet)
library(sf)

canada_ridings <- sf::st_read("FED_CA_2021_EN.shp", crs = st_crs(4326), stringsAsFactors = FALSE)
canada_ridings <- sf::st_transform(canada_ridings, "+proj=longlat +datum=WGS84")

labels <- canada_ridings$ED_NAMEE
centroids <- sf::st_centroid(canada_ridings)

ui <- fluidPage(
  titlePanel("Interactive Canadian Election Map"),
  leafletOutput("map")
)

server <- function(input, output) {
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(
        data = canada_ridings,
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
          bringToFront = TRUE)
      ) %>%
      addMarkers(
        data = centroids,
        label = labels,
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto"
        )
      ) %>%
      addLegend(
        position = "bottomright",
        colors = "darkgray",
        labels = "Riding",
        opacity = 1
      ) %>%
      setView(lng = -95, lat = 60, zoom = 3)
  })
}

shinyApp(ui = ui, server = server)
