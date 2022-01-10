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
  IMGS <- paste0('www/', list.files('www'))
  
  dat <- tibble(
    path = IMGS,
    imgpath = IMGS
  ) 
  
  dat %>% 
    flextable() %>% 
    colformat_image(j='imgpath', width=1, height=1) %>% 
    htmltools_value()
}


# Use editData to modify the dataframe
require(editData)
result <- editData(mtcars)
