library(dplyr)
library(ggmap)
library(ggplot2)

text = read.csv("ThereIsNoDeath.tsv"
                   , sep = '\t', quote = "", header = TRUE, stringsAsFactors = FALSE)

geocode = geocode(c(text$location))

text$lat <- geocode$lat
text$lon <- geocode$lon
text$date_formatted <- gsub('(\\d+)/(\\d+)/(\\d{4})','\\3-\\1-\\2',text$date)

text_geo <- text %>%
  select(paper,location,paratext,lat,lon,date_formatted)

write.table(text_geo, file = 'dickinson_children_250,121.txt', sep = '\t')
