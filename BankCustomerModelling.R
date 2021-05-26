#access directory
setwd("D:/George Mason University/Semester 2/Analytics Big Data to Information/Data Analytics Research Project/Dataset")
getwd()

#bank <- read.csv("bank.csv", sep=";", header=TRUE, stringsAsFactors=FALSE)
bank <- read.csv("bank_customer.csv", sep=",", header=TRUE, stringsAsFactors=FALSE)
head(bank)
names(bank)
dim(bank)
summary(bank)

#visualization
maritalCount <- table(bank$marital)
text(barplot(maritalCount, main="Customers Marital Status", xlab="Type of Marital Status"), 3, labels=maritalCount)
educationCount <- table(bank$education)
text(barplot(educationCount, main="Customers Education Level", xlab="Type of Education Level"), 4, labels=educationCount)
ageSum <- summary(bank$age)
boxplot(bank$age, main="Customers Age Summary")

# Use GGally::ggscatmat() to get a matrix of scatterplots and correlations
library(tidyverse)
library(GGally)
ggscatmat(select(bank, -y)) + labs(title = "scatterplots and correlations of customer detail")

# Use ggplot to plot pdays vs previous
ggplot(bank,aes(x=pdays ,y=previous)) + geom_point() + labs(title = "correlations of customer detail between previous and pdyas")

#------------------------------------------------------------------------------
# 2. Use all the data to both develop the model and determine classification
#    success
# Develop a logistic regression model for each customer positive or negative response.
glm.fit=glm(y~.,data=bank,family=binomial)
summary(glm.fit)

# coef() extracts the beta coefficients from the object created by lm()
coef(glm.fit)

# Can also subset the object created by summary().
# For each coefficient: row name, estimate, standard err, z-value, p-value:
summary(glm.fit)$coef

# Just the p-values:
summary(glm.fit)$coef[,4]

# Compute probabilites for all the cases used to develop the model
glm.probs=predict(glm.fit,type="response")
glm.probs[1:10]

# Need to detemine if computed probablities are for y="yes"
# or for y="no"
contrasts(as.factor(bank$y))

# Create a vector of predictions for response, initialized to "0" as no
glm.pred=rep(0, 45211)

# Change prediction to "yes" if model probability>0.5
glm.pred[glm.probs>.5] <- 1

# Display confusion matrix
table(glm.pred, bank$y)

# Compute proportion of predictions that are correct
# true positive : 3456
# false positive : 38940
# total row : 45211
(1833+38940)/45211

#------------------------------------------------------------------------------
# 3. redo the modelling by seperating the dataset into train and test dataset
#

#Divide the data in training and test sets
set.seed(1)
train = sample(1:nrow(bank),0.7*nrow(bank))
bankTest = bank$y[-train]

length(train)
length(bankTest)

#assigning train dataset 
bankDataTrain = bank[train, ]
head(bankDataTrain)
dim(bankDataTrain)

#assigning test dataset
bankDataTest = bank[-train, ]
head(bankDataTest)
dim(bankDataTest)

#The training set has 31647 observations and test set has 13564 observations.
# Develop the lostistic regression model with train dataset
glm.fit=glm(y~., data=bankDataTrain, family=binomial)
summary(glm.fit)

# Use the model to compute response probabilities for bankDataTest
glm.probs=predict(glm.fit, bankDataTest, type="response")

# Initalize bankDataTest prediction to "0" which means no
glm.pred=rep(0, 13564)

# Change prediction to "1" which means "yes" if probabability > 0.5
glm.pred[glm.probs>.5]=1

# Display confusion matrix
table(glm.pred, bankDataTest$y)

# Calculate proportion of correct and incorrect predictions 
# true positive : 540
# false positive : 11692
# false negative : 297
# true negative : 1035

#proportion of correct prediction
(540 + 11692)/13564
mean(glm.pred==bankDataTest$y)

#proportion of incorrect prediction
(297 + 1035)/13564
mean(glm.pred!=bankDataTest$y)