<H1> 행을 N개로 나누기 </H1>


``` n <- 1000000
len <- nrow(ICT_data01)

for(i in 1:(len/n)){
  
  name = paste0("df", i)
  assign(name, ICT_data01[(1+(i-1)*n):(i*n),])
  
}
```

행이 많아서, N개씩 자름
