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
  dat <- tribble(
    ~foo, ~imgpath,
    1, 'www/otters-cute-group-standing-stone-47487202.jpg',
    2, 'www/istockphoto-1141456840-612x612.jpg',
  )
  
  dat %>% 
    flextable() %>% 
    colformat_image(j='imgpath', width=1, height=1) %>% 
    htmltools_value()
}
