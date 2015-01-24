library(ggplot2)

papers <- read.csv("Papers_start_end.csv", header=TRUE)

run_time <- papers$end - papers$start
digitized <- papers$CA_end - papers$CA_start
percent <- digitized / run_time

p <- ggplot(papers, aes(papers$start))
p + geom_histogram()

q <- ggplot(papers, aes (papers$CA_start))
q + geom_histogram()

frequency <- table(papers$CA_start)
