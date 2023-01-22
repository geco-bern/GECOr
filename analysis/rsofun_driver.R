# build rsofun driver data using ERA5
# data and various APIs

library(tidyverse)
library(ecmwfr)
library(rsofun)
library(MODISTools)
source("R/gc_era5_request.R")
source("R/gc_rsofun_driver_era5.R")

# set your ECMWF user ID
user <- "2088"

# grab existing site info
site_info <- rsofun::biomee_p_model_drivers$site_info[[1]]
site_info$date_start <- "2013-01-01"
site_info$date_end <- "2013-12-31"

# download formatted data
test <- gc_rsofun_driver_era5(
  user = user,
  site_info = site_info
  )
