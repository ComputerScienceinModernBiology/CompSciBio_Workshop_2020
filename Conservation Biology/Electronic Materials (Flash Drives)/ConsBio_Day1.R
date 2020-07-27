# R code and comments for Conservation Biology as part of the Computing in Modern Biology Workshop 2020
# Code assembled by Hayley C. Lanier
# Day 1: Plotting species threat data and population size

# Command to set working directory to dataset location
#setwd("~/Desktop/Computing/ConsBio")

#Read in dataset. Original data located at https://www.iucnredlist.org/resources/summary-statistics
# IUCN Red List Categories: EX - Extinct, EW - Extinct in the Wild, CR - Critically Endangered (includes CR(PE) and CR(PEW)), EN - Endangered, VU - Vulnerable, NT - Near Threatened, DD - Data Deficient, LC - Least Concern. CR(PE) & CR(PEW): The tags 'Possibly Extinct' and 'Possibly Extinct in the Wild' have been developed to identify CR species that are likely already extinct (or extinct in the wild), but require more investigation to confirm this. NOTE that these are not IUCN Red List Categories; they are tags that can be attached to the CR category to highlight those taxa that are possibly extinct. They are included in the above table to indicate a plausible upper estimate for number of recently extinct species on The IUCN Red List.
mammals<-read.table("mammals_IUCN.txt",row.names=1,header=T,sep="\t")

View(mammals) # look at the dataset
names(mammals) # list the column names for the mammals dataset
row.names(mammals) # list the names for each row of data in the mammals dataset

iucn.status<-row.names(mammals) # creates a vector of names for categories of conservation status from the row names in the dataset
iucn.colors<-c("grey5","red","orange","yellow","grey","green","darkgreen") # creates a vector of colors associated with each conservation status rank

#################################################
# How much conservation risk are mammals under? #
#################################################
# Plot the data for all mammals by conservation status
pie(mammals$Total,labels=iucn.status,col=iucn.colors,main="All mammals")

# Count the number of mammal species in each category
rowSums(mammals[,1:27]) # sums across all rows, for all columns all orders (first 27 columns of the dataset)); Should be the same results as using: mammals$Total to read out the total number column (which is column 28)

# Calculate that number as a % of total mammals
# This calculates the sum within each row by conservation status, divides it by the total number of mammals (sum(mammals) and then rounds the result to just two significant digits)
round(rowSums(mammals)/sum(mammals),2)

###########################################
# Which group of mammals is at more risk? #
###########################################
# Barplot all of the data together
barplot(as.matrix(mammals[1:27]),col=iucn.colors,xlab="number of species",horiz=T,las=2,cex.names=0.6)

### Barplot a subset of the IUCN data
# Pull out just four Orders of mammals to compare
comp.table<-cbind(mammals$Carnivora,mammals$Lagomorpha,mammals$Primates,mammals$Pholidota) 

# Plot the result together and add a legend (really two commands, separated with a semi-colon)
barplot(comp.table,col=iucn.colors,names=c("Carnivora","Lagomorphs","Primates","Pangolins"),ylab="number of species",main="Which group is at higher risk?"); legend(4,470,iucn.status,pch=22,pt.bg=iucn.colors)

# set to plot just one plot in window (1 row, 1 column)
par(mfrow=c(1,2))   # Set up the plot background to show 2 plots side-by-side (1 row, 2 columns)
# par(mfrow=c(1,1)) # Undoes the previous command - just get rid of the comment 

# Plot the conservation status for each gropu as it's own pie chart
pie(mammals$Carnivora,labels=iucn.status,col=iucn.colors,main="Carnivores")
pie(mammals$Lagomorpha,labels=iucn.status,col=iucn.colors,main="Lagomorphs")
pie(mammals$Primates,labels=iucn.status,col=iucn.colors,main="Primates")
pie(mammals$Pholidota,labels=iucn.status,col=iucn.colors,main="Pangolins")

#######################################################
# Digging into Laogmorpha data - who is at more risk? #
#######################################################
# read in dataset
lago<-read.csv("lagomorph-status.csv") 

