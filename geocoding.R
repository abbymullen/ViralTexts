library(dplyr)
library(ggmap)
library(ggplot2)

webster = read.csv("~/Downloads/Webster-Longstreet (cluster 13) - Sheet1.tsv"
                   , sep = '\t', quote = "", header = TRUE, stringsAsFactors = FALSE)  %>% 

geocode = geocode(c(webster$Location))

webster$lat <- geocode$lat
webster$lon <- geocode$lon
webster %>%
  mutate(date_formatted, gsub('(\\d+)/(\\d+)/(\\d{4})',(\\3)-(\\1)-(\\2),webster$Date)


write.table(webster, file = 'webster_longstreet_geocode.txt', sep = '\t')
