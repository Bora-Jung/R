###test
###test-name
###date

library(dplyr)
library(tidyr)
library(reshape2)

#################################################
### IFT-DVRS 불러오기

ift_tmp_6 <- data.frame(matrix(nrow=0, ncol=2))
meta_IFT_6 <- data.frame(matrix(nrow=0, ncol=2))

setwd("D:/workspace/DN8/IFT/ICU(DN8)/16_2_5.IFT/data/DN8 ICU M/91950-L1130/2019/04/24")
dir <- c("D:/workspace/DN8/IFT/DVRS/31_6.IFT/data/2019/04/30")

## 폴더 내 읽어올 파일 조건 셋팅
file_list <- list.files(dir)
file_list <- subset(file_list, substr(file_list, 1, 2) == "UD") #파일명 UD로 시작하는것만 선택
(file_cnt <- length(file_list))

#파일경로, 파일개수 dataframe 추가하기
## 폴더 내 셋팅된 조건의 파일 불러오기
for(i in 1:file_cnt){
  temp <- read.table(file_list[i],
                     sep=";", header=FALSE, skip=5,
                     fill=TRUE) #결측치를 NA 로 채우기
  
  temp$new <- file_list[i]
  temp$load <- dir
  
  ift_tmp_6 <- rbind(ift_tmp_6, temp)
  print(i)
}


#파일정보 가져오기
for(i in 1:file_cnt){
  tmp <- read.csv(file_list[i], header=FALSE, skip=1, nrows=2)
  tmp$filename <- file_list[i]
  tmp <- separate(tmp, V1, into=c("v1", "v2"), sep="=")
  tmp <- dcast(tmp, filename ~ v1, value.var="v2")
  
  meta_IFT_5 <- rbind(meta_IFT_5, tmp)
  print(i)
}


## raw data로 하나 저장해놓기
write.csv(ift_tmp_5, "S:/정보라/DN8/dataset/IFT_31_5_20190517.csv")
write.csv(meta_IFT_5, "S:/정보라/DN8/dataset/IFT_31_5_META_20190517.csv")



#################################################
### IFT-ICU(DN8)

IFT_ICU_9 <- data.frame(matrix(nrow=0, ncol=2))
meta_IFT_ICU_9 <- data.frame(matrix(nrow=0, ncol=2))

setwd("D:/workspace/DN8/IFT/ICU(DN8)/16_2_5.IFT/data/DN8 ICU M/91950-L1570/2019/05/15")
dir <- c("D:/workspace/DN8/IFT/ICU(DN8)/16_2_5.IFT/data/DN8 ICU M/91950-L1570/2019/05/15")

file_list <- list.files(dir)
(file_cnt <- length(file_list))


for(i in 1:file_cnt){
  temp <- read.table(file_list[i],
                     sep=";", header=FALSE, skip=5,
                     fill=TRUE) #결측치를 NA 로 채우기
  
  temp$new <- file_list[i]
  temp$load <- dir
  
  IFT_ICU_9 <- rbind(IFT_ICU_9, temp)
  print(i)
}


#파일정보 가져오기
for(i in 1:file_cnt){
  tmp <- read.csv(file_list[i], header=FALSE, skip=1, nrows=2)
  tmp$filename <- file_list[i]
  tmp <- separate(tmp, V1, into=c("v1", "v2"), sep="=")
  tmp <- dcast(tmp, filename ~ v1, value.var="v2")
  
  meta_IFT_ICU_9 <- rbind(meta_IFT_ICU_9, tmp)
  print(i)
}


write.csv(IFT_ICU_9, "S:/정보라/DN8/dataset/IFT_ICU_9_20190517.csv")
write.csv(meta_IFT_ICU_9, "S:/정보라/DN8/dataset/IFT_ICU_9_META_20190517.csv")



#####################################
### IFT data 병합
setwd("S:/정보라/DN8/dataset")
IFT_1 <- read.csv("D:/workspace/DN8/dataset/IFT_31_1_20190517.csv", header=TRUE, sep=",")
IFT_2 <- read.csv("D:/workspace/DN8/dataset/IFT_31_2_20190517.csv", header=TRUE, sep=",")
IFT_3 <- read.csv("D:/workspace/DN8/dataset/IFT_31_3_20190517.csv", header=TRUE, sep=",")
IFT_4 <- read.csv("D:/workspace/DN8/dataset/IFT_31_4_20190517.csv", header=TRUE, sep=",")
IFT_5 <- read.csv("D:/workspace/DN8/dataset/IFT_31_5_20190517.csv", header=TRUE, sep=",")

