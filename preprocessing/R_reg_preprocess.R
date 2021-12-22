rm(list=ls())
set.seed(123)
data = read.csv('regression_data2.csv',encoding = "UTF-8")
y = data['read_num_transformed'] 
y = log(y) # 对响应变量进行对数变换
data['read_num_transformed'] = y
X_num = data[c("per_cost","travel_days","photo_num",
               "title_length")]
X_num = scale(X_num,scale=TRUE)  # 标准化连续型变量
data[c("per_cost","travel_days","photo_num",
       "title_length")]=X_num

# 通过方差分析选择显著的特征
ano_frame=anova(lm(read_num_transformed~.,data=data))
rownames(ano_frame)[ano_frame['Pr(>F)']<0.001&
                      !is.na(ano_frame['Pr(>F)'])]

X1 = data[c("travel_days","photo_num","person_num_亲子",
            "title_length","playmode1","playmode2" )]
result = cbind(X1,y)
write.table(result,"regression.csv",row.names=FALSE,col.names=TRUE,sep=",")