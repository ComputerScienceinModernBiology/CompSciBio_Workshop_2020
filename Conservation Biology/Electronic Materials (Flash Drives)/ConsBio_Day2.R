# R code and comments for Conservation Biology as part of the Computing in Modern Biology Workshop 2020
# Code assembled by Hayley C. Lanier
# Day 2: Running a Population Viability Analysis

#setwd("~/Desktop/Computing/ConsBio"")

######################################
# Working with population count data #
######################################
# install.packages("popbio") # should have been installed on day 1

library(popbio) # turn on the popbio package
data(grizzly)   # loads the Yellowstone grizzly dataset
attach(grizzly) # re-attach the dataset, so that just the column names can be used

# Re-plot the Yellowstone data to take another look at it
plot(year, N, type='o', pch=16, las=1, xlab="Year", ylab="Adult females", main="Yellowstone grizzly bears")

######################################################################
# Running a Population Viability Analysis (PVA) on census/count data #
######################################################################
# First, we need to pull some important information about your population from the census data
# The code below calculates the rate of change associated with each sampling interval (i.e., how much does the population size change between one census and the next)
# These are things you could easily calculate by hand. But computers make it faster and more repeatable.

nt<-length(N)           # counts the number of times your population has been surveyed by counting the number of rows in your dataset
logN<-log(N[-1]/N[-nt]) # determines change in population size in one year relative to the change across all years (on a log scale)
x<-sqrt(year[-1]-year[-length(year)]) # units of time (accounts for sampling events that are >1 year apart)
y<-logN/x          # change in population size relative to time between sampling events

# Plot the cumulative distribution function for the probability of extinction in the future. 
# In essence this asks the question ‘what is the probability that this population will have gone effectively extinct by a certain time in the future?’ 
# Changes in population growth rate (mu) are calculated directly from your data
# BUT you can set the current number of individuals in your population (Nc); right now this is set at the most recent number of individuals in your population
# You can also set the 'effective extinction' threshold (Ne), which is the number of individuals at which the population is considered 'effectively extinct'
countCDFxt(mu=mean(logN), sig2=var(logN), nt= length(year)-1, tq= max(year)-min(year), Nc=N[nt], Ne=20)

###################################
# Applying this to your organisms #
###################################
detach(grizzly) # some housekeeping to detach the grizzly data
rm(logN,nt,x,y) # remove all of the calculated parameters from the grizzly dataset

# Read in your dataset by either modifying the command below or changing which line is commented out
popDat<-read.table("yourFileNameHere",header=T,sep="\t")

# Desert Yellowhead (a flowering plant from Wyoming)
#popDat<-read.table("DesertYellowhead.txt",header=T,sep="\t")
# Collared pikas (from the Yukon Territory, Canada)
#popDat<-read.table("collared_pikas.txt",header=T,sep="\t") 
# Red-cockaded woodpeckers (North Carolina population)
#popDat<-read.table("woodpecker_NC.txt",header=T,sep="\t") 
#popDat<-read.table("woodpecker_CF.txt",header=T,sep="\t") 
# Vancouver Island marmot
#popDat<-read.table("Vl_marmot.txt",header=T,sep="\t") 
# Olympic marmot
popDat<-read.table("Oly-Marmots.txt",header=T,sep="\t") 

attach(popDat)

# plot your data (just to check that you have read in the right data)
# Change 'Your Dataset' to the name of the species/population you are plotting
plot(year, N, type='o', pch=16, col="darkblue", las=1, xlab="Year", ylab="population size", main="Your Dataset")

# We will again pull some important information about your population from the census data
# As above, this calculates the rate of change associated with each sampling interval (i.e., how much does the population size change between one headcount and the next)
nt<-length(N)           # counts the number of times your population has been surveyed by counting the number of rows in your dataset
logN<-log(N[-1]/N[-nt]) # determines change in population size in one year relative to the change across all years (on a log scale)
x<-sqrt(year[-1]-year[-length(year)]) # units of time (accounts for sampling events that are >1 year apart)
y<-logN/x          # change in population size relative to time between sampling events

# Now plot the cumulative distribution function for the probability of extinction in the future. 
# In essence this asks the question ‘what is the probability that this population will have gone effectively extinct by a certain time in the future?’ 
# Changes in population growth rate (mu) are calculated directly from your data
# The current number of individuals in your population (Nc) is set as the most recent number of individuals in your population (Ne=N[nt])
# Consider what the appropriate 'effective extinction' threshold (Ne) should be, and set it at that number. Again, this is the number of individuals at which the population would be considered to be 'effectively extinct', so generally more than 0.
countCDFxt(mu=mean(logN), sig2=var(logN), nt= length(year)-1, tq= max(year)-min(year), Nc=N[nt], Ne=20)

# When you're all done clean up your workspace
detach(popDat); rm(logN,nt,x,y)

###############################################################################
# UNDER THE HOOD - Additional information on PVA parameters for curious folks #
###############################################################################
# If you haven't had stats or an ecology course yet this section may seem somewhat confusing. That is totally okay, and completely normal! 
# Once you have a bit more background this section will make far more sense.

# This works using a parameter population biologists call 'mu' - the instantaneous rate of increase in a population
# It does this by calculating the difference between each population during each sampling interval, and then combining those values to create one estimate for the value
# First, we pull the same parameters as before from your data:
nt<-length(N)           # counts the number of times your population has been surveyed by counting the number of rows in your dataset
logN<-log(N[-1]/N[-nt]) # determines change in population size in one year relative to the change across all years (on a log scale)
x<-sqrt(year[-1]-year[-length(year)]) # units of time (accounts for sampling events that are >1 year apart)
y<-logN/x          # change in population size relative to time between sampling events

# You can then use the slope of the regression line to estimate mu μ, the average population growth in your sample. This captures whether your population has been growing or shrinking over time. 
mod<-lm(y~0 + x)

# Plot your data to look at the relationships between change per sampling period (generally year) and overall population growth rate
plot(x,y, xlim=c(0,1.8), ylim=c(-.3,.3), pch=16, las=1,
     xlab=expression((t[t+1]-t[i])^{1/2}),
     ylab=expression(log(N[t+1]/N[t]) / (t[t+1]-t[i])^{1/2}) ,
     main=expression(paste("Estimating ", mu, " and ", sigma^2, " using regression")))
abline(mod)		#code to add the trendline to your plot
# if the trendline is poisitive your population is growing
# if the trendline is negative your population is shrinking
# if the trendline is flat your population is stable

#Estimate the slope from the regression line in your previous graph to calculate μ, the average change in your populatino
mu<- coef(mod)

#The mean square residual value from the analysis of variance table is an estimator for σ2. If you haven’t learned what an analysis of variance or a mean square residual is yet, don’t worry – just know that this is a way to estimate how variable your dataset is. 
sig2<-anova(mod)[["Mean Sq"]][2] 

#Display both mean population growth rate (μ) and variance (σ2)
c(mean= mu , var= sig2)

#Calculate the confience interval for the population growth rate
confint(mod,1)

#Calculate a confidence interval for the variance (σ2)
df1<-length(logN)-1
df1*sig2 /qchisq(c(.975, .025), df= df1)
