# build rsofun driver data using ERA5
# data and various APIs

library(tidyverse)
library(ecmwfr)
library(MODISTools)
source("R/driver_download.R")

# set your user ID
user <- "2088"

# download formatted data
format_driver(user, site_info)
