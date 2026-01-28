################### SESSION 1 #######################

# Task 1: Assignments and Objects

## hint: to run code from an R script, put your cursor anywhere in the line of code you want to execute and press Ctrl + Enter (Windows) / Cmd + Enter (Mac)

x <- 1
y <- 2

x+y

x <- 4
y <- 5

x+y

### when you assign a new value to an object that already exists, the previous contents of the object gets overwritten. Make sure to use object names that are descriptive and not currently used, so you don't get confused with what is stored in them.


# Task 2: Vectors, Lists, and Data Frames

age <- c(19, 20, 21, 23, 21)
name <- c("Tim", "Tom", "Anna", "Lisa", "Sasha")
food_pref <- c("vegan", "omnivore", "vegetarian", "omnivore", "vegan")

people_data <- data.frame(name, age, food_pref)

# reminder: save your script often using Ctrl + S (Windows) or Cmd + S (Mac)

# Task 3a: Indexing Vectors

age[3]
name[3]
### vectors are one-dimensional objects. This means that you only have to specify the position of the element that you want to index has in the vector.

### if we want to access multiple elements of the same vector we have to define a new vector containing the individual positions inside the [] like this:
age[c(3,5)]


# Task 3b: Indexing Data Frames

people_data[ ,2] # returns the second column
people_data[2, ] # returns the second row
### since data frames are two-dimensional objects, we need to specify which row(s) AND which column(s) we want to index. When we leave the position of either row (before the comma) or column (after the comma) blank, all rows/columns are selected as demonstrated above.

### we can access individual cells of a data frame by specifying both its row wise and column wise position like this:

people_data[3, 1] # returns the value in the third row of the first column

### if we want to select the values of multiple rows in the first column, we have to specify a vector inside the [] (same as for vectors):

people_data[c(2,3), 1]  # returns the values of the second and third row of the first column

### instead of using [], we can also use $ to select columns like this:
people_data$age # returns the same output as
people_data[ ,2]
## we can also use the column name to index columns from a data frame like this:
people_data[ , "age"]


### we can combine [] and $ to select rows conditional on their value in a certain column like this:
people_data[people_data$food_pref == "vegan", "name"] # returns the names of the vegans in our data frame


#################### SESSION 2 (1st half) #####################

# Task 1: Functions
numbers <- c(4.4, 14, 5.26, 26)

sum(numbers)  # returns the sum of all elements in the vector "numbers"
mean(numbers) # returns the mean of all elements in the vector "numbers"
sd(numbers)   # returns the standard deviation of all elements in the vector "numbers"

my_number <- 2.4637

exp(my_number)  # returns the number e to the power of "my_number"
round(my_number)# returns the rounded value of "my_number"

# Task 2: Help Function
?round

### round(my_number) returned "my_number" rounded to an integer. If we want it rounded to e.g., 2 decimals, we can achieve that by specifying the argument "digits =".

round(my_number, digits = 2)  # returns "my_number" rounded to two decimals
round(my_number, digits = 3)  # returns "my_number" rounded to three decimals

### we can also apply the function to our numeric vector "numbers" created above:
round(numbers)  # returns every element of the vector rounded to an integer (as we've seen in the help function, the argument "digits =" defaults to 0 if not specified.)
round(numbers, digits = 1)  # returns very element of the vector rounded to one decimal

# Task 3: Packages
install.packages("haven") # you only need to do this once and after updating R
library(haven)            # you need to load the package like this every time you restart R. Therefore, it makes sense to have the code for loading all packages needed in a script at the top of the script, so you can easily execute them each time you reopen/restart R.

