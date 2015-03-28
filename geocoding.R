library(dplyr)
library(ggmap)
library(ggplot2)

text = read.csv("Attribution Study/BeautifulSnow.tsv"
                   , sep = '\t', quote = "", header = TRUE, stringsAsFactors = FALSE)  %>%  
  #mutate(paper_title = gsub('(.*)\\.*\\(.*','\\1',paper)) %>%
  #mutate(location = gsub('.*\\((.*)\\).*','\\1',paper)) %>%
  mutate(date = gsub('(\\d+)/(\\d+)/(\\d{4})','\\3-\\1-\\2',date)) %>%
  mutate(year = gsub('(\\d{4})-(\\d+)-(\\d+)','\\1',date)) %>%
  select(publication,location,year,date,author) %>%
  mutate(date = as.Date(date)) %>%
  mutate(end_date = date + 730)

geocode = geocode(c(as.character(text$location))) 

text$lat <- geocode$lat
text$lon <- geocode$lon

text_geo <- text %>%
  select(year,date,end_date,publication,author,location,lat,lon)

write.table(text_geo, file = 'BeautifulSnow_geocode.txt', sep = '\t')
