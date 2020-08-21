## bar-plot


ggplot 설치
```
library(ggplot2)
```

카테고리별 빈도 plot
```
ggplot(data, aes(x=x, fill=분석결과분류)) +
  geom_bar() +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(), 
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank()) +
  guides(fill="none") +
  geom_text(stat = "count",
            aes(label=..count..),
            position = position_dodge(width = 0.8),
            vjust = 0) +
  scale_x_discrete(limits=c("FUSE", "chip", "MCU", "SW", "CAN", "외관", "기타", ""))
