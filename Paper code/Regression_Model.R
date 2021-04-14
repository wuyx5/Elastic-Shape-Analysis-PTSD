library(MLmetrics)
library(DAAG)
library(cvTools)
library(lmvar)
library(car)

# X_volume <- read.csv('d:/MRI/R_model/X_volume_Noscaling2.csv',header = TRUE) #
X_volume <- read.csv('d:/MRI/R_model/X_volume_Noscaling_BDI.csv',header = TRUE)
X_vertex <- read.csv('d:/MRI/R_model/X_vertex2.csv',header = TRUE)
Y_label <- read.csv('d:/MRI/R_model/Y_Noscaling2.csv',header = TRUE)

### pss~age+BDI+PCs+interactions ###
X = as.matrix(X_volume)
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ .+ X[,c(3:7)]:X_volume$age+ X[,c(3:7)]:X_volume$BDI +
    X[,c(18:22)]:X_volume$age + X[,c(18:22)]:X_volume$BDI + X[,c(33:37)]:X_volume$age+ X[,c(33:37)]:X_volume$BDI, data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

selectmodel <- lm(Y ~ .+ X[,c(4,6,20,33,34,36,37)]:X_volume$age +X[,c(6,20,21,22,33,37)]:X_volume$BDI, data = data.frame(X))
step.model <- step(selectmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~age+BDI+interactions+PCs(5-15) ###
X = as.matrix(X_volume[,c(1,2,3:17,18:32,33:47)])
X_volume_m = as.matrix(X_volume)
Y = as.matrix(Y_label[,1])
X = scale(X)
X_volume_m = scale(X_volume_m)

fullmodel <- lm(Y ~ .+ X_volume_m[,c(3:7)]:X_volume$age+ X_volume_m[,c(3:7)]:X_volume$BDI +
                  X_volume_m[,c(18:22)]:X_volume$age + X_volume_m[,c(18:22)]:X_volume$BDI + X_volume_m[,c(33:37)]:X_volume$age+ X_volume_m[,c(33:37)]:X_volume$BDI, data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~age+BDI+PCs(5-15) ###
X = as.matrix(X_volume[,c(1,2,3:17,18:32,33:47)])
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~age+BDI+PCs ###
X = as.matrix(X_volume)
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~age+BDI ###
X = as.matrix(X_volume[,c(1:2)])
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~PCs ###
X = as.matrix(X_volume[,c(3:47)])
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~PCs(5-15) ###
X = as.matrix(X_volume[,c(3:17,18:32,33:47)])
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~vertices ###
X = as.matrix(X_vertex[,c(3:47)])
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~vertices(5-15) ###
X = as.matrix(X_vertex[,c(3:7,18:22,33:37)])
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~age+BDI+vertices+interactions ###
X = as.matrix(X_vertex)
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ .+ X[,c(3:7)]:X_vertex$age+ X[,c(3:7)]:X_vertex$BDI +
                  X[,c(18:22)]:X_vertex$age + X[,c(18:22)]:X_vertex$BDI + X[,c(33:37)]:X_vertex$age+ X[,c(33:37)]:X_vertex$BDI, data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

selectmodel <- lm(Y ~ .+ X[,c(5,18,20,21,22,33,34)]:X_vertex$age +X[,c(4,5,20,22)]:X_vertex$BDI, data = data.frame(X))
step.model <- step(selectmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~age+BDI+interactions+vertices(5-15) ###
X = as.matrix(X_vertex[,c(1,2,3:11,18:26,33:41)])
X_vertex_m = as.matrix(X_vertex)
Y = as.matrix(Y_label[,1])
X = scale(X)
X_vertex_m = scale(X_vertex_m)

fullmodel <- lm(Y ~ .+ X_vertex_m[,c(3:7)]:X_vertex$age+ X_vertex_m[,c(3:7)]:X_vertex$BDI +
                  X_vertex_m[,c(18:22)]:X_vertex$age + X_vertex_m[,c(18:22)]:X_vertex$BDI + X_vertex_m[,c(33:37)]:X_vertex$age+ X_vertex_m[,c(33:37)]:X_vertex$BDI, data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~age+BDI+vertices ###
X = as.matrix(X_vertex)
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### pss~age+BDI+vertices(5-15) ###
X = as.matrix(X_vertex[,c(1,2,3:17,18:32,33:47)])
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

#########  CTQTOT  ###########
### CTQTOT~age+BDI+PCs+interactions ###
X = as.matrix(X_volume)
Y = as.matrix(Y_label[,3])
X = scale(X)

fullmodel <- lm(Y ~ .+ X[,c(3:7)]:X_volume$age+ X[,c(3:7)]:X_volume$BDI +
                  X[,c(18:22)]:X_volume$age + X[,c(18:22)]:X_volume$BDI + X[,c(33:37)]:X_volume$age+ X[,c(33:37)]:X_volume$BDI, data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

selectmodel <- lm(Y ~ .+ X[,c(3,4,6,21,33,34,35)]:X_volume$age +X[,c(5,6,22,34,35,36)]:X_volume$BDI, data = data.frame(X))
step.model <- step(selectmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~age+BDI+interactions+PCs(5-15) ###
X = as.matrix(X_volume[,c(1,2,3:16,18:31,33:46)])
X_volume_m = as.matrix(X_volume)
Y = as.matrix(Y_label[,3])
X = scale(X)
X_volume_m = scale(X_volume_m)

fullmodel <- lm(Y ~ .+ X_volume_m[,c(3:7)]:X_volume$age+ X_volume_m[,c(3:7)]:X_volume$BDI +
                  X_volume_m[,c(18:22)]:X_volume$age + X_volume_m[,c(18:22)]:X_volume$BDI + X_volume_m[,c(33:37)]:X_volume$age+ X_volume_m[,c(33:37)]:X_volume$BDI, data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~age+BDI+PCs ###
X = as.matrix(X_volume)
Y = as.matrix(Y_label[,3])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~age+BDI+PCs(5-15) ###
X = as.matrix(X_volume[,c(1,2,3:7,18:22,33:37)])
Y = as.matrix(Y_label[,3])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~age+BDI ###
X = as.matrix(X_volume[,c(1:2)])
Y = as.matrix(Y_label[,3])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~PCs ###
X = as.matrix(X_volume[,c(1,3:47)])
Y = as.matrix(Y_label[,3])
X = scale(X)
agemdl <- lm(Y~age, data = data.frame(X))

fullmodel <- lm(agemdl$residuals ~ ., data = data.frame(X[,-2]))
fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~PCs(5-15) ###
X = as.matrix(X_volume[,c(3:17,18:32,33:47)])
Y = as.matrix(Y_label[,3])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~vertices ###
X = as.matrix(X_vertex[,c(3:47)])
Y = as.matrix(Y_label[,3])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~vertices(5-15) ###
X = as.matrix(X_vertex[,c(3:7,18:22,33:37)])
Y = as.matrix(Y_label[,3])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~age+BDI+vertices+interactions ###
X = as.matrix(X_vertex)
Y = as.matrix(Y_label[,3])
X = scale(X)

fullmodel <- lm(Y ~ .+ X[,c(3:7)]:X_volume$age+ X[,c(3:7)]:X_volume$BDI +
                  X[,c(18:22)]:X_volume$age + X[,c(18:22)]:X_volume$BDI + X[,c(33:37)]:X_volume$age+ X[,c(33:37)]:X_volume$BDI, data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

selectmodel <- lm(Y ~ .+ X[,c(3,4,6,21,33,34,35)]:X_volume$age +X[,c(5,6,22,34,35,36)]:X_volume$BDI, data = data.frame(X))
step.model <- step(selectmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~age+BDI+interactions+vertices(5-15) ###
X = as.matrix(X_vertex[,c(1,2,3:12,18:27,33:42)])
X_vertex_m = as.matrix(X_vertex)
Y = as.matrix(Y_label[,3])
X = scale(X)
X_vertex_m = scale(X_vertex_m)

fullmodel <- lm(Y ~ .+ X_vertex_m[,c(3:7)]:X_volume$age+ X_vertex_m[,c(3:7)]:X_volume$BDI +
                  X_vertex_m[,c(18:22)]:X_volume$age + X_vertex_m[,c(18:22)]:X_volume$BDI + X_vertex_m[,c(33:37)]:X_volume$age+ X_vertex_m[,c(33:37)]:X_volume$BDI, data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~age+BDI+vertices ###
X = as.matrix(X_vertex)
Y = as.matrix(Y_label[,3])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~age+BDI+vertices(5-15) ###
X = as.matrix(X_vertex[,c(1,2,3:17,18:32,33:47)])
Y = as.matrix(Y_label[,3])
X = scale(X)

fullmodel <- lm(Y ~ ., data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)


########## ICV ##################
X_volume <- read.csv('d:/MRI/R_model/X_volume_Noscaling_ICV.csv',header = TRUE)
X_vertex <- read.csv('d:/MRI/R_model/X_vertex_ICV.csv',header = TRUE)
Y_label <- read.csv('d:/MRI/R_model/Y_Noscaling2.csv',header = TRUE)

### pss~age+BDI+ICV+PCs+interactions ###
X = as.matrix(X_volume)
Y = as.matrix(Y_label[,1])
X = scale(X)

fullmodel <- lm(Y ~ . + X[,c(4:8)]:X_volume$age+ X[,c(4:8)]:X_volume$BDI +
                  X[,c(19:23)]:X_volume$age + X[,c(19:23)]:X_volume$BDI + X[,c(34:38)]:X_volume$age+ X[,c(34:38)]:X_volume$BDI, data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

### CTQTOT~age+BDI+ICV+PCs+interactions ###
X = as.matrix(X_volume)
Y = as.matrix(Y_label[,3])
X = scale(X)

fullmodel <- lm(Y ~ .+ X[,c(4:8)]:X_volume$age+ X[,c(4:8)]:X_volume$BDI +
                  X[,c(19:23)]:X_volume$age + X[,c(19:23)]:X_volume$BDI + X[,c(34:38)]:X_volume$age+ X[,c(34:38)]:X_volume$BDI, data = data.frame(X))
step.model <- step(fullmodel, direction  = "both", trace = 0)
summary(step.model)