IFT_DVRS <- rbind(IFT_1, IFT_2, IFT_3, IFT_4, IFT_5)
str(IFT_DVRS)
IFT_DVRS <- IFT_DVRS[,-1]
colnames(IFT_DVRS) <- c("id","code1", "code2", "setting_value", "value",
                        "unit", "okng", "na", "filename", "load")

IFT_ICU_1 <- read.csv("IFT_ICU_1_20190517.csv", header=TRUE, sep=",")
IFT_ICU_2 <- read.csv("IFT_ICU_2_20190517.csv", header=TRUE, sep=",")
IFT_ICU_3 <- read.csv("IFT_ICU_3_20190517.csv", header=TRUE, sep=",")
IFT_ICU_4 <- read.csv("IFT_ICU_4_20190517.csv", header=TRUE, sep=",")
IFT_ICU_5 <- read.csv("IFT_ICU_5_20190517.csv", header=TRUE, sep=",")
IFT_ICU_6 <- read.csv("IFT_ICU_6_20190517.csv", header=TRUE, sep=",")
IFT_ICU_7 <- read.csv("IFT_ICU_7_20190517.csv", header=TRUE, sep=",")
IFT_ICU_8 <- read.csv("IFT_ICU_8_20190517.csv", header=TRUE, sep=",")
IFT_ICU_9 <- read.csv("IFT_ICU_9_20190517.csv", header=TRUE, sep=",")
IFT_ICU <- rbind(IFT_ICU_1, IFT_ICU_2, IFT_ICU_3, IFT_ICU_4,
                 IFT_ICU_5, IFT_ICU_6, IFT_ICU_7, IFT_ICU_8, IFT_ICU_9)
IFT_ICU <- IFT_ICU[,-1]
colnames(IFT_ICU) <- c("code1", "code2", "setting_value", "value",
                       "okng", "na", "filename", "load")

str(IFT_ICU)
IFT_ICU <- filter(IFT_ICU, !grepl('Report', filename))



#code1 공백 채우기
for(i in 1:nrow(IFT_ICU)){
  if(IFT_ICU$code1[i] == ""){
    IFT_ICU$code1[i] <- IFT_ICU$code1[i-1]
  }
}

output <- character(nrow(IFT_ICU))
system.time({
  for(i in 845500:nrow(IFT_ICU)){
    if(IFT_ICU[i, 'code1'] == ""){
      IFT_ICU[i, 'code1'] <- IFT_ICU[i-1, 'code1']
    }
  }
  if(i%%1000 == 0){print(i)}
})


###
install.packages("tidyr")
library(tidyr)

data <- IFT_DVRS
#data <- rbind(IFT_DVRS, IFT_ICU)

data$filename <- substr(data$filename,1,35)   #- .dat
data <- data[,c(10,9,1:8)] #데이터셋 컬럼 순서 변경

data$filename_raw <- data$filename

data <- separate(data, filename, into=c("filename", "OX"), sep="-") #filename '-'기준으로 분리
data$OX <- as.factor(data$OX)

data <- separate(data, filename, into=c("filename1", "filename2"), sep="_")
data$filename1 <- as.factor(data$filename1)
data$filename2 <- as.factor(data$filename2)

#code1,2 불러오기
code1 <- read.csv("S:/정보라/DN8/IFT_code1.csv", header=T)
code2 <- read.csv("S:/정보라/DN8/IFT_code2.csv", header=T, stringsAsFactors = TRUE)
code2$code2_newcode <- c("01", "02", "03", "04", "05", "06", "07", "08", "09",
                         10:60)
code2$code2_newcode <- as.factor(code2$code2_newcode)

#code명과 code값 매핑시키기
test <- merge(data, code1, by="code1", all.x=TRUE)
test <- merge(test, code2, by="code2", all.x=TRUE)
test$code <- paste(test$code1_newcode, test$code2_newcode, sep="")
test <- test[,c('filename_raw','load', 'id', 'code', 'value', 'okng')]#필요한 변수만 추출

test$code <- as.character(test$code)
test <- filter(test, !grepl('NA', code)) #code 없는거(NANA) 제거하고 데이터 추출
test <- test[order(test$filename_raw, test$code, test$id),] #filename, code, id 순으로 정렬

