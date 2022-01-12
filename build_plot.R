library(tidyverse)
library(flextable)

make_cars <- function(mytitle){
  cars %>%
    ggplot(aes(speed, dist))+
    geom_point()+
    labs(
      title=mytitle,
      x='Speed',
      y='Distance'
    )+
    theme_bw()+
    theme(
      axis.ticks = element_blank()
    )
}


make_img_table <- function(){
  IMGS <- list.files('www')
  ISOS <- sample(c(100, 400, 1600), size=length(IMGS), replace=TRUE)
  
  tibble(
    file_name = IMGS,
    iso = ISOS
  ) %>% 
    mutate(
      img = paste0("<img src='", file_name, "'></img>")
    )
}
