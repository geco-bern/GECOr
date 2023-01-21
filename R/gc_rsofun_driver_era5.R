#' Format an ERA5 based {rsofun} driver
#'
#' Uses the ECMWF CDS workflow API to summarize rsofun driver files
#' on a daily time step.
#'
#' @param user a ECMWF CDS user name (number)
#' @param site_info site info data frame including a site name, location, and
#'  other ancillary variables
#'
#' @return ERA5 based {rsofun} drivers for a point location specified in the
#'  site_info parameter
#' @export

gc_rsofun_driver_era5 <- function(
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
      'surface_solar_radiation_downwards'
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
      "mean"
    ),
    product = c(
      'reanalysis-era5-land',
      'reanalysis-era5-land',
      'reanalysis-era5-land',
      'reanalysis-era5-land',
      'reanalysis-era5-land',
      'reanalysis-era5-single-levels',
      'reanalysis-era5-land',
      'reanalysis-era5-land',
      'reanalysis-era5-land'
    )
  )

  # download all drivers, use site info
  # to determine locality etc
  drivers <- apply(settings, 1, function(x){
    output <- gc_dl_era5(
      user = user,
      lon = 20,
      lat = 50,
      product = x['product'],
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

  # lapse rate corrections?

  # check units solar radiation
}
