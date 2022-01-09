library(tidyverse)

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