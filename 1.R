x=rnorm(10,10,5)
x
plot(x)
age <- c(1,3,4,5,6,7,8,9,10,12)
weight <- c(2,3,5,1,4,5,6,12,14,18)
#均值
mean(age)
mean(weight)
#标准差
sd(age)
sd(weight)
#相关性
cor(age,weight)
plot(age,weight)

install.packages("car")
library('car')

#查看汽车行驶的数据
head(mtcars)
#车身的重量和英里数的线性关系
result <- lm(mpg~wt,data = mtcars)
summary(result)
plot(result)
plot(mtcars$mpg,mtcars$wt)


install.packages(c("adabag", "arules", "C50", "dplyr", "e1071", "igraph", "mclust"))



x=predict(result)
plot(x)


#  数据框的使用
attach(mtcars)
mpg

with(mtcars,{
  a <- mpg
  a
}
)


# 因子

da <- c("a","b","a",'c',"b")

x <- factor(da)

levels(x)



install.packages(c("adabag", "arules", "C50", "dplyr", "e1071", "igraph", "mclust"))
install.packages(  'printr',  type = 'source',  repos = c('http://yihui.name/xran', 'http://cran.rstudio.com'))

library(C50)

#鸢尾花数据集iris进行算法的训练和测试
#从iris中随机选取100条数据作为训练集，剩下的则作为测试集：
set.seed(2016) # 设随机数种子
iris
head(iris)
train.indeces <- sample(1:nrow(iris), 100)
iris.train <- iris[train.indeces, ]
iris.test <- iris[-train.indeces, ]

#formula：模型的方程,data：训练集
model <- C5.0(formula=Species ~ ., data = iris.train)

#采用predict泛型函数进行预测：

#object：C5.0类的模型对象
#newdata：测试集
#type：预测类型，type = “class”返回所属的类，type = “prob”返回概率值

results <- predict(object = model, newdata = iris.test, type = "class")
results
#生成混淆矩阵：
res <- table(results, iris.test$Species)
#可以看到C5.0算法在测试集上有4个样本分类错误，预测的准确度为92%
res
#


library(stats)

#这时我们假定我们不知道iris数据集的分类标签，采用K-均值聚类把数据分为三类
model <- kmeans(x = subset(iris, select = -Species), centers = 3)

model
#同样生成混淆矩阵:
res <- table(model$cluster, iris$Species)
res

#载入SVM算法包
library(e1071)

set.seed(2016)
train.indeces <- sample(1:nrow(iris), 100)
iris.train <- iris[train.indeces, ]
iris.test <- iris[-train.indeces, ]


model <- svm(formula=Species ~ ., data = iris.train)
model

results <- predict(object = model, newdata = iris.test, type = "class")


results

res <- table(results, iris.test$Species)
res


#关联规则
library(arules)
data("Adult")

#apriori函数参数：

#data：训练数据
#parameter：设置关联规则的参数，如置信度，支持度等
#appearance： 设置需要显示的规则#

rules <- apriori(data = Adult, 
                 parameter = list(support = 0.4, confidence = 0.7), 
                 appearance = list(rhs = c("race=White", "sex=Male"), 
                                   default = "lhs"))

#上述命令表示，对Adult做关联规则，在置信度为70%，支持度为40%的条件下，
#生成右边关于“race=White”或者“sex=Male”的规则集。

#提取规则
rules.sorted <- sort(rules, by = "lift")
top5.rules <- head(rules.sorted, 5)
as(top5.rules, "data.frame")




#EM算法
#EM算法译作最大期望算法，它是一种迭代算法，分两步进行，第一步计算期望，利用对隐藏变量的现有估计值，计算其最大似然估计值；
#第二步是最大化上一步上的最大似然值来计算参数的值。以上两步交替运行，直至收敛。EM算法和K均值算法一样，通常也会被用来做聚类

library(mclust)

model <- Mclust(data=subset(iris, select = -Species))
model
head(model)
#可以看出，EM算法能很好的区分setosa类与其他两类数据，但是在区分versicolor与virginica类上存在问题。
table(model$classification, iris$Species)

#PageRank算法

library(igraph)
library(dplyr)
#采用random.graph.game函数生成一个包含10个对象的随机有向图：

g <- random.graph.game(n = 10, p.or.m = 1/4, directed = TRUE)
plot(g)
# 计算每个对象的PageRank值
pr <- page.rank(g)$vector
#按PageRank值排序
df <- data.frame(Object = 1:10, PageRank = pr)
arrange(df, desc(PageRank))


#AdaBoost算法
#AdaBoost算法是一种集成学习的分类算法，它会集成多个弱分类器，
#最终形成一个预测精度较好的分类器。 我们同样采用iris数据集做示例数据

library(adabag)
set.seed(2016)
train.indeces <- sample(1:nrow(iris), 100)
iris.train <- iris[train.indeces, ]
iris.test <- iris[-train.indeces, ]

model <- boosting(Species ~ ., data = iris.train)

#predict函数参数：

#object：boosting类的模型对象
#newdata：测试集
#type：预测类型，type = “class”返回所属的类，type = “prob”返回概率值

results <- predict(object = model, newdata = iris.test, type = "class")

results
#查看预测效果
res <- results$confusion
res 


#kNN算法
#kNN算法是一种惰性的分类学习算法，何为惰性，就是它不能通过学习得到一个确定的模型或者规则，在每来一个数据样本需要进行测试或者预测时，都需要重新计算才能判定新来的点的类的归属。

library(class)

set.seed(2016)
#划分训练和测试集
train.indeces <- sample(1:nrow(iris), 100)
iris.train <- iris[train.indeces, ]
iris.test <- iris[-train.indeces, ]

#采用kNN算法做预测
#因为kNN算法是惰性的，所以训练测试同时进行，代码如下：

results <- knn(train = subset(iris.train, select = -Species),
               test = subset(iris.test, select = -Species),
               cl = iris.train$Species)

results

res <- table(results, iris.test$Species)
res 


#朴素贝叶斯算法

library(e1071)

set.seed(2016)
train.indeces <- sample(1:nrow(iris), 100)
iris.train <- iris[train.indeces, ]
iris.test <- iris[-train.indeces, ]


#采用朴素贝叶斯算法建立模型

#naiveBayes函数参数：

#x：训练数据集
#y：分类标签 值得注意的是，采用朴素贝叶斯建立模型时，特征变量和分类标签是作为两个输入参数x和y输入的，而不是像其他算法直接采用数据框整体输入。
model <- naiveBayes(x = subset(iris.train,select=-Species), 
                    y = iris.train$Species)


results <- predict(object = model, newdata = iris.test, type = "class")
results

res <- table(results, iris.test$Species)
res 


#CART算法
#CART算法是一种决策树算法，下面我们介绍如何利用CART算法建立决策树。
library(rpart)

set.seed(2016)
train.indeces <- sample(1:nrow(iris), 100)
iris.train <- iris[train.indeces, ]
iris.test <- iris[-train.indeces, ]

#采用CART算法建立决策树模型

#采用rpart函数基于训练集iris.train建立决策树模型

model <- rpart(formula=Species ~ ., data = iris.train)
model
results <- predict(object = model, newdata = iris.test, type = "class")


res <- table(results, iris.test$Species)
res

