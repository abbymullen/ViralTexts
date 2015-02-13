#Calculating and Plotting the Tenure of Editors
#Read in the CSV file

places <- read.csv("C:\\Users\\User\\Downloads\\Newspapers_Editorial_Tenure.tsv", sep='\t', header=TRUE)

#Sorting the data by length of tenure and calculating frequency
places.frequency <- table(places$Location)

places.frequency
#Plot the frequency data
#plot(places.frequency, ylab="Number of Editors", xlab="Years of Editorship", main="Editorial Tenure")


write.table(places.frequency, "C:\\Users\\User\\Desktop\\editor_locations.txt", sep = '\t')
