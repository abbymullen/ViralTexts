library(ggplot2)

papers <- read.csv("Papers_start_end.csv", header=TRUE)

run_time <- papers$end - papers$start
digitized <- papers$CA_end - papers$CA_start

p <- ggplot(papers, aes(name, CA_start))
p + geom_boxplot() + coord_flip()
