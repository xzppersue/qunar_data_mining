rm(list=ls())
set.seed(123)
data = read.csv('classification_all_14features.csv',encoding = "UTF-8")
X_num = data[c("per_cost","travel_days","photo_num",
               "title_length")]
X_num = scale(X_num,scale=TRUE)  # 标准化连续型变量
data[c("per_cost","travel_days","photo_num",
       "title_length")]=X_num

# 随机欠采样
data0=data[data["z"]==0,]
data1=data[data["z"]==1,]
n0=dim(data0)[1]
n1=dim(data1)[1]
id1 = sample(x=1:n0,size=n1)
data00=data0[id1,]
data_new=rbind(data1,data00)
data=data_new

# 主成分分析
# data1=data[,-12]
# data_pca=princomp(data1)
# pcScores=data_pca$scores[,1:5]
# data3=data.frame(pcScores)
# data3$z=data[,"z"]
# data=data3

n=dim(data)[1]
id = sample(x=1:n,size=round(n*0.2))  # 划分测试集的索引
data_train=data[-id,]
data_test = data[id,]

write.table(data_train,"class_train_new.csv",row.names=FALSE,
            col.names=TRUE,sep=",")
write.table(data_test,"class_test_new.csv",row.names=FALSE,
            col.names=TRUE,sep=",")


