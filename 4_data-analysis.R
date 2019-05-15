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
### variance and standard deviation
var(snp$comments_count_fb)
sd(snp$comments_count_fb)
### quantile
quantile(snp$comments_count_fb)
### summary function
summary(snp$comments_count_fb)
### z tranformation 
zstand_comments_count_fb <- scale(snp$comments_count_fb)
head(zstand_comments_count_fb)
snp$zstand_comments_count_fb <- scale(snp$comments_count_fb) # include the standardised values in your data frame
hist(snp$zstand_comments_count_fb)
### tables
table1 <- table(snp$type, snp$sentiment) # type will be rows, sentiment will be columns 
table1 # print table 
# proportion
prop.table(table1) # cell percentages
prop.table(table1, 1) # row percentages 
prop.table(table1, 2) # column percentages
# percentage
100*prop.table(table1,1)
100*prop.table(table1,2)
# rounding by 2 decimal places
round(100*prop.table(table1,1),2)
round(100*prop.table(table1,2),2)
# LMs ---------------------------------------------------------------------
# T-TEST: 
# the function for both one- and two-sample t test is t.test.
### one-sample t-test: we just need to specify the variable of interest and then we need to specify the baseline for comparison.
                    # let's pretend that 150 is the mean number of post comments on Facebook for all the political parties in the UK. 
                    # we want to test if the mean number of post comments on Facebook on the SNP page is the different for the mean for 
                    # all political parities in the UK.
                    # H0: SNP has the same mean number of post comments on Facebook as the population mean (other political parties).
                    # H1: SNP has differnt mean number of post comments on Facebook.
t.test(snp$comments_count_fb, mu = 150) # p < 0.05: we can reject the null hypothesis.
### two-sample t-test: we want to compare the difference in the mean of two different groups.
# let's compare the mean comments on a post with link vs photo and video
# first, we will need to recode the variable for sentiment into a dummy for link (link = 1, video & photo = 0)
summary(snp$type)
library(plyr)
snp$link <- revalue(snp$type, c("link"= 1, "video"=0, "photo"=0))
summary(snp$link)
ttest <- t.test(snp$comments_count_fb ~ snp$link)
ttest

# ANOVA
# used to compare the difference between three or more groups. It tells if there is a significant difference, but we are not sure 
# which specific groups are different from each other. We can see if there is a different in the number of likes by type of post using
# anova:
anova <- aov(snp$likes_count_fb ~ snp$type)
summary(anova)
# ANOVA = LM, for that reason, people don't use ANOVA anymore.

# REGRESSION:
# let's perform a regression of number of comments on Facebook post by share counts and sentiment. 

# DEPENDENT VARIABLE
# first, let's check the distribution of the dependent variable (you can also try to write the ggplot command):
hist(snp$comments_count_fb) # the variable is not normally distributed.
                            # logarithm transformation is often used for right skewed data (mean > median).
                            # because our variable includes 0, I will exclude those cases to avoid problems (there are more complex 
                            # and better ways to deal with this problem, but this is beyond the purpose of this workshop.)
snp_lm <- snp[which(snp$comments_count_fb !=0),] # creating a new data frame with no 0 values for the dependent variable.
                                                 # we will use this data frame to run the regression analysis.
# you can save the transformed variable in your data frame:
snp_lm$comments_count_fb2 <- log10(snp_lm$comments_count_fb)             
# or you can simply include the log10 transformation when you are analysis the variable, for example:
library(ggplot2)
ggplot(snp_lm, aes(x=log10(comments_count_fb)))+
  geom_histogram()+
  theme_bw()

# INDEPENDENT VARIABLES
# number of shares
summary(snp_lm$shares_count_fb) # the variable also includes 0 values
snp_lm <- snp_lm[which(snp_lm$shares_count_fb !=0),] # sample size drops from 1732 to 1556.
hist(snp_lm$shares_count_fb) # checking the distribution for the independent variable
hist(log10(snp_lm$shares_count_fb)) # checking the transformation for the independent variable
# sentiment
summary(snp_lm$sentiment) # because the variable is a factor, R will automatically create dummies when you run the regression.
                          # I usually create dummies (it is easier to change reference group, combine categories, etc.) using the 
                          # plyr package.
snp$negative <- revalue(snp$sentiment, c("negative"= 1, "neutral"=0, "positive"=0))
snp$neutral <- revalue(snp$sentiment, c("negative"= 0, "neutral"=1, "positive"=0))
snp$positive <- revalue(snp$sentiment, c("negative"= 0, "neutral"=0, "positive"=1))
table(snp$negative,snp$sentiment) # checking the recoding is correct
table(snp$neutral,snp$sentiment)
table(snp$positive,snp$sentiment)

#### MODEL 1:
# scatter plot with the regression line using ggplot2
library(ggplot2)
ggplot(snp_lm, aes(x=log10(shares_count_fb), y=log10(comments_count_fb)))+
  geom_point()+
  geom_smooth(method='lm', se = FALSE) +
  theme_bw()
# regression model
lm1 <- lm(log10(likes_count_fb) ~ log10(comments_count_fb), data = snp_lm)
summary(lm1)
# checking the residuals
plot(lm1)

# if you are interest in using R to perform robust regression, you can check the step by step on the UCLA website:
# https://stats.idre.ucla.edu/r/dae/robust-regression/
# you can also use ggplot2 to visualise your residuals: https://www.r-bloggers.com/visualising-residuals/

#### MODEL 2:
lm2 <- lm(log10(likes_count_fb) ~ log10(comments_count_fb) + neutral + positive, data = snp_lm)
summary(lm2)

# presenting the two models.
install.packages("stargazer")
library(stargazer)
stargazer(lm1, lm2,
          title = "Regression on number of likes on Facebook by comments and sentiment",
          dep.var.labels=c("Log 10 of number of likes on Facebook"),
          covariate.labels=c("log 10 of number of comments","neutral", "positive", "constant"),
          align = TRUE, type = "text", out = "ols_likes_fb.txt")

# GLMs ---------------------------------------------------------------------
# X-SQUARE TEST: 
# difference between the observed cell values and the expected cell values.
table1 <- table(snp$type, snp$sentiment) # table between the two categorical variables in the data frame.
table1
x_square <- chisq.test(table1)
x_square
# you can use the package "gmodels" to calculate the expected values if there was no relatioship between the variables.
install.packages("gmodels")
library(gmodels)
# check the documentation for command CrossTable
?CrossTable
CrossTable(table1, expected = TRUE, prop.r = FALSE, prop.c = FALSE,
           prop.t = FALSE, prop.chisq = FALSE)

# LOGISTIC REGRESSION
glm1 <- glm(XXX ~ log10(comments_count_fb), family=link('logit'))

#predicted values
#plot


