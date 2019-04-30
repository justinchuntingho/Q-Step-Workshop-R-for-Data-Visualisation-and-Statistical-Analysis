# Introduction to R
# Last updated: 22 Nov 2018

####################################################################################
## Installing packages                                                            ##
####################################################################################
install.packages("ggplot2")
install.packages("dplyr")
install.packages("scales")
install.packages("lubridate")

####################################################################################
## Loading dataset into R                                                         ##
####################################################################################

# You can get output from R simply by typing math in the console.
# However, to do useful and interesting things, we need to assign values to
# objects. To create an object, we need to give it a name followed by the
# assignment operator `<-`.
# The following code will load a dataset into R's memory and stored an object named 'snp'.

snp <- read.csv("snp.csv", stringsAsFactors = FALSE) # Load the file 'snp.csv', put it as an object called 'snp'

# When assigning a value to an object, R does not print anything. 
# You can print the value by typing the object name:

snp

# However, print a large object directly is often not a good idea,
# as you can see, the output is simply too large to display in one page.
# Sometimes, you might even crash your R if the object is too large.
# To safely view a portion of an object, you could use the 'head()' function

## Functions:
# - Functions are "canned scripts"
# - Predefined, or can be made available by importing R *packages*
# - A function usually gets one or more inputs called *arguments*
# - Can return a single value, and also a set of things, or even a dataset 

## Arguments:
# - can be anything (numbers, filenames, objects etc)
# - must be looked up in the documentation
# - Some functions take on a *default* value

# The 'head()' function will return the first sixth element of an object:
head(snp)

# We could also look at the help for this function using `?head`
?head

# We see that if we want a different size for the result, we can add an argument:
head(snp, n = 10)

# If you provide the arguments in the exact same order as they are defined you
# don't have to name them:
head(snp, 10)

########## Exercise 1 ########## 
# Using the 'tail()' function, find out the date of the last post in the dataset.
##############################


####################################################################################
## Two Basic Data Types: Dataframes and Vectors                                   ##
####################################################################################
# To find out the data type of an object, we could use the 'class()' function:
class(snp)

# Dataframes are representations of data in table format (like an Excel spreadsheet)
# There are functions to extract this information from data frames.
# Here is a non-exhaustive list of some of these functions:
# 
# Size:
dim(snp) # returns number of rows, number of columns
nrow(snp) # returns the number of rows (post)
ncol(snp) # returns the number of columns (var)

# Summary:
str(snp) # structure of the object and information about the class, length and content of each column
summary(snp) # summary statistics for each column

# To extract a subset of the dataframe, we could use the slicing operater '[' and ']'
# Remember we have to specify the index for both the row and column:

snp[1,1] # First row, first column
snp[1,] # Frist row, all columns (leaving it empty means getting everything)
snp[,1] # Frist column, all row (leaving it empty means getting everything)
snp[1:6,] # The first six rows, this is same as the 'head()'

# Dataframes are comprised of vectors
# A vector is a series of values, can be either numbers or characters. 
# Vector can be assigned using the `c()` function, for example:

names <- c("Foo", "Bar", "Baz")
names

# You could also use the slicing operater to get a part of a vector:
# Remember this time you only have to specify the index (not row and column) 
names[1] # Get the first element
names[1:2] # From the first to the second
names[-1] # everything except the first

# Since dataframes are comprised of vectors, 
# We can extract the whole column as a vector using '$':
snp$date
snp$likes_count_fb

# We could use functions to gain information from the vector
# For example, 'mean()' will gives us the mean, 'max()' will give us the maximun value
length(snp$likes_count_fb)
max(snp$likes_count_fb)
mean(snp$likes_count_fb)
table(snp$type)

########## Exercise 2 ########## 
# Using the 'mean()' function, alter the codes below and calculate the mean value of 
# likes (likes_count_fb), comments (comments_count_fb), and shares (shares_count_fb).
# Put the result into the follow objects: 'mean_like', 'mean_comment', 'mean_share'

mean_like <- # Fill in your codes here #
mean_comment <- # Fill in your codes here #
# Fill in your codes here for 'mean_share' #
##############################

# For more advanced usage of functions, we could use 'which.max()' to identify the element that
# contains the maximum value
which.max(snp$likes_count_fb)

# The result is 676, meaning that the 676th post of the dataset has the most likes.
# We can then use the slicing operator ('[' and ']') to find the post:
snp[676, ]

# We can combine them into one single line:
snp[which.max(snp$likes_count_fb), ]

