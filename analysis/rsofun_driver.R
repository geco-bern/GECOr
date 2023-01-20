# build rsofun driver data using ERA5
# data and various APIs

library(tidyverse)
library(ecmwfr)
library(MODISTools)
source("R/driver_download.R")

# set your user ID
user <- "2088"

variables <- c(
  "2m_temperature",
  "2m_temperature",
  "2m_temperature",
  "2m_dewpoint_temperature",
  "surface_pressure",
  "total_cloud_cover",
  "snowfall",
  "total_precipitation",
  "clear_sky_direct_solar_radiation_at_surface"
)

methods <- c(
  "mean",
  "min",
  "max",
  "mean",
  "mean",
  "mean",
  "sum",
  "sum",
  "max"
)

settings <- data.frame(
  variables = variables,
  methods = methods
)

drivers <- apply(settings, 1, function(x){
  output <- driver_download(
    user = user,
    lon = 20,
    lat = 50,
    var = x["variables"],
    start_date = "2021-01-01",
    end_date = "2021-03-30",
    method = x["methods"]
  )

  return(output)
})

drivers_agg <- bind_cols(drivers)
