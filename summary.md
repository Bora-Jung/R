**수치형변수 기초통계량**

라이브러리
```
library(dplyr)
```

평균, 편차, 최소, 최대, 중앙값
```
data %>% group_by(variable) %>% 
  summarise(mean = mean(x, na.rm=T),
            sd = sd(x, na.rm=T),
            min = min(x, na.rm=T),
            max = max(x, na.rm=T),
            medi = median(x, na.rm=T))
