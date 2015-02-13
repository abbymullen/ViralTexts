#Calculating and Plotting the Tenure of Editors
#Read in the CSV file
jobs <- read.csv("C:/Users/User/Desktop/Newspapers_Editorial_Jobs.txt")
barplot(jobs$Number, main="Professional Changes", names.arg=c("Died","Retired","Political office","Another newspaper","Paper folded","Another business","War","Ill health"),cex.names=.5,width=5,xlim=c(0,45),col='dark blue')