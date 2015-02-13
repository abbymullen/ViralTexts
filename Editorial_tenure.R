#Calculating and Plotting the Tenure of Editors
#Read in the CSV file

tenure <- read.csv("C:\\Users\\User\\Downloads\\Newspapers_Editorial_Tenure.csv", header=TRUE)

#Sorting the data by length of tenure and calculating frequency
tenure.frequency <- table(tenure$Total)

#Plot the frequency data
plot(tenure.frequency, ylab="Number of Editors", xlab="Years of Editorship", main="Editorial Tenure")