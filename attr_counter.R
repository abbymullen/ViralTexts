library(dplyr)
library(ggmap)

attributions = read.csv('Attribution_Study//NashU_attr_2015-03-29.txt', sep = '\t'
                      ,  header = FALSE) %>%
  mutate(paper = V4) %>%
  filter(paper != "") %>%
  select(paper)
 # mutate(target = "wheeling")

count_attr = attributions %>%
  filter(grepl('(\\w+\\s)+(\\w+)',paper)) %>%
  filter(!grepl('FALSE',paper)) %>%
  group_by(paper) %>% 
  summarize(count = n()) %>%
  arrange(-count)

paper_names = attributions %>%
  select(paper)
write.csv(count_attr,"NashU_paper_count.txt", row.names = FALSE)

locations = read.csv("WDI_paper_count.txt",header = TRUE,sep = ',') %>%
  filter(location != "unknown") %>%
  mutate(location = as.character(location))
geocoded = geocode(locations$location)
locations$lat = geocoded$lat
locations$lon = geocoded$lon
write.csv(locations,"WDI_paper_count_geocoded.txt",row.names = FALSE)
