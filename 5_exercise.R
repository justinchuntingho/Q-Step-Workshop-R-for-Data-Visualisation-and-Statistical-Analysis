###################################################################################################
#                                     Exercise                                                   #
###################################################################################################
# In this exercise we will be using the hb2 dataset.
# This dataset holds data from a fictional study on 200 high schools students in the United States. 
# Data on students’ test scores in science, math, reading, writing and social studies were collected. 
# In addition, information was gathered on the school type and high school program type as well as 
# students’ gender, race and socioeconomic status.
####################################################################################################
# You will have to create a R-Project for the exercise.
# Download the data set and save it in the project's directory
################################################################################################### 
# Explore the data set using the functions:
# names()
# summary()
# head()
################################################################################################### 
# (1) Is there an association between race and socio-economic status?
# a.Explore the variables "race" and "ses" 
# b.Produce a table (with percentages). The dependent variable is socioeconomic status and the 
# independent variable is race. Use the convention to define where the total percentage is.
# c.Run a chi-square to see if the association is statiscally significant. You can use the package 
# "gmodels" to calculate the expected values if there was no relatioship between the variables.     

# (2) Is there a difference in math scores between those in public and private school?
# a. The dependent variable will be the student’s math scores (math) and the independent variable will 
# be their school type (schtyp). Explore the variables.
# b. Produce a histogram for the dependent variable and put a normal curve on it, to check that the 
# variable is *relatively* normally distributed. You can use ggplot2 or the core code to produce 
# the graph.
# c. Perform a t-test to compare the mean math score between public and private school.

# (3) Is there a relationship between students’ reading and writing scores?
# a. Produce a scatter plot of the relationship between students' writing and reading scores (You can
# include the ‘best’ line through the data points)
# b. Fit the regression model. In this exercise, the dependent variable is students’ writing score (“write”) 
# and the independent variable is students’ reading score (“read”).
# c. Check your residuals. Use the function plot().

# (4) Is there an association between students' math scores and their socio-economic background controlling by gender?
# a. Fit a regression model to explore the relationships between students' math scores and their gender and 
# socio-economic status (ses). Note that ses is a 3-categories variable which needs to be recoded into dummies 
# (use "low" as the reference category, 0)
