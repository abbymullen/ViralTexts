library(dplyr)
library(ggmap)
library(ggplot2)

text = read.csv("FullC19-working notes (1).csv"
                , header = FALSE, stringsAsFactors = FALSE,sep = ',') %>% 
  mutate(paper_title = gsub('(.*)\\.*\\(.*','\\1',V4)) %>% #This separates the paper's actual name out
  mutate(location = gsub('.*\\((.*)\\).*','\\1',V4)) %>% #This separates out the location from the name
  mutate(year = gsub('(\\d{4})-(\\d+)-(\\d+)','\\1',V3)) %>% #extracts year
  mutate(date = as.Date(V3)) %>%  #turns date (text) into a date type so you can use it for calculations
  mutate(text = V5) %>% 
  select(date,year,paper_title,text,location)

#this finds all the unique instances and also filters out the MoA problems
text_unique <- text %>% 
  distinct(location) %>% 
  filter(!grepl("[0-9]",location)) %>% 
  select(location)
 

geocode = geocode(c(as.character(text_unique$location))) 

text_unique$lat = geocode$lat
text_unique$lon <- geocode$lon

text_geo = merge(text, text_unique,by="location")

write.table(text_geo, file = 'geocoded_notes.txt'
            , sep = '\t',row.names = FALSE)