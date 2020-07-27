### DATA VISUALIZATION WORKSHOP
### COMPUTER SCIENCE IN MODERN BIOLOGY
### August 10-11, 2020
### Presenter:  Rachel Pilla
### TAs:  Andrew Cannizzarro & Nicole Berry


### DAY 1 ###


######################################
### Introduction to R and packages ###
######################################

### PTT:
# - what is R?
# - layout/panes of RStudio
# - packages and installing
# - help files
# - using an R script (ALWAYS use script; how to run code; adding comments;
#   case sensitive; spaces, parentheses, quotations; carrot in console vs. +)
# - functions, arguments, and objects
# - types of data (numeric, integer, character, logical, complex)
# - data structures (vector, matrix, data frame)


### LIVE CODING (remainder of Day 1)


###################
### Basics in R ###
###################

# INSTALLING PACKAGES

install.packages(c("dplyr", "tidyr"))



# LOADING PACKAGES

library(dplyr)
library(tidyr)



# R is a calculator






# WHAT IS AN OBJECT?
# Saving objects in R, and viewing object data
# (Environment Pane; how to name "best" - must begin with letter, caps or lowercase accepted;
# name objects clearly and consistently)

a <- 5 + 4


a



# Saving a script (file naming...) - do this now
# Scripts can be shared, edited, resaved, copy/pasted, etc. (much like a text editor)


# Style tips for writing code:
# 1) R is case sensitive ("A" does not equal "a")
# 2) Best practice is to put spaces between object, values, commas, etc. (though R does not require this)
# 3) Missing parentheses, commas, or quotation marks cause a vast majority of errors
# 4) Your collaborators and future self will apprecite detailed comments
# 5) Make sure the console has a blue ">" before running (if it has a "+" then it DID NOT FINISH the previous code for some reason)


# Errors and warning messages
# Errors BREAK the code, warnings run it (often not an issue, but keep an eye out that R is doing what you want)

A
c <- b - 3) * 2
cbind(c(1, 2, 3), c(1, 2, 3, 4))


# Basic functions and help files

?mean






# Types of data in R:
# numeric/integer, character/strings, logical, factor (others are less common)

# Types of data structures in R:
# 1) vector - 1D, holds only 1 type of data
# 2) matrix - 2D, holds only 1 type of data
# 3) data frame - 2D, each column can be different type of data
# data frame is very common and useful; other types are generally less common (e.g., lists)

df1 <- data.frame("Column1" = c("A", "B", "C", "D", "E"),
                  "Column2" = vector1,
                  "Column3" = c("hi", "my", "name", "is", "Rachel"))
df1






#################
### - BREAK - ### 
#################


##############################
### Working with data in R ###
##############################


## OPEN CSV FOR TROPICAL STORM DATA

# Getting files prepared for R from Excel
# type in "NA" for missing data and R knows how to handle that


# Load in data file to R
# "TropicalStormData.csv" - pull up to have copied and saved

file <- file.choose()
storms <- read.csv(file)

head(storms)
str(storms)


# Indexing from an object
# (when using square brackets, row ALWAYS comes first)

storms[5, 1]
storms[5, ]
storms[ , 1]
storms$Year[5]
storms$Year[c(5, 10)]
storms$Number.Tropical.Storms[1]
storms$Number.Tropical.Storms[storms$Year == 2004]
storms$Year[storms$Number.Tropical.Storms > 15]


# PRACTICE
# 1) index 5 most recent years of storm counts
# 2) index the storm counts for years 2003, 2007, and 2008
# 3) index the year that had the highest numbers of storms







# PRACTICE loading csv file into R
# (a new data file -- bird banding data)

# 1) load in the data file and peek at the columns/structure

# 2) calculate the average annual count column

# 3) find the earliest and latest year of data

# 4) INDEXING:
#    a) find the species and year that had the highest recorded count
#    b) find how many unique species are in the data set (HINT:  function "unique")
#    c) find the average count for all Long distance migrants in the year 2010





















