#### Introduction to R #######

#### ---------------------------- Working directory --------------------------
# Get your current working directory
getwd()
# Set your working directory manually
setwd("/Users/sun/Desktop/BIS 456")


#### ---------------------------- R: The Basics ------------------------------

# Commands
# Commands are separated by a line break
# As shown above, the '#' is used as a comment or notes

# Basic Operations:
# RStudio can be used as a calculator using both numbers and named variables

3 * 4

x <- 3 * 4

print(x)

# Case Sensitivity
A <- 2
a

a <- 3
a

# To confirm, A and a are not the same (not equal):
A == a

# Addition
1+1
1+a
a+A


# Subtraction
10-1
10-A
A-a

# Multiplication
2*3
A*2
7*a
a*A

# Division (forward slash: /)
3/2
16/A
A/a

# Exponent
# We can either use '^' or '**' to denote an exponent
3^a
3**a

### Remove an Assignment
## Overwrite the variable
t1 <- NULL
t1
t1 <- 'help'

t1
ls()
## Use the rm() function
?rm
rm(a)

### Clearing the Global Environment (also called the Workspace)
rm(list=ls())


#### ---------------------------- Built-in functions ---------------------------

## We can use '?' or 'help()' to obtain help for a function
# The help information will be displayed in the 'Help' panel
?print
help(print)

## We can use example() to see an example of a functions use
example(print)

#### ---------------------------- Vector ---------------------------------------

# A vector is a sequence of values, all of the same type!
# Vectors are generally created by the c() function.
my_numbers <- c(1,2,3,1,3,5,25)
my_numbers
c(1,2,3,1,3,5,25)
# my_numbers <- c(1,2,3,1,3,5,25)
your_numbers <- c(5,31,71,1,3,21,6)
my_numbers
print(my_numbers)

x <- c(2,4,6,8,10,6,7,8,9)
# To get the mean/average of x, use the mean() function
?mean()

#help(mean)
mean(x)
mean(my_numbers)
seq(1,11)
y <- seq(1,10)
y
# Access element from a vector:
x
x[3]
# Display the first 4 elements 
x[1:4]
# colon operator ":" gets a sequence of numbers from... to...

# Display the first and the third element 
x[c(1, 3)]
x[c(1, 3, 4)]
x
# Negative index:
x[-1]
y <- x[c(-1, -3)]
y
## Numbers in R:
# NAN (not a number)
# NA (missing value)
x <- c(1,  2,  3 , 4  ,5 , 6 , 7 , 8,  NA)
x <- c(1,  2,  3 , 4  ,5 , 6 , 7 , 8,  NULL)
mean(x)
?mean()
mean(x, na.rm = TRUE)

# Example:
my_numbers <- c(1,2,3,1,3,5,25)
sd(my_numbers) # standard deviation
my_numbers
my_numbers * 5
my_numbers + 1
my_numbers + my_numbers


#### ---------------------------- Packages -----------------------------------
### install.packages() or "Packages" command on the right side

install.packages(c("tidyverse","readxl","openxlsx"))
library(tidyverse)
library(readxl)
library(openxlsx)
#### ----------------------------  %>% operator in R -------------------------

# The point of the pipe is to help you write code in a way that easier to read and understand. 
# To see why the pipe is so useful, we’re going to explore a number of ways of writing the same code. 

# the pipe operator: %>% operator
# to use it, we need to install tidyverse Package


## task 1: create a vector of 1 to 8
#then find the sum of it
#then square root of the sum we got in step 2:
x <- seq(1,8) # This part of the code generates a sequence of numbers from 1 to 8 (inclusive). 
x # So, it creates the vector c(1, 2, 3, 4, 5, 6, 7, 8).
y <- sum(x)
y
sqrt(y)
## or we can do:
sqrt(sum(seq(1,8)))
## or we can do:
seq(1,8) %>% 
  sum() %>%  # After creating the sequence of numbers, it pipes this sequence into the sum() function using %>%.  In this case, it will sum up the numbers from 1 to 8, which is 36.
  sqrt() # Finally, the result of the sum() operation (which is 36) is piped into the sqrt() function. The sqrt() function calculates the square root of a number. 


z <- seq(1,8) %>% 
  sum() %>% 
  sqrt()

z
#### ---------------------------- Load data into R ---------------------------

setwd("/Users/sun/Desktop/BUAN 244 VIZ/Week 2")

#### -----------------------Importing/reading Excel file --------------------

BLS_Data_File <- read_excel("BLS Data Set 2009-2019 8-30-23.xlsx")
# file.choose()
mydata.df <-  read_excel(file.choose())


#### ---------------------------- Dataframe -----------------------------------
# A dataframe has columns and rows 