test$key <- paste(substr(test$load, 27, 30), substr(test$load, 41, 50), test$filename_raw, sep="-")

##filename_raw, code 별로 수행된 id? 수 넘버링 (그룹별 넘버링 하기)
library(dplyr)
test <- test %>%
  group_by(key, code) %>% 
  mutate(numbering = order(order(key)))

## numbering = 1 (마지막으로 수행된 id수만 추출)
test <- test %>% filter(numbering == 1)
#test <- test[,c(1:6)] #numbering 변수 지우기

####################################
## 원하는 dataset 형태로 변형하기
library(reshape2)

test$value <- as.character(test$value) #value값 문자형으로 변경

ex1 <- test[,c('key', 'code', 'value')]
tmp1 <- dcast(ex1, key ~ code)

ex2 <- test[,c('key', 'code', 'okng')]
ex2$okng <- as.character(ex2$okng)
tmp2 <- dcast(ex2, key ~ code)

colnames(tmp2) <- paste(colnames(tmp2),"result", sep="_")

dataset <- data.frame()
dataset <- cbind(tmp1, tmp2)
dataset$OK_NG <- substr(dataset$key, 51, 51)
dataset <- dataset[,-103]

dataset$BARCODE <- substr(dataset$key, 22, 37)

#열순서 정렬
#dataset <- dataset[,order(names(dataset))]
#dataset <- dataset[,c(51,1:50,52:127,129:232,128)]


#중복인것 - 마지막글자 OX에 따라 코드 부여
### 1: 양품 /  2: 진성불량  / 3: 가성불량 
# OX code validation
tb <- dataset[,c('BARCODE','OK_NG')]

library(stringr)
for(i in 1:2){
  tb[,i] <- str_trim(tb[,i], side=c("both", "left", "right"))}

tmp <- do.call(rbind, lapply(split(tb, tb$BARCODE),
                             function(aa){
                               aa$val2 <- paste(aa$OK_NG, collapse="")
                               
                               return(aa)
                             }))
row.names(tmp) <- NULL
tmp$length <- nchar(tmp$val2)

tmp_1 <- subset(tmp, tmp$length == 1) #1번만 검사한 테이블
tmp_2 <- subset(tmp, tmp$length > 1)  #중복인 테이블

tmp_2$OX_final <- str_sub(tmp_2$val2, -1)

#중복아닌것 - OX에 따라 코드부여
### 1: 정상 / 2: 진성불량
tmp_1$ON <- c()
for(i in 1:nrow(tmp_1)){
  ifelse(tmp_1$val2[i] == "O", tmp_1$ON[i] <- "1", tmp_1$ON[i] <- "2")
}


#중복된것 - 바코드별로 양품/가성불량/진성불량 코드 부여
#가성불량(3) : 검사결과에 X가 하나라도 있고 최종적으로 O인 경우
#진성불량(2) : 검사결과에 X가 하나라도 있고 최종적으로 X인 경우
#양품(1) : 검사결과에 X가 없는 경우
tmp_2$ON <- c()
for(i in 1:nrow(tmp_2)){
  if(grepl('X', tmp_2$val2[i]) && tmp_2$OX_final[i] == "O"){
    tmp_2$ON[i] <- "3"}
  else if(grepl('X', tmp_2$val2[i]) && tmp_2$OX_final[i] == "X"){
    tmp_2$ON[i] <- "2"}
  else if(!grepl('X', tmp_2$val2[i])){
    tmp_2$ON[i] <- "1"}
}


tmp_1 <- tmp_1[,c('BARCODE', 'ON')]
tmp_2 <- tmp_2[,c('BARCODE', 'ON')]

ox <- rbind(tmp_1, tmp_2)
ox_unique <- unique(ox)

dataset <- merge(x=dataset,
                 y=ox_unique,
                 by='BARCODE',
                 all.X=TRUE)

dataset <- dataset[,-205]
colnames(dataset)[205] <- 'OK_NG'
dataset <- dataset[,order(names(dataset))]
dataset <- dataset[,c(88, 37, 103, 1:36, 38:87, 89:102, 104:205)]

dataset$hogi <- substr(dataset$key, 1, 4)
dataset$date <- substr(dataset$key, 6, 15)

dataset <- dataset[,c(1:3, 206:207, 4:205)]

colnames(dataset)
dataset <- dataset[,-1]
write.csv(dataset, "D:/workspace/DN8/dataset/IFT(DVRS)_dataset_20190517_v2.csv")
