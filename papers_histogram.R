library(ggplot2)

papers <- read.csv('Papers_start_end.csv', header = TRUE)

DF <- rbind(data.frame(fill="blue", start=papers$start),
            data.frame(fill="red", start=papers$CA_start))

ggplot(DF, aes(x=start, fill=fill)) + geom_histogram(binwidth=.7, alpha=.7, position="dodge") +
  scale_fill_identity()
