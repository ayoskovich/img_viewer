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
  #IMGS <- paste0('www/', list.files('www'))
  
  tribble(
    ~file_name, ~iso,
    'A.jpg', 400,
    'B.jpg', 400,
    'C.jpg', 800
  ) %>% 
    mutate(
      img = paste0("<img src='", file_name, "'></img>")
    )
}


# Use editData to modify the dataframe
#require(editData)
#result <- editData(mtcars)