# organize dataset and colors for plotting
lago$status<-factor(lago$status,levels=c("CR","EN","VU","DD","NT","LC")) # set the order for the level of conservation threat (high to low; otherwise it will just be alphabetized)
lago$Trend<-factor(lago$Trend,levels=c("Unknown","Decreasing","Stable","Increasing")) # set the order for the level of conservation threat (high to low; otherwise it will just be alphabetized)
lago.colors<-c("red","orange","yellow","grey","green","darkgreen") # same colors as earlier, but without including a color for extinct species
lago.col.trend<-c("grey","darkorange","lightblue","darkgreen")

# summarize data for plotting
ls<-table(lago$Family,lago$status) # summarizes data by family and conservation threat status

# plot results as pie charts
pie(ls[1,],col=lago.colors,main="Rabbits & hares")
pie(ls[2,],col=lago.colors,main="Pikas")

# plot results as a table 
barplot(t(ls),col=lago.colors,ylab="number of species",names=c("rabbits & hares","pikas"),main="Conservation Status")

######################################################
# How do population trends inform our understanding? #
######################################################
trends<-table(lago$Family,lago$Trend)
barplot(t(trends),col=lago.col.trend,ylab="number of species",names=c("rabbits & hares","pikas"),main="Population Trend")

# plot trends as pie charts
pie(trends[1,],col=lago.col.trend,main="Rabbits & hares")
pie(trends[2,],col=lago.col.trend,main="Pikas")

############################
# Working with census data #
############################
install.packages("popbio") #install the popbio package (a developed set of data and tools for working in conservation/population biology

library(popbio) # turns on the popbio [ackage]
data(grizzly) # loads the Yellowstone grizzly dataset that comes with the popbio package

# Let's learn more about the grizzly dataset
View(grizzly) # look at the dataset
?grizzly # learn more about the dataset
names(grizzly) # learn what the column names are for this dataset

# some housekeeping commands
attach(grizzly)		# makes dataset run without using the grizzly$ 
par(mfrow=c(1,1)) # plot one plot per window
par(bty="n")

###########################################################
# How do we know if a population is growing or shrinking? #
###########################################################

# Plot 25 years of grizzly population changes in Yellowstone
plot(year[1:25], N[1:25]) # a basic, no-frills plot (not quite as nice to eary to interpret

# A better looking plot of the same data
plot(year[1:25], N[1:25], type='o', pch=16, las=1, xlab="Year", ylab="Adult females", main="Yellowstone grizzly bears") 

# export your plot as a pdf
dev.print(pdf,file="grizzlyBears_1960-1983.pdf") # Handy command to print out a plot as a pdf as shown on the screen

# Plot the full range of the Yellowstone data 
plot(year, N, type='o', pch=16, las=1, xlab="Year", ylab="Adult females", main="Yellowstone grizzly bears")

############################################
# Case studies: looking at population data #
############################################
detach(grizzly) # some housekeeping to detach the grizzly data

# Read in your dataset by either modifying the command below or changing which line is commented out
popDat<-read.table("yourFileNameHere",header=T,sep="\t")

# Desert Yellowhead (a flowering plant from Wyoming)
#popDat<-read.table("DesertYellowhead.txt",header=T,sep="\t")
# Collared pikas (from the Yukon Territory, Canada)
#popDat<-read.table("collared_pikas.txt",header=T,sep="\t") 
# Red-cockaded woodpeckers (North Carolina or Central Florida population)
#popDat<-read.table("woodpecker_NC.txt",header=T,sep="\t") 
#popDat<-read.table("woodpecker_CF.txt",header=T,sep="\t") 
# Vancouver Island marmot
#popDat<-read.table("Vl_marmot.txt",header=T,sep="\t") 
# Olympic marmot
popDat<-read.table("Oly-Marmots.txt",header=T,sep="\t") 

attach(popDat)

# plot your data
# Change 'Your Dataset' to the name of the species/population you are plotting
plot(year, N, type='o', pch=16, col="darkblue", las=1, xlab="Year", ylab="population size", main="Your Dataset")

detach(popDat)
