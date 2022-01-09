library(tidyverse)

make_cars <- function(){
  cars %>%
    ggplot(aes(speed, dist))+
    geom_point()+
    labs(
      title='A Scatterplot',
      x='Speed',
      y='Distance'
    )+
    theme_bw()+
    theme(
      axis.ticks = element_blank()
    )
}