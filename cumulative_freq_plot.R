library(ggplot2)
library(dplyr)

<<<<<<< HEAD
dates <- read.csv("pre1861-ca-dates.tsv", sep='\t', header=FALSE)
=======
dates <- read.csv("Papers_start_end.csv", sep=',')
>>>>>>> 2db5ef9d92da7d3fe4f646ae81b93977c1164b2b

starts <- dates$CA_start

starts_freq <- as.data.frame(table(starts))

<<<<<<< HEAD
write.csv(starts_freq, file = "issues_starts_freq.csv")
=======
write.csv(starts_freq, file = "starts_freq.csv")
>>>>>>> 2db5ef9d92da7d3fe4f646ae81b93977c1164b2b

breaks <- seq(1836, 1861, by=1)
starts.cut <- cut(starts, breaks, right=FALSE)
starts.freq <- table(starts.cut)
starts.cumfreq <- cumsum(starts.freq)
cumulative <- cbind(starts.cumfreq)
cumulative_freq <- as.data.frame(cumulative)
write.csv(cumulative_freq, file = "Cumulative_Frequency.csv")

cumulative_freq <- read.csv('Cumulative_Frequency.csv', sep=',')
freq_start <- read.csv('starts_freq_edit.csv', sep=',')

cumulative_freq$year <- cumulative_freq$year_range %>%
  as.character %>%
  sub(".([0-9]{4}).*",'\\1',.)



freq <- data.frame(year = 1836:1860, cumulative = as.vector(cumulative_freq$starts.cumfreq))
freq <- merge(freq, freq_start, by='year')

p <- ggplot(freq, aes(x=year, y=cumulative))
p + geom_point() +
  xlab("Year") +
  ylab("Cumulative number of papers") +
  ggtitle("Cumulative Number of Papers in CA by Date")

r <- ggplot(freq, aes(x=year)) 
r + geom_area(aes(y=cumulative), fill='gray') +
#  geom_line(aes(y=Freq)) +
  xlab("Year") +
  ylab("Cumulative number of papers") +
  ggtitle("Cumulative Number of Papers in CA by Date")

p <- ggplot(freq, aes(x=year))
p + geom_line(aes(y=Freq)) +
  xlab("Year") +
  ylab("Number of papers") +
  ggtitle("Number of Papers Added to CA by Date")