### DAY 2 ###



#########################
### Manipulating data ###
#########################

# dplyr: four main functions and pipe tool
# data frame name is ALWAYS the first argument for these if using alone

select
filter
mutate
summarize

## choose specific column(s) by name

BirdNamesCounts <- select(birds, CommonName, AnnualCount)
BirdNamesCounts


## choose row(s) by condition

Year2000 <- filter(birds, Year == 2016)
Year2000


# create new column(s)

AboveBelow <- mutate(birds, AboveBelowAvg = AnnualCount - 8)
AboveBelow


# summarize (must become fewer rows than original)
MeanCount <- summarize(birds, MeanCount = mean(AnnualCount))
MeanCount



# pipe tool for multiple steps at once
# do NOT need to name data frame if using this, since it will automatically start with the 
# data frame remaining from the previous line of code

PopularBirds <- birds %>%
  filter(AnnualCount >= 8) %>%
  select(Year, CommonName, AnnualCount)
PopularBirds


## grouping and summarizing

TotalByMigration <- birds %>%
  group_by(Year, MigrationType) %>%
  summarize(TotalCount = sum(AnnualCount))
TotalByMigration


# PRACTICE
# using the dplyr tools, create a new object
# that gives the average number of storms in years since 2010 (inclusive)









# reformatting from long to wide to long using "spread"
# after summarizing (above) and then renaming
# (opposite of "spread" is "gather")

birdsWide <- TotalByMigration %>%
  select(Year, MigrationType, TotalCount) %>%
  spread(key = MigrationType, value = TotalCount) %>%
  rename(LongDistance = 'Long distance migrant',
         ShortDistance = 'Short distance migrant')
birdsWide




## PRACTICE:
# find the mean number of insects from each spray type in this experimental dataset

















##########################
### PRACTICE EXERCISES ###
##########################

## EXPLORE THE COVID DATA FROM 5 GEORGIA COUNTIES

## 1) Read in the provided csv file into R and give it a new object name





## 2) Look at the data, structure, summary, etc. to familiarize yourself with it







## 3) How many total new cases did these five counties report in this time period?





## 4) Summarize the data by county to find the following information:
##    - lowest number of cases per day for each county
##    - highest number of cases per day for each county
##    - average number of cases per day for each county
##    - total number of cases for this time period for each county









## 5) Find the date where these five counties combined had the lowest and the highest number of cases











###########################
### Basic Plotting in R ###
###########################

## histogram

hist(storms$Number.Tropical.Storms)







## boxplot

boxplot(TotalCount ~ MigrationType,data = TotalByMigration)








## scatterplot

plot(Number.Tropical.Storms ~ Year, data = storms)







## trend line









## PRACTICE:
## make a scatterplot of the total long-distance birds per year with a trend line









############################
### Statistical analyses ###
############################


## basic statistics in R

# correlation of bird migration types

cor(x = birdsWide$LongDistance, y = birdsWide$Resident)




# t-test - one-sided (number of tropical storms with zero)

t.test(storms$Number.Tropical.Storms)



# 2-sided t-test to compare two different sets of data/columns

t.test(x = birdsWide$LongDistance, y = birdsWide$Resident)


# ANOVA (1-way)
# does migration type influence the annual count of birds?
# NOTE: data needs to be summarized in LONG format

bird.anova <- aov(TotalCount ~ MigrationType, data = TotalByMigration)
summary(bird.anova)

TukeyHSD(bird.anova)



# PRACTICE:  ANOVA and Tukey HSD (if necessary) 
# is insect count influenced by spray type?










## LINEAR REGRESSION
# linear regression of tropical storm trends over time

# are the number of long-distance birds changing over time?

bird.mod <- lm(LongDistance ~ Year, data = birdsWide)
summary(bird.mod)


## PRACTICE:  are the number of tropical storms per year changing?