# Access elements/rows/variables from a dataframe
# Show the first row:
BLS_Data_File[1, ]
# Show the second column:
BLS_Data_File[ , 2]

BLS_Data_File$Year

# Show the data record from the 2nd row and the 3rd column
BLS_Data_File[2, 3]
# Show the first 4 rows 
BLS_Data_File[1:4,]
# Display the column 2 to column 5
BLS_Data_File[ , 2:5]
# Display the column 1, column 2, and column 5
BLS_Data_File[ , c(1,2,5)]


#### ---------------------------- Data Inspection ---------------------------

# Use the View function to display the data in a viewer window
# The view function is useful to ensure the data was imported correcty and using the sort functions outliers may be located

View(BLS_Data_File)
# summary(x) function returns  summary statistics of a dataset

summary(BLS_Data_File)

# More ways to exploring the dataset:

head(BLS_Data_File)
names(BLS_Data_File)

# select a subset of variables: 

BLS_Data_File <- select(BLS_Data_File,c("Year","Month" ,"Civilian_Labor_Force_Level_000s" ,"Average_Weekly_Hours_All_Employee_hrs"   ,"Avg_Hourly_Earnings_All_Employees","CPI_for_All_Urban_Consumers_Index"))

# Add in Calculation for Average Weekly Wage ($) 

BLS_Data_File <- BLS_Data_File %>%
  mutate(Avg_Wkly_Wage = Average_Weekly_Hours_All_Employee_hrs * Avg_Hourly_Earnings_All_Employees)

BLS_Data_File

####--------------- Begin Describe command to Evaluate The Central Tendancy Measures

## calculates the mean (average) of the "Avg_Wkly_Wage" column within each group (i.e., for each unique year)
year_avg_Wage <- BLS_Data_File %>% # This line creates a new object called year_avg_Wage
  group_by(Year) %>% # This line groups the data by the "Year" column. 
  summarise(Avg_Wkly_Wage = mean(Avg_Wkly_Wage, na.rm = TRUE))  # This line calculates the mean (average) of the "Avg_Wkly_Wage" column within each group (i.e., for each unique year) while removing any missing values (NA) from the calculation.
year_avg_Wage

## calculates the median of the "Avg_Wkly_Wage" column within each group (i.e., for each unique year)
year_median_Wage <- BLS_Data_File %>%
  group_by(Year) %>%
  summarise(Avg_Wkly_Wage = median(Avg_Wkly_Wage, na.rm = TRUE)) 
year_median_Wage

## calculates the standard deviation of the "Avg_Wkly_Wage" column within each group (i.e., for each unique year)
year_sd_Wage <- BLS_Data_File %>%
  group_by(Year) %>%
  summarise(Avg_Wkly_Wage = sd(Avg_Wkly_Wage, na.rm = TRUE)) 
year_sd_Wage

# calculates the mean (average) of the "Avg_Wkly_Wage" column by year and month

Weekly_Wage_Crosstab_2 <- BLS_Data_File %>%
  group_by(Year, Month) %>%
  summarise(Avg_Wkly_Wage = mean(Avg_Wkly_Wage, na.rm = TRUE)) 


Weekly_Wage_Crosstab_2

#spread(data, key, value, fill = NA, convert = FALSE, drop = TRUE, sep = NULL)
#data: A data frame.
#key, value: Columns to use for key and value.

Weekly_Wage_Crosstab_3 <- BLS_Data_File %>%
  group_by(Year, Month) %>%
  summarise(Avg_Wkly_Wage = mean(Avg_Wkly_Wage, na.rm = TRUE))%>%
  spread(Month, Avg_Wkly_Wage)


Weekly_Wage_Crosstab_3

# summarise only numerical columns 
mean_table<- BLS_Data_File %>%
  group_by(Year) %>%
  summarize_if(is.numeric, mean)

mean_table

median_table<- BLS_Data_File %>%
  group_by(Year) %>%
  summarize_if(is.numeric, median)

median_table

sd_table<- BLS_Data_File %>%
  group_by(Year) %>%
  summarize_if(is.numeric, sd)

sd_table

# write.xlsx: Write a data.frame to an Excel workbook
write.xlsx(mean_table, "mean_table.xlsx")
write.xlsx(median_table, "median_table.xlsx")
write.xlsx(sd_table, "sd_table.xlsx")


# Construct a boxplot for Avg_Wkly_Wage
boxplot(BLS_Data_File$Avg_Wkly_Wage, main = 'boxplots for Avg_Wkly_Wage',ylab = 'Avg_Wkly_Wage', col = 'gold')

# Next week we will be working on Exploratory Analysis