########## Exercise 3 ########## 
# Find out which post has most comments and shares

# Tricky Questions: Could you find out how to just extract the link?
# Tips: start with extracting all the links ('snp$post_link'),
# then use the index to select the one we want
 
##############################

####################################################################################
## Data visualisation with ggplot2                                                ##
####################################################################################
# We start by loading the required package.
# install.packages("ggplot2") # You only have to run it once
library(ggplot2)

# Building plots with **`ggplot2`** is typically an iterative process. 
# We start by defining the dataset we'll use:
ggplot(data = snp)

# lay out the axis(es), for example we can set up the axis for the Comments count ('comments_count_fb'):
ggplot(data = snp, aes(x = comments_count_fb))

# and finally choose a geom
ggplot(data = snp, aes(x = comments_count_fb)) +
  geom_histogram()

# We could change the binwidth by adding arguments
ggplot(data = snp, aes(x = comments_count_fb)) +
  geom_histogram(binwidth = 100)

# We could add a line showing the mean value by adding a geom
# We have done this earlier but I am doing it again just in case.
mean_like <- mean(snp$likes_count_fb)
mean_comment <- mean(snp$comments_count_fb)
mean_share <- mean(snp$shares_count_fb)

ggplot(data = snp, aes(x = comments_count_fb)) +
  geom_histogram(binwidth = 100) +
  geom_vline(xintercept=mean_comment, color = "red", linetype = "dashed")

# We could change color by adding arguments (fill means color of the filling in ggplot2)
ggplot(data = snp, aes(x = comments_count_fb, fill = "red")) +
  geom_histogram(binwidth = 100)

# How about making it transparent?
ggplot(data = snp, aes(x = comments_count_fb, fill = "red")) +
  geom_histogram(binwidth = 100, alpha = 0.8)

# We can easily coloring them by group by changing "red" to type 
# (the column that contain information about post type in the snp dataframe)
ggplot(data = snp, aes(x = comments_count_fb, fill = type)) +
  geom_histogram(binwidth = 100, alpha = 0.8)

########## Exercise 4 ########## 
# Using the codes above, create a histogram for Likes count ('likes_count_fb')

##############################


####################################################################################
## Visualising two categorical variables                                          ##
####################################################################################

# We could create a bar plot:
ggplot(snp, aes(x = type)) + 
  geom_bar()

# We could also create a plot for two categorical variables
# We color the bar by the sentiment of the posts
ggplot(snp, aes(x = type, y = ..count.., fill = sentiment)) + 
  geom_bar()

# We can change how these bars are placed, 
# for example 'position = "dodge"' will place them side by side
ggplot(snp, aes(x = type, y = ..count.., fill = sentiment)) + 
  geom_bar(position = "dodge")

# If we use 'position = "fill"', all bar will strech out to fill the whole y axis
# The y axis then become proportion
ggplot(snp, aes(x = type, y = ..count.., fill = sentiment)) + 
  geom_bar(position = "fill") +
  labs(y = "proportion")

####################################################################################
## Visualising two continuous variables                                           ##
####################################################################################

# Creating a plot for two continuous variables (comments and likes):
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb))

# We could use geom_point() for scatter plot
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb)) +
  geom_point()

# Again, you can add the mean values 
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb)) +
  geom_point() +
  geom_vline(xintercept = mean_comment) +
  geom_hline(yintercept = mean_like)

# You can even add the same geom twice, with different values on the x and y axes
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb)) +
  geom_point() +
  geom_point(aes(x = mean_comment, y = mean_like, color = "red", size = 6))

# Use the argument 'color = "red"' for red dots
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = "red")) +
  geom_point()

# Or coloring them by post type
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point() 

# There are many things you can do by adding layers into the ggplot
# You could log them.
# PS: You will see a warning message, don't worry, it is just because our data contain zeros
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) + # I made the points transparent for visiblity
  scale_x_log10() +
  scale_y_log10()


# Or fit a line
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE)

# And add labels and legend
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Comments Count", y = "Likes Count",
     title = "Comments and Likes",
     subtitle = "One post per dot",
     caption = "Source: Justin Ho")

# Change the theme by adding theme_bw()
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Comments Count", y = "Likes Count",
       title = "Comments and Likes",
       subtitle = "One post per dot",
       caption = "Source: Justin Ho") + 
  theme_bw()

