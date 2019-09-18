my_data <- read.csv("Merged Factors and Beta Portfolios.csv")
                 
Mkt_pre <- my_data$Mkt.RF
port1 <- my_data$Lo.10
reg1 <- lm(port1 ~ Mkt_pre -1, data = my_data)
a<-summary(reg1)

for (i in 6:15){
  x<-vector(length = 10)
  x<-summary(lm(my_data[,i] ~ Mkt_pre -1, data = my_data))$coefficients[1]
  print(as.vector(x))
}

# Question 2
data1 <- read.csv("msft fin.csv")
data2 <- read.csv("gm fin.csv")
data3 <- read.csv("ko fin.csv")

x1 <- data1$Mkt.RF
x2 <- data2$Mkt.RF
x3 <- data3$Mkt.RF
y1 <- data1$ret_MSFT...RF
y2 <- data2$ret_GM...RF
y3 <- data3$ret_ym...RF

# regular standard errors
reg1 <- lm(y1 ~ x1, data = data1)
summary(reg1) 

reg2 <- lm(y2 ~ x2, data = data1)
summary(reg2)

reg3 <- lm(y3 ~ x3, data = data1)
summary(reg3) 

# Allow for Heteroskedascity ii

install.packages("sandwich")
install.packages("lmtest")

library(sandwich)
library(lmtest)

reg1WE <- lm(y1 ~ x1, data = data1)
vcv1 <- vcovHC(reg1WE, type = "HC1")
coeftest(reg1WE, vcv)

reg2WE <- lm(y2 ~ x2, data = data1)
vcv2 <- vcovHC(reg2WE, type = "HC1")
coeftest(reg2WE, vcv2)

reg3WE <- lm(y3 ~ x3, data = data1)
vcv3 <- vcovHC(reg3WE, type = "HC1")
coeftest(reg3WE, vcv3)

# Allow for Serial Correlation iii

reg1NW <- lm(y1 ~ x1, data = data1)
NeweyWest(reg1NW, lag = 6, prewhite = FALSE)
coeftest(reg1NW, NeweyWest(reg1NW, lag = 6, prewhite = FALSE))

reg2NW <- lm(y2 ~ x2, data = data1)
NeweyWest(reg2NW, lag = 6, prewhite = FALSE)
coeftest(reg2NW, NeweyWest(reg2NW, lag = 6, prewhite = FALSE))

reg3NW <- lm(y3 ~ x3, data = data1)
NeweyWest(reg3NW, lag = 6, prewhite = FALSE)
coeftest(reg3NW, NeweyWest(reg3NW, lag = 6, prewhite = FALSE))






