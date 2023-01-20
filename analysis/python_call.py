import cdstoolbox as ct

@ct.application()
@ct.output.download()
def daily_data(lon, lat, var, date, method):
  
    data = ct.catalogue.retrieve(
        'reanalysis-era5-single-levels',
        {
          'variable': var,
          'area': [lat + 0.25, lon - 0.25, lat - 0.25, lon + 0.25],
          'product_type': 'reanalysis',
          'date' : date,
          'time': [
                '00:00', '01:00', '02:00',
                '03:00', '04:00', '05:00',
                '06:00', '07:00', '08:00',
                '09:00', '10:00', '11:00',
                '12:00', '13:00', '14:00',
                '15:00', '16:00', '17:00',
                '18:00', '19:00', '20:00',
                '21:00', '22:00', '23:00',
            ]
        }
      )
      
    if var == "snowfall" or var == "total_precipitation" :
      # Convert snowfall from flux (m/s) to hourly accumulated column of water/snow (mm)
      data = data * 3600 * 1000
    
    data_resampled = ct.cube.resample(data, freq='day', dim='time', how=method)
    data_sel = ct.geo.extract_point(data_resampled, lon=lon, lat=lat)

    return ct.cdm.to_csv(data_sel)
