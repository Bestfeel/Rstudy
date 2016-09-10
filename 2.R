getwd()
#常用的绘图
install.packages("lattics")
install.packages("ggplot2")
#  返回所以可用颜色的名称
colors()

x1 <- matrix(c(1,2,3,4,5,6,7,8),nrow = 2,ncol = 4)
x1
x1[1,]
x1[,1]

x <- data.frame("a"=c(1:10),"b"=c(12,4,6,2,5,10,4,6,3,2))
x
y <- data.frame("a"=c(1:10),"b"=c(1,5,6,2,10,10,4,6,4,2))
plot(x$a,x$b,xlab="x",ann=FALSE,ylab="b",main='line',type='b',pch=15,col.axis='blue',col.lab='green',col.main='red',col='red',lty=2)

opar <- par(no.readonly = TRUE)
lines(y$a,y$b,pch=20,col='blue',type="b")

#次要刻度线 包
install.packages("Hmisc")
require("Hmisc")

minor.tick(nx=5,ny=4,tick.ratio = 0.5)
abline(h=5,col='blue')

library('car')
par(mfrow=c(2,2))
attach(mtcars)

plot(wt,mpg,main="wt vs mpg")
plot(wt,disp ,main="wt vs disp")


par(mfrow=c(2,1))

hist(wt,col="red")

attach(mtcars)

#  1,1,2,3 代表的 1  表示第一图形，2 表示第二图形
layout(matrix(c(1,1,2,3),2,2,byrow=TRUE),widths=c(3,1),heights=c(1,2))
hist(wt)
hist(mpg)
hist(disp)


par(fig=c(0,0.8,0,0.8),new=TRUE)

hist(wt)
hist(mpg)
hist(disp)


install.packages ("reshape")

require("reshape")

install.packages("sqldf")


attach(mtcars)

head(mtcars)

#  使用 sqldf 操作数据框
require("sqldf")

d <- sqldf("select mpg,wt,vs  from mtcars  limit  5 ")
d



a <- rnorm(50,mean=30,sd=10)


for(i in 1:10)   print("hello world!")

i <- 10
while(i>0){
  print(i)
  i <- i-1
}


