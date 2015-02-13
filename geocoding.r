library(ggmap)

#geocode data
data <- read.csv("C:\\Users\\User\\Desktop\\Hull_Correspondence.tsv", header=TRUE)
location <- as.character(data$Source_Location)
geoc <- transform(data, geo = geocode(location))
write.csv(geoc, "C:\\Users\\User\\Desktop\\Hull_Geocoded.csv")

#plot map of the USA using rworldmap
library(rworldmap)
newmap <- getMap(resolution = "medium")
usa.limits <- geocode(c("Lubec,Maine","Lake of the Woods, Minnesota","Cape Alava, Washington","Cape Sable, Florida"))
plot(newmap,
	xlim = range(usa.limits$lon),
	ylim = range(usa.limits$lat),
	asp = 1
	)

#plot data points on map
newspapers <- read.csv("C:\\Users\\User\\Desktop\\Newspapers_geocoded.csv")
points(newspapers$geo.lon, newspapers$geo.lat, col = "blue", cex = .6)

