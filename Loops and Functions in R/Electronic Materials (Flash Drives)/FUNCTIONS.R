#### Computer Science Workshop 
#### Miami University - Oklahoma University 
#### Course: Loops and Functions in R
#### Instructor: Alfredo Ascanio
#### Assistant instructors: Tereza Jezkova, Meelyn Pandit
#### Date: 08/10/2020-08/14/2020 

###################################################################
######################### Functions ###############################
###################################################################

############## Example of a function: sample() ###################

sample(x = c("A", "B", "c", "D"), size = 2) # select two random elements from X
sample(x = 1:20, size = 5) # Select 5 random elements from the vector of 1:20
sample(1:20, 5)            # Select 5 random elements from the vector of 1:20

# Help of sample
?sample
help(sample)

# Arguments of sample
args(sample)

# Code of sample()
sample # Shows in console
View(sample) # Shows in another script tab

###################################################################
############# Let's write our first function! #####################
###################################################################

# a) create a function that multiplies two numbers
Multiplication <- function(X, Y) { # Add arguments
    # Internal process
    Z = X*Y
    return(Z)
}

Multiplication(X = 3, Y = 8)
Multiplication(2, 9)
Multiplication()

# b) Add default values to our previous function
# X should default to 1, and Y to 7

Multiplication <- function(X _________, Y _________) { # Add default values
    # Internal process
    Z = X*Y
    return(Z)
}

Multiplication()
Multiplication(Y = 8, X = 3)
Multiplication(9)

###################### Quick Exercise #############################

# Create a function called "power_of" that will raise one number "X"
# to the power of the second number "Y". Set default values in a way
# that, whenever the second number (Y) is not provided, the result of power_of(X)
# will be 1

power_of <- function(){
    #Internal process
}

power_of(2, 2) # Should result in 4
power_of(2, 0) # Should result in 1
power_of(3, 3) # Should result in 27
power_of(434)  # Should result in 1

###################################################################
##### Exercise 5: Build a function to solve any Maze! #############
###################################################################
source("Maze_functions.R")
Maze <- make_maze(maze_levels = 100)

solve_maze <- function(AnyMaze) {
    #Internal process
}

solve_maze(Maze) # Should print the solution for your maze


###################################################################
##### Final Exercise: Merging Loops and Functions #################
########## Mapping Species Occurrences by Year ####################
###################################################################

#### Load packages ####
library(rgdal)
library(sp)
library(tidyverse)

#### Read Data ####
occurrences <- read.delim("Python_bivittatus/occurrence.txt")
Florida <- readOGR("Florida_State_Waters_and_Land_Boundary-shp", "Florida_State_Waters_and_Land_Boundary")

# Extracts species name, year, and coordinates
occurrences <- occurrences[, c(230, 103, 133, 134)] 

head(occurrences)

# Retain full records, without NAs #
occurrences <- occurrences[complete.cases(occurrences), ]

# Frequency table of occurrences per year #
table(occurrences$year)

# Transform into spatial points object with year as attribute #
occurrences <- SpatialPointsDataFrame(coords = occurrences[, 4:3], data = occurrences[, 1:2])

# Plotting all the data first #
plot(Florida)
points(occurrences)

# Available years
sort(unique(occurrences$year))

# Plotting just one year #
plot(Florida, main = 1991)
points(occurrences[occurrences$year == 1991, ], col = "red")


# Plotting just one year #
plot(Florida, main = sort(unique(occurrences$year))[1])
points(occurrences[occurrences$year == sort(unique(occurrences$year))[1], ], col = "red")

########## Create your function below ##############
map_years <- function() {
    #Internal process
    # For Loop
    for(){}
}

# Try your function over the Python bivittatus data
# If we have enough time, try it over the Trichechus manatus data