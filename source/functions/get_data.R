
# define function for New york times data
get_times <- function(end_date){

  # create values
  url <- c("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

  # download data
  response <- RCurl::getURL(url = url)

  # read data
  df <- readr::read_csv(response)

  # tidy data
  df <- dplyr::filter(df, state %in% c("Arkansas", "Kansas", "Missouri", "Illinois", "Oklahoma"))
  df <- dplyr::rename(df,
                      confirmed = cases,
                      report_date = date,
                      geoid = fips)
  df <- dplyr::mutate(df, geoid = ifelse(county == "Kansas City", "29511", geoid))
  df <- dplyr::mutate(df, geoid = ifelse(county == "Joplin", "29512", geoid))
  df <- dplyr::select(df, geoid, report_date, confirmed, deaths)

  if (is.null(end_date) == FALSE){

    df <- dplyr::filter(df, report_date <= as.Date(end_date))

  }

  # return output
  return(df)

}
