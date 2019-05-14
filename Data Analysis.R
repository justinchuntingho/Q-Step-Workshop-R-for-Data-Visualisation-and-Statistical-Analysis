####################################################################################
##                              4.Data Analysis                                  ##
####################################################################################
# R Basics ---------------------------------------------------------------------
snp <- read.csv("snp.csv")
summary(snp)
search() # shows what is in the current R environment.
names(snp) # names variables in the data frame.
attach(snp) # attach the dataset to the R environment. once you have attached the data in the environment, you can just use variables
            # within your data frame like any other R objects - just calling them by their name. Before attaching the data, you needed 
            # to type snp$name. However, if you are working with several data frames with the same variables names, attach may cause 
            # you a lot of problems.
str(snp) # overview of the data frame
summary(snp) # for factors R presents the number of apparences for each level.
             # for numerics R presents the minimum, 1st quantile, median, mean, 3rd quartile and maximum. 
head(snp) # top six rows of the data.
tail(snp) # bottom six rows of the data.
detach(snp) # detach the data frame.
rm(list = ls()) # remove all objects from environment.
# Stats Basics ---------------------------------------------------------------------
# mean
sum(snp$likes_count_fb)/length(snp$likes_count_fb)
mean(snp$likes_count_fb)
# median
length(snp$likes_count_fb)/2
sort(snp$likes_count_fb)[XX]
median(snp$likes_count_fb)
# mode
mode(snp$likes_count_fb) # returns a description of the "type" of a certain object.
hist(snp$likes_count_fb) # histogram for variable.
par(mfrow = c(1,3)) # presents the graphs 1 row and 3 columns.
hist(snp$likes_count_fb, breaks = 10) # the argument breaks sets the number of bins.
hist(snp$likes_count_fb, breaks = 20)
hist(snp$likes_count_fb, breaks = 40)
# variance and standard deviation
var(snp$likes_count_fb)
sd(snp$likes_count_fb)
# z tranformation 
ztand_likes_count_fb <- scale(snp$likes_count_fb)
head(stand_likes_count_fb)
snp$ztand_likes_count_fb <- scale(snp$likes_count_fb) # include the standardised values in your data frame
hist(snp$ztand_likes_count_fb)
# summary function
summary(snp$likes_count_fb)
# tables
# LMs ---------------------------------------------------------------------
# t-test:
## one-sample t-test
## two-sample t-test

# regression 
ols1 <- lm(likes_count_fb ~ type, data = snp)
summary(ols1)
ols2 <- lm(likes_count_fb ~ type + sentiment, data = snp)
summary(ols2)
# comparing the models
install.packages("stargazer")
library(stargazer)
stargazer(ols1, ols2,
          title = "Regression on number of likes on Facebook by type and sentiment",
          dep.var.labels=c("Number of likes on Facebook"),
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
