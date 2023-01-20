#' Download drivers from ECMWF
#'
#' Batch downloads ERA5 driver data from the ECMWF API (CDS Toolbox)
#'
#' @param user ECMWF Copernicus CDS user
#' @param lat latitude
#' @param lon longitude
#' @param var CDS variable of interest
#' @param start_date start date as YYYY-MM-DD
#' @param end_date end date as YYYY-MM-DD
#' @param method aggregation method (mean, max, min, sum)
#'
#' @return A data frame with queried data including the date, position and
#' requested variable
#' @export

driver_download <- function(
    user,
    lat,
    lon,
    var,
    start_date,
    end_date,
    method = 'mean'
) {

  code <- readLines("analysis/python_call.py") |>
    paste(collapse = "\n")

  # A query for 2m surface temperature
  request <- list(
    code = code,
    kwargs = list(
      lon = lon,
      lat = lat,
      var = "2m_temperature",
      date = paste(start_date, end_date, sep = "/"),
      method = method
    ),
    workflow_name = "daily_data",
    target = "data.csv"
  )

  # download the data
  file <- wf_request(
    user = user,
    request,
    transfer = TRUE
  )

  if(!inherits(file, "try-error")) {
    df <- read.table(file, sep = ",", header = TRUE)
    df <- df[,c(1,5)]
    return(df)
  } else {
    message("failed download")
  }
}
