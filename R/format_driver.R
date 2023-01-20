
format_driver <- function(
    user,
    site_info
    ){

  # format settings to use  during
  # the download
  settings <- data.frame(
    variables = c(
      "2m_temperature",
      "2m_temperature",
      "2m_temperature",
      "2m_dewpoint_temperature",
      "surface_pressure",
      "total_cloud_cover",
      "snowfall",
      "total_precipitation",
      "clear_sky_direct_solar_radiation_at_surface"
    ),
    methods = c(
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
  )

  # download all drivers, use site info
  # to determine locality etc
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

  # combine the drivers
  drivers_agg <- bind_cols(drivers)

  # reformat the drivers / unit conversions etc

}
