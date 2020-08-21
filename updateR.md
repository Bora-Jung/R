<H5>R update</H5>


> R 콘솔에서 진행
```
install.packages("installr")
library(installr)
updateR()
```



>패키지 업데이트
```
packs = as.data.frame(installed.packages(.libPaths()[1]), stringAsFactors = F)

install.packages(packs$Package)
```
