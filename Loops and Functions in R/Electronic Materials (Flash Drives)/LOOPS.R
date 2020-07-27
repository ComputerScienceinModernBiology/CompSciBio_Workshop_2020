#### Computer Science Workshop 
#### Miami University - Oklahoma University 
#### Course: Loops and Functions in R
#### Instructor: Alfredo Ascanio
#### Assistant instructors: Tereza Jezkova, Meelyn Pandit
#### Date: 08/10/2020-08/14/2020 

###################################################################
######################### For-Loops ###############################
###################################################################

# Structure of a for loop #
for(i in 1:10) {
    print(i)
}
# for() is the function that will initialize the loop
# i is the iterative term
# 1:10 is a numeric vector from 1 to 10
# print(i) is the process

#################### Quick Exercise #############################
# a) You can add a mathematical operation to the previous process
for(i in 1:10) {
    print(i) # Add operation
}

# b) You can make the vector a character vector. See what happens
# Create a character vector
char_vector <- c() # Add character elements within "" to char_vector
for(i in 1:10) { # Substitute 1:10 for your character vector
    print(i)
}

#################### Practice with For-Loops ####################

#### a) Create a for-loop for printing elements from a character vector
char_vector <- LETTERS # You can change this vector if you want
# Option 1
for(char in char_vector) { 
    print(char)
}
# The iterative term doesn't need to be "i" always, it can be whatever you like
#Option 2
for(i in 1:length(char_vector)) {
    print(char_vector[i])
}


#### b) For-loop: mathematical operations on numeric vectors
math <- c(5, 8, 10, 13, 14, 17, 21, 24)
# Sum 2 and print the output
for(){}

# Sum 2, divide by 3, raise to the power of the original number, and print
for(){}

#### c) For-loop by factor on a biological dataset
Data <- iris # Loading the data
head(iris) # Viewing part of the data
# Create a loop to extract the mean values of Sepal and Petal Length of each flower
for(){}


###################################################################
########## Exercise 3: Lets find the exit of the maze! ############
###################################################################

source("Maze_functions.R")
Maze <- make_maze(maze_levels = 10)
View(Maze)

# Using the logic behind the conditional you built before, 
# construct a for-loop to find the exit of the maze
# HINT: The object in this case is "Maze", instead of "where_at"

for(){}

###################################################################
######## Exercise 4: Lets Join Data from different sources! #######
###################################################################

# You will use data from the species of manatee Thricherus manatus
# In the folder called Splitted_Tmanatus

# Example of joining two datasets
# Create a NULL Object
full_data <- NULL

# Read csv files
Data1 <- read.csv("Splitted_Tmanatus/Diveboard - Scuba diving citizen science.csv", stringsAsFactors = FALSE)
Data2 <- read.csv("Splitted_Tmanatus/Fort Fisher.csv", stringsAsFactors = FALSE)

# Joining two datasets by row (if they have the exact same columns' structure)
full_data <- rbind(Data1, Data2) 

# you can bind NULL objects with others, may be useful for your loop
full_data <- rbind(full_data, Data1, Data2) 

# list.files() allows you to list all the files in a folder
files <- list.files("Splitted_Tmanatus/")

# You can paste the folder name to your files
files <- paste("Splitted_Tmanatus/", files, sep = "")

#### Create your Loop ####
for(){}


###################################################################
######################## While-Loops ##############################
###################################################################

#### Example of While loop ####
# Create X variable
x <- 1
# While-loop
while(x < 10) { # Condition within (), instead of sequence
    x = x + 1
    print(x)
}


####################### Quick Exercise ###########################

# Remember the coin_toss
coin_toss <- rbinom(n = 1, size = 1, prob = 0.5)
# Create X variable
x <- 1
# while-loop
while(x ________) {
    # Add coin_toss
    # Add a conditional over the result of coin toss
        # In this case, there is no need to add an "else" statement, as nothing
        # should happen to x if we fail the coin_toss
    # Add a print of x
}

###################################################################
####################### Repeat-Loops ##############################
###################################################################

#### Example of repeat loop ####

# Create x variable
x <- 1
# Repeat-loop
repeat {
    x = x + 1
    print(x)
    if(x == 10) {break()}
}
# We use the function break() after a conditional to stop the loop

####################### Quick Exercise ###########################

# Remember the coin_toss
coin_toss <- rbinom(n = 1, size = 1, prob = 0.5)
# Create X variable
x <- 1
# while-loop
repeat {
    # Add coin_toss
    # Add a conditional over the result of coin toss
        # In this case, there is no need to add an "else" statement, as nothing
        # should happen to x if we fail the coin_toss
    # Add a print of x
    # Add breaking condition
}

###################################################################