# To save your graph, you could first define the graph as an object then use ggsave:
myplot <- ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Comments Count", y = "Likes Count",
       title = "Comments and Likes",
       subtitle = "One post per dot",
       caption = "Source: Justin Ho")
ggsave(myplot, filename = "my_plot.png")

# Facet to make small multiples
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ type)

########## Exercise 5 ########## 
# Make a scatter plot of shares by comments count, log both axes,
# color them by post type, change shape by post type (adding 'shape = sentiment ' in aes())
##############################


####################################################################################
## It's about time                                                                ##
####################################################################################
# We need this package
# install.packages("scales")
# install.packages("lubridate")
library(scales)
library(lubridate)

# To plot a time series, the first thing you have to do is to transform your data into time/date format
# There are many formats for time and date, but the simpliest way would probably be:

snp$date <- as.Date(snp$date) # Defining a new column called 'date'

# Simply plot the same scatter point, using 'date' as the x axis
ggplot(data = snp, aes(x = date, y = likes_count_fb)) +
  geom_point()

# Changing the x scale using scale_x_date()
ggplot(data = snp, aes(x = date, y = likes_count_fb)) +
  geom_point() +
  scale_x_date(labels = date_format("%m/%y"), date_breaks = "1 month")

# We could use line
ggplot(data = snp, aes(x = date, y = likes_count_fb, color = type)) +
  geom_line() +
  scale_x_date(labels = date_format("%m/%y"), date_breaks = "1 month")

# Or use geom_smooth to fit a local regression line
ggplot(data = snp, aes(x = date, y = likes_count_fb, color = type)) +
  geom_smooth(method = 'loess') +
  scale_x_date(labels = date_format("%m/%y"), date_breaks = "1 month")

# You could add two geoms on top of each other
ggplot(data = snp, aes(x = date, y = likes_count_fb, color = type)) +
  geom_smooth(method = 'loess') +
  geom_point(alpha = 0.3) +
  scale_x_date(labels = date_format("%m/%y"), date_breaks = "1 month")

# You could also truncate the y axis (use with caution!)
ggplot(data = snp, aes(x = date, y = likes_count_fb, color = type)) +
  geom_smooth(method = 'loess') +
  geom_point(alpha = 0.3) +
  scale_x_date(labels = date_format("%m/%y"), date_breaks = "1 month") +
  ylim(c(0, 2000))

####################################################################################
## Data Wrangling with dplyr                                                      ##
####################################################################################
# We need this package
# install.packages("dplyr")
library(dplyr)
library(lubridate)

# For some plots, it might be easier if you transform the data in advance
# To do so, we have to learn a few things:
# '%>%' is a pipping operator, it acts as a pipe line: 
# the output before the pipping operator will feed into the next function as the input

# We also need the following functions:
# group_by() is a function to split the data into groups
# summarise() is a function to make calculation and put the result into a new variable

snp %>% # Take 'snp', put into a pipe
  group_by(type, date=floor_date(date, "month")) %>% # split the data by post type and by month
  summarise(total_likes = sum(likes_count_fb)) -> # calculate total likes by taking the sum of likes count
  plot_data # assign to the new object 'plot_data'
  
# Have a look at the transformed data
ggplot(data = plot_data, aes(x = date, y = total_likes, color = type)) +
  geom_line()

# We could use a new geom, geom_area for area plots
# There are three positions, "stack" means stacking one on top of the other
ggplot(data = plot_data, aes(x = date, y = total_likes, fill = type)) +
  geom_area(position = "stack")

# "identity would overlap. You might want to make it transparent
ggplot(data = plot_data, aes(x = date, y = total_likes, fill = type)) +
  geom_area(position = "identity", alpha = 0.8)

# "fill" would calculate the proportion of the post type each day and fill the whole plot
ggplot(data = plot_data, aes(x = date, y = total_likes, fill = type)) +
  geom_area(position = "fill")

########## Exercise 6 ########## 
# Using the above codes, aggregate comment counts by month.
# Plot an area plot (selection a sensibile position)

# TIPS:
# plot_data <- snp %>% 
#   group_by(type, date=floor_date(date, "month")) %>%
#   summarise(###### = sum(#######))  # Change the ########### into the variable names
##############################


####################################################################################
## What's next?                                                                   ##
####################################################################################

# You won't be able to learn everything about R in three hours,
# but I hope this workshop would give you a head start in your progarmming journey.
# If you would like to learn more, there are plenty (free) resources online:
# https://www.tidyverse.org/
# http://www.cookbook-r.com/
# https://socviz.co/
