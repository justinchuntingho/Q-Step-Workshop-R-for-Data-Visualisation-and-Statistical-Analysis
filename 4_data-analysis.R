####################################################################################
##                              4.Data Analysis                                  ##
####################################################################################
# R Basics ---------------------------------------------------------------------
snp <- read.csv("/Users/adiaslo/Downloads/Q-Step-Workshop-R-for-Data-Visualisation-and-Statistical-Analysis-master/snp.csv")
names(snp) # names variables in the data frame.
search() # shows what is in the current R environment.
attach(snp) # attach the dataset to the R environment. once you have attached the data in the environment, you can just use variables
            # within your data frame like any other R objects - just calling them by their name. Before attaching the data, you needed 
            # to type snp$name. However, if you are working with several data frames with the same variables names, attach may cause 
            # you a lot of problems.
search() # you will see that the data frame will be in your R environment.      
str(snp) # overview of the data frame
summary(snp) # for factors R presents the number of apparences for each level.
             # for numerics R presents the minimum, 1st quantile, median, mean, 3rd quartile and maximum. 
head(snp) # top six rows of the data.
tail(snp) # bottom six rows of the data.
detach(snp) # detach the data frame.
# rm(list = ls()) # remove all objects from environment.
# Stats Basics ---------------------------------------------------------------------
### mean
sum(snp$comments_count_fb)/length(snp$comments_count_fb) # caculate the sum of the variable and dived it by the length.
mean(snp$comments_count_fb)
### median
length(snp$comments_count_fb)/2 # calculate the length of the variable and dived by two.
sort(snp$comments_count_fb)[866] # sort the variable for comments count on Facebook and returns the 866 value.
median(snp$comments_count_fb)
### mode
mode(snp$comments_count_fb) # this command will not give you the mode!
                            # returns a description of the "type" of a certain object.
# estimating the mode for a continuos variable is not impossible, but quite technical. there is a quite an easy way to
# get approximate mode. let's draw a histogram for the variable number of likes on Facebook. we will use the base R 
# code to draw the graph, but you can easily do it using ggplot2.
# there is a really cool discussion online about when to use R base code to draw graphs:
# Why I don't use ggplot2, Professor Jeff Leek: https://simplystatistics.org/2016/02/11/why-i-dont-use-ggplot2/
# Why I use ggplot2, David Robinson (Data Camp): http://varianceexplained.org/r/why-I-use-ggplot2/
hist(snp$comments_count_fb) # histogram for variable.
par(mfrow = c(1,3)) # presents the graphs 1 row and 3 columns.
hist(snp$comments_count_fb, breaks = 10) # the argument breaks sets the number of bins.
hist(snp$comments_count_fb, breaks = 60)
hist(snp$comments_count_fb, breaks = 80)
par(mfrow = c(1,1)) # present the graph in 1 row and 1 columns (restoring the default)
# to calculate the mode, you can download the package "modeest"
install.packages("modeest")
library(modeest) # this package is tricky to use because there are many ways of estimating the mode.
library(help = "modeest") # open the documentation for the package. we want to calculate the most likely value 'mlv'
mlv(snp$comments_count_fb)
# variance and standard deviation
var(snp$comments_count_fb)
sd(snp$comments_count_fb)
# z tranformation 
zstand_comments_count_fb <- scale(snp$comments_count_fb)
head(zstand_comments_count_fb)
snp$zstand_comments_count_fb <- scale(snp$comments_count_fb) # include the standardised values in your data frame
hist(snp$zstand_comments_count_fb)
# summary function
summary(snp$comments_count_fb)
# tables
# LMs ---------------------------------------------------------------------
# T-TEST:
## one-sample t-test
## two-sample t-test

# REGRESSION:
# let's perform a regression of number of comments on Facebook post by sentiment. 
# H0: no association between the number of comments and sentiment.
# H1: association between the number of comments and sentiment. 
# I would aspect that post with higher number of comments have higher negative comments (hate > engagement). 
# DEPENDENT VARIABLE
# first, let's check the distribution of the dependent variable (you can also try to write the ggplot command):
hist(snp$comments_count_fb) # the variable is not normally distributed.
                            # logarithm transformation is often used for right skewed data (mean > median).
# you can save the transformed variable in your data frame:
snp$comments_count_fb_log10 <- log10(snp$comments_count_fb)
# or you can simply include the log10 transformation when you are analysis the variable, for example:
hist(log10(snp$comments_count_fb))
# INDEPENDENT VARIABLE
class(snp$sentiment) # checking the class for the independent variable.
summary(snp$sentiment)
# because the variable is a factor, R will automatically create dummies when you run the regression
# however, you can create dummies. 
# using the plyr package.
library(plyr)
snp$negative <- revalue(snp$sentiment, c("negative"= 1, "neutral"=0, "positive"=0))
snp$neutral <- revalue(snp$sentiment, c("negative"= 0, "neutral"=1, "positive"=0))
snp$positive <- revalue(snp$sentiment, c("negative"= 0, "neutral"=0, "positive"=1))
# checking the recoding is correct
table(snp$negative,snp$sentiment)
table(snp$neutral,snp$sentiment)
table(snp$positive,snp$sentiment)
# base R code (example how to create a dummy variable for negative sentiment. you can do the other dummies
# if you prefer using the base code.)
snp$negative[snp$sentiment == "negative"] <- 1
snp$negative[snp$sentiment != "negative"] <- 0
# MODEL 1: 
ols1 <- lm(log10(snp$comments_count_fb) ~ snp$positive + snp$neutral, data = snp)
summary(ols1)

ols1a <- lm(log10(comments_count_fb) ~ sentiment, data = snp)
summary(ols1)

ols2 <- lm(likes_count_fb ~ type + sentiment, data = snp)
summary(ols2)
# comparing the models
install.packages("stargazer")
library(stargazer)
stargazer(ols1, ols2,
          title = "Regression on number of comments on Facebook by type and sentiment",
          dep.var.labels=c("Number of comments on Facebook"),
          covariate.labels=c("type","sentiment","constant"),
          align = TRUE, type = "text", out = "ols_likes_fb.txt")
# regression and anova
# GLMs ---------------------------------------------------------------------
# binary data
# x-square test
# logistic regression







opar <- par(mfrow = c(2,2), oma = c(0, 0, 1.1, 0))
plot(ols)
par(opar)

snp[c(9, 25, 51), 1:2]

