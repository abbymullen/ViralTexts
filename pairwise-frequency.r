setwd("C:/Users/User/VM/")
# install.packages("dplyr", dependencies = TRUE) 
# ?manip # for details on dplyr operations

library(dplyr)
options(stringsAsFactors = FALSE)
 
pw <- read.csv("fullC19_expanded_uniq.txt", sep = "\t")

test <- head(pw, n=1000)

pw_total <- nrow(pw)

state_summary <- pw %.%
  group_by(source, target_state) %.%
  summarize(n = n()) %.%
  arrange(desc(n)) %.%
  mutate(pw_ratio = n / pw_total) %.%
  filter(source == "evening star.")

city_summary <- test %.%
  group_by(source_city, target_city) %.%
  summarize(n = n()) %.%
  arrange(desc(n))

papers_by_state <- pw %.%
  group_by(source_state) %.%
  summarize(papers_n = length(unique(source))) %.%
  arrange(desc(papers_n))

reprints_per_paper <- state_summary %.%
  merge(papers_by_state, by.x = "source_state", by.y = "source_state") %.%
  mutate(source_papers_n = papers_n) %.%
  merge(papers_by_state, by.x = "target_state", by.y = "source_state") %.% 
  mutate(target_papers_n = papers_n.y) %.% 
  mutate(reprints_per_source_paper = n / source_papers_n) %.%
  mutate(reprints_per_target_paper = n / target_papers_n)

reprints_per_paper$papers_n.x <- NULL
reprints_per_paper$papers_n.y <- NULL

reprints_per_paper %.%
  arrange(desc(reprints_per_target_paper)) %.%
  head(n = 10)

reprints_ratio <- state_summary %.%
  mutate(ratio = state_summary / pw_total)

write.csv(reprints_per_paper, "reprints-per-paper_1855-1859.csv")
write.csv(reprints_ratio, "reprints_ratio_1836-1840.csv")
write.csv(state_summary, "state_summary_fullC19.csv")
write.csv(papers_by_state, "papers_by_state_fullC19.csv")
