library(cowplot)
library(ggplot2)
ggdraw() + draw_image("http://1.bp.blogspot.com/-RkYnkKZ2Abk/VI82E2D4RWI/AAAAAAAABE4/6q2aJxrDSqE/s1600/ARBOLNVD.jpg") +
  draw_plot(ggplot() + theme_cowplot() + ggtitle("MERRY CHRISTMAS") + theme(axis.line = element_blank()))
