library(ggplot2)
library(dplyr)

dates <- read.csv("Papers_start_end.csv", sep=',')

starts <- dates$CA_start

breaks <- seq(1836, 1860, by=1)
starts.cut <- cut(starts, breaks, right=FALSE)
starts.freq <- table(starts.cut)
starts.cumfreq <- cumsum(starts.freq)
cumulative <- cbind(starts.cumfreq)
cumulative_freq <- as.data.frame(cumulative)

cumulative_freq <- read.csv('Cumulative_Frequency.csv', sep=',')

cumulative_freq$year <- cumulative_freq$year_range %>%
  as.character %>%
  gsub(".*([0-9]{4}).*","\\1",.)

freq <- data.frame(year = 1837:1860, cumulative = as.vector(cumulative_freq$starts.cumfreq))

p <- ggplot(freq, aes(x=year, y=cumulative))
p + geom_point() +
  xlab("Year") +
  ylab("Cumulative number of papers") +
  ggtitle("Cumulative Number of Papers in CA by Date")

r <- ggplot(freq, aes(x=year)) 
r + geom_area(aes(y=cumulative)) +
  xlab("Year") +
  ylab("Cumulative number of papers") +
  ggtitle("Cumulative Number of Papers in CA by Date")
