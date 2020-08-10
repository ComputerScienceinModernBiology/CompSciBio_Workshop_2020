#### Get folder 'ENM Pikas' or individual files from GitHub https://github.com/ComputerScienceinModernBiology/CompSciBio_Workshop_2020 ####

#### install and load required packages #### 

# install.packages("name_of_package")

library (dismo)
library (maptools)
library (rgdal)
library (rgeos)
library (spThin)
library (rJava)
library (mapdata)
data (wrld_simpl)

#Sys.setenv(JAVA_HOME='C:/Program Files/Java/jdk1.8.0_181/jre')
#Sys.setenv(JAVA_HOME='C:/Program Files/Java/jdk-14.0.2')

#### set your directory ####
getwd () # find where you are if lost
setwd ("yourpath_to_directory/ENM Pikas") #make sure you navigate to the directory where your variables are

#### Import occurence records ####
RECORDS <- read.csv ("Ochotona_princeps.csv") # First we are going to import occurence records for the pika 
head (RECORDS) #just to see if the data look right
nrow (RECORDS) #let's see how many records we have

### let's plot the occurence records ###
#first, we want to define the extent of the geographic area we are dealing with. 
coordinates(RECORDS) <- ~decimallongitude+decimallatitude
crs(RECORDS) <- crs(wrld_simpl)
r <- raster (RECORDS) # r is a map corresponding to the area covered by our occurence points
res(r) <- 0.5 #setting resolution of the raster, shouldn't matter much but don't choose very high resolution or your raster will be huge
r <- extend(r, extent(r)+5) # we will extent our r by 5 degrees to get a little bit of a buffer

# we will upload the records again (because we changed the format above)
RECORDS <- read.csv ("Ochotona_princeps.csv")
LONGLAT <- RECORDS [,-1] #removing the first column

# let's check our ploints
hull <- convHull(LONGLAT, lonlat=TRUE) # makes polygon around our points
plot (hull@polygons, border='red', lwd=2)
points (LONGLAT, cex=1, col='red') #plot points
STATES <- readShapePoly ("./states/states.shp") #add states
plot (STATES, add=T)
box ()

### That's a lot of records. We need to thin them ###
#will thin the records using the package spThin
thin(loc.data = RECORDS, lat.col = "decimallatitude", long.col = "decimallongitude", spec.col = "species", thin.par = 10, reps = 10, out.dir = "./", out.base = "O_princeps", max.files = 1)

# now upload the thinned data
THINNED <- read.csv ("O_princeps_thin1.csv")
head (THINNED)
nrow (THINNED) #let's see how many records we have after thinning

#and plot them
plot (hull@polygons, border='red', lwd=2)
LONGLAT_THINNED <- THINNED [,-1] #removing the first column
points (LONGLAT_THINNED, cex=1, col='blue') #plot points
plot (STATES, add=T)
box ()

### NOW LET's GET ENVIRONMENTAL VARIABLES ####
#these are the environmental variables we will be using the reconstruct the niche of a pika. there are 19 bioclimatic variables. 
VARIABLES <- list.files (path="./bio_2-5m_bil", pattern='bil', full.names=TRUE)
VARIABLES #always check to make sure the variables got read correctly
WC <- stack (VARIABLES)
WC_cropped <- crop (WC, r) #crop them to the extent of our working raster
WC_cropped #again, check to make sure everything looks correct

plot (WC_cropped$bio1) # let's check one of our variables

#NOTE: a common practice is to remove correlated environmental variables. 
#NOTE: We are not going to do that here but you can assess how correlated your variables are using e.g. package ENMtools

#### Now we can build our Ecological Niche Model. We will do it in the package dismo

# to run dismo sucesfully, you need to do 2 things - 
# (1) place maxent.jar into your R-dismo-java directory (you can download maxent.jar from the Maxent website and it's also in your folder)  
# (2) install rJava. This is a pain and may be frustrating. We will try to help you get this done for future use

# we are using dismo and the function"maxent" to reconstruct the climatic nice
# notice we have to make some decisions about number of background points (nbg), and parameters (betamultiplies, features). We will discuss this.
# it is a standard practise to do model testing to select the best combination of parameters. You can use the package ENMeval to do this
xm <- maxent (WC_cropped, LONGLAT_THINNED, nbg=10000, removeDuplicates=TRUE, args=c('betamultiplier=2.5','linear=true', 'quadratic=true', 'hinge=true', 'product=true'))

#NOTE: tomorrow, we will learn more about how to interpret results

# now we have reconstructed the niche, next we project the climatic niche on the map of the current climate
rcur <- predict(WC_cropped, xm, progress='text')

#this is how we can plot the model
plot(rcur)
plot (STATES, add=T)
plot (wrld_simpl, add=T)
points (LONGLAT_THINNED, cex=1, col='black')

# let's now project on a different set of climates. Here we will do the last glacial maximum climate (18,000 years ago)
VARIABLES_LGM <- list.files (path="./cclgmbi_2-5m", pattern='bil', full.names=TRUE) #fyi, there is an error in this line of code just to keep things interesting
WC_LGM <- stack (VARIABLES_LGM)

# all variables have to be the exactly the same extent and resolution. These are conveniently the same resolution 
WC_LGM <- crop (WC_LGM, r)

# now we project the niche on the LGM climate
rlgm <- predict(WC_LGM, xm, progress='text')

# and plot the LGM (18,000 ybp) and current ENM
dev.new(width=60, height=30)
par(mfrow=c(1,2))
plot(rlgm)
plot (STATES, add=T)
plot (wrld_simpl, add=T)
points (THINNED, cex=1, col='black')
plot(rcur)
plot (STATES, add=T)
plot (wrld_simpl, add=T)
points (THINNED, cex=1, col='black')

# the R graphics is not great. If you know ArcGIS, you might want to export your ENM as raster
writeRaster(rcur, "current", format="GTiff",overwrite=TRUE )

# let's now project the model on the future climate, you have one scenario available ac45bi70
# You might have little bit of trouble with that. Let's see if you figure out what the problem is

#### Now go back to your predictions and work on your slide


############# WORK FOR THOSE WHO ARE DONE AND BORED#####################

# let's add a new variable, we will try landcover, downloaded from the USGS GAP analysis
### the chalange will be to match the our climate with this new layer
RECORDS <- read.csv ("pika_NV.csv")
RECORDS <- RECORDS [,-1]

gap <- readGDAL ("./gap/gap.bil")
wc <- readGDAL ("./bio_2-5m_bil/bio1.bil")
gap <- raster (gap)
wc <- raster (wc)

wc <- crop (wc, gap) #match extent
gap <- resample (gap, wc, method="ngb") #match resolutions

wcgap <- stack (wc,gap)

xm <- maxent (wcgap, RECORDS, nbg=10000, removeDuplicates=TRUE, factors= "band1.2", args=c('betamultiplier=1','linear=true', 'noquadratic', 'nohinge', 'noproduct'))

# now use predict to project the model and then plot it
# compare this model to the one built using climate alone. What do you conclude?



########################################## ADDITIONAL STUFF ###################################

#### model testing with ENMeval ####

# run Maxent
library (rJava)
library (ENMeval)
backg <- randomPoints(WC, n=1000, ext=r)
ENM <- ENMevaluate(RECORDS, WC, bg.coords = backg, method = "randomkfold", kfolds = 3, parallel=TRUE, rasterPreds = TRUE)
writeRaster(ENM@predictions[[which (ENM@results$delta.AICc ==0)]], "name of raster", format="GTiff",overwrite=TRUE) 
write.csv (ENM@results, file="./ENM_results.csv")

