# R Script from Colleague. We need to modify it so we can analyze the "horned_lizards.csv" file

#import records (population, longitude, latitude) in this order but without a header

setwd("~/Downloads/RII_Tereza")
RECORDS <- read.csv ("P_cornutum_5clades.csv")
levels (RECORDS$Clade)
LONGLAT <- RECORDS [,-1]

#extract bioclimatic variables using the package raster
library (raster)
VARIABLES <-  getData('worldclim', var='bio', res=2.5)
WC30 <- stack (VARIABLES)
CLIMATE <- extract (WC30, LONGLAT)
CLIMATE <- cbind (RECORDS, CLIMATE )

# run PCA
head (CLIMATE, 3)
CLIMATE <- CLIMATE[complete.cases(CLIMATE), ]
CL <- (CLIMATE [, 4:22])
PCA <- prcomp (CL, center=TRUE, scale.=TRUE)
#get PCA values
print (PCA)
plot(PCA, type = "l")
summary (PCA)
GROUP <- (CLIMATE [, 1])

library(devtools)
#install_github("ggbiplot", "vqv")
library(ggbiplot)
library (digest)
g <- ggbiplot(PCA, obs.scale = 1, var.scale = 1, 
              groups = GROUP, ellipse = TRUE, 
              circle = FALSE)
g <- g + scale_color_manual (values =  c ("blue", "green", "purple", "red", "yellow"))
g <- g + theme(legend.direction = 'horizontal', 
               legend.position = 'top')
print(g)
write.csv (PCA$x, file="./PCA.csv")



