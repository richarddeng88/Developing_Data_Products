library(ISLR); library(MASS); bos<- Boston
x <- bos[,-1]
y <- bos[,1]
library(Qing)
a <- topten(x,y)
a$coef
a$names

