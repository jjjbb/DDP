Slidify bits

setwd("~\\AFLScraper")
dataI<-read.csv("TeamstatsI.csv")
data<-dataI[,c(1,2,6,8)]#,3,4,5,9,13,12)]#,3,8,9)]
rnames <- data[,1]                            # assign labels in column 1 to "rnames"
mat_data <- data.matrix(data[,2:ncol(data)])  # transform column 2-5 into a matrix
rownames(mat_data) <- rnames   
plot(dataI, main = 'AFL 2014', col=3+ (dataI$Rank > 8))
my_palette <- colorRampPalette(c("lightyellow", "red"))(n = 18)
plot(dataI[,1:5], main = 'AFL 2014', col=3+ (dataI$Rank > 8))
plot(dataI[, c(1,6:9)], main = 'AFL 2014', col=3+ (dataI$Rank > 8))
plot(dataI[, c(1,10:13)], main = 'AFL 2014', col=3+ (dataI$Rank > 8))
plot(dataI[, c(1,14:17)], main = 'AFL 2014', col=3+ (dataI$Rank > 8))
plot(dataI[,c(16,8)],dataI[,1], main = 'AFL 2014', col=3+ (dataI$Rank > 8))

heatmap.2(mat_data,
          #cellnote = mat_data,  # same data set for cell labels
          main = "Ladder Position Correlation", # heat map title
          #notecol="black",      # change font color of cell labels to black
          density.info="none",  # turns off density plot inside color legend
          trace="none",         # turns off trace lines inside the heat map
          margins =c(12,9),     # widens margins around plot
          col=my_palette,       # use on color palette defined earlier 
          #breaks=col_breaks,    # enable color transition at specified limits
          dendrogram="column",     # only draw a row dendrogram
          scale = "column",
          RowSideColors=colorRampPalette(c("lightyellow", "red"))(n = nrow(mat_data)),
          Rowv=FALSE)            # turn off column clustering
#split data by teams. Then time slice. predict will teamX win.l
dev.off()               # close the PNG device



library(caret)
#library(AppliedPredictiveModeling)
set.seed(3433)
data$Rank<-as.integer(data$Rank)
data$Team<-factor(data$Team)
data$Disposals<-data$Disposals
data$Goals<-data$Goals
#adData = data.frame(diagnosis,predictors)

inTrain = createDataPartition(data$Rank, p = .8)[[1]]
training = data[c(inTrain,1),]
testing = data[-inTrain,]

modelFit <- train(Rank ~ Disposals + Goals, method = "glm",preProcess=c("center","scale"), data = training)
predictions <- predict(modelFit, newdata = testing)

predictions 
testing$Rank
summary(modelFit)

modelFit

sd(training$Disposals)#30.50776
sd(training$Goals)#1.467002
mean(training$Disposals)#1204.445
mean(training$Goals)#12.60667
Call:  NULL

Coefficients:
  (Intercept)    Disposals        Goals  
9.067       -2.615       -2.829  

Degrees of Freedom: 14 Total (i.e. Null);  12 Residual
Null Deviance:      426.9 
Residual Deviance: 108.5 	AIC: 80.24

bar <- qplot(x="Team", y=x,
                       geom="bar", stat="identity",
                       position="dodge")
bar + scale_fill_manual(values = c("red","blue"))

