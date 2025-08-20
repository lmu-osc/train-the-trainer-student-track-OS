################ SESSION 2 (2nd half) ####################

# Task 1: reading in data:

characters <- readRDS("characters.rds")
## hint: if this is not working, check if you're working directory is set to the folder where the data set is saved. If you're unsure, you can use
getwd() # returns the path to your current working directory.


# Task 2: inspecting data structures

names(characters) # returns the column names of the data set
str(characters)   # returns the number of observations (rows) and variables (columns), the data type of each variables (e.g., chr = character, num = numeric) and the values in the first few rows of each column
head(characters)  # returns the first six rows of the data set
summary(characters) # returns a brief summary of each variable in the data set (which information is displayed depends on the data type of the variable).

# Task 3: Accessing and subsetting columns
## hint: == checks for equality, | means logical OR

relevant_data <- characters[characters$uni_name == "Brooklyn Nine-Nine" | characters$uni_name == "Community", ]

## remember that in [] before the comma, we specify the rows. This code tells R to select all rows in which uni_name is either "Brooklyn Nine-Nine" or "Community". We use the logical OR (|) to include both, Brooklyn Nine-Nine and Community characters in our subset. By assigning the subset to a new object, our original data set remains unchanged and we get a new data set that we can work with from now on.

table(relevant_data$uni_name) # we can use this function to check how many characters from each show there are in our subset


# Task 4: Basic summary functions

mean(relevant_data$notability)  # returns the mean of the values in the column "notability"
sd(relevant_data$notability)    # returns the standard deviation of the values in the column "notability"

mean(relevant_data[relevant_data$uni_name == "Brooklyn Nine-Nine", "notability"])  # returns the mean of all observations in column 5 (notability; can be checked using names()) that have the value "Brooklin Nine-Nine" in the uni_name column.

mean(relevant_data[relevant_data$uni_name == "Community", "notability"]) # same for Community characters

# Task 5: Histograms
par(mfrow = c(1,2)) # this makes the two subsequent histograms show up next to each other for easier comparison (def. keep this as hint in the scaffolded version)
hist(relevant_data[relevant_data$uni_name == "Brooklyn Nine-Nine", "notability"])
hist(relevant_data[relevant_data$uni_name == "Community", "notability"])




