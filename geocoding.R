library(dplyr)
library(ggmap)
library(ggplot2)

text = read.csv("Attribution_Study/BeautifulSnow/BeautifulSnow_count.tsv"
                   , header = TRUE, stringsAsFactors = FALSE,sep = '\t') %>%
  filter(location != "unknown") %>%
  #mutate(paper_title = gsub('(.*)\\.*\\(.*','\\1',paper)) %>% #This separates the paper's actual name out
  #mutate(location = gsub('.*\\((.*)\\).*','\\1',paper)) %>% #This separates out the location from the name
  mutate(date = gsub('(\\d+)/(\\d+)/(\\d{4})','\\3-\\1-\\2',date)) %>% #puts date in ISO format
  mutate(year = gsub('(\\d{4})-(\\d+)-(\\d+)','\\1',date)) %>% #extracts year
  select(publication,location,year,date,author) %>% #selects columns that you want to see
  mutate(date = as.Date(date)) %>% #turns date (text) into a date type so you can use it for calculations
  mutate(end_date = date + 730) #this is to add two years for the time lapse--comment out if not needed

geocode = geocode(c(as.character(text$location))) 

text$lat <- geocode$lat #this is a simple way to combine the dataframes like you want them
text$lon <- geocode$lon


write.table(text, file = 'Attribution_Study//BeautifulSnow//BeautifulSnow_geocode.txt'
            , sep = '\t',row.names = FALSE)
