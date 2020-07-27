### DATA VISUALIZATION WORKSHOP
### COMPUTER SCIENCE IN MODERN BIOLOGY
### August 10-11, 2020
### Presenter:  Rachel Pilla
### TAs:  Andrew Cannizzarro & Nicole Berry


### Working with a shared script from a colleague ###

### You want to use this script to work with the Georgia COVID data.
### But your colleague wrote it with a different data set, though simiarly setup.
### Go through it line-by-line and fix the errors you find,
### and adjust the code to fit the COVID data set (i.e., change column names).

### Your goals are to:
### 1) Produce a plot of total COVID cases over time for the 5 Georgia counties.
### 2) Create statistical output to find the rate of change for the COVID cases
###    for EACH of the 5 counties, and determine which county is increasing the fastest.

### You have NOT learned the plotting and statistics yet (we'll be doing that tomorrow).
### So you'll have to work from this code provided by your colleauge as a baseline --
### don't forget you can use help files, Google, and StackOverflow to help!


########################################################################################


# load in your data file

covid <- read.csv(file.choose())

head(covid)
colname(covid)
summary(covid)


# this changes the "Date" column into a value that R recognizes as a date

covid$Date <- as.POSIXct(covid$Date)


# plot will have 10 lines (one for each state), and each will have its
# own unique color and point symbol to tell apart in the legend.

plot(NumberCases ~ Date, data = covid,
     col = as.factor(State),
     pch = as.numeric(as.factor(State))+15,
     ylab = "Number of New COVID-19 Cases,
     main = "COVID-19 Cases across 10 US States")
legend(x = "topleft",
       col = 1:10
       text.col = 1:10,
       pch = 16:26,
       legend = unique(covid$State))
     


# to find which of the ten states in my data set with the fastest increase, 
# look at the "Estimate" column, with the "date" row, which indicates the 
# slope. Whichever state has the largest slope has the fastest rate of increase.

summar(lm(NumberCases ~ Date, data = covid[covid$State == "Texas", ]))

summary(lm(NumberCases ~ Date, data = covid[covid$State == "Illinois", ]))

summary(lm(NumberCases ~ Date, data = covid[covid$State == "New York", ])

summary(lm(NumberCases ~ Date, data = covid[covid$State == "Florida", ]))

summary(lm(NumberCases ~ Date, data = covid[covid$State == "Washington", ]))

summary(lm(NumberCases ~ Date, data = covid[covid$State == "California", ]))

summary(lm(NumberCases ~ Date, data = covid[covid$State == "Georgia", ]))

summary(lm(NumberCases ~ Date, data = covid[covid$State == "Louisiana", ]))

summary(lm(NumberCases ~ Date, data = covid[covid$State == "Arizona", ]))

summary(lm(NumberCases ~ Date, data = covid[covid$State == "Michigan", ]))


