# Libraries
library(tidyr)
library(ggplot2)
library(ggpolypath)
library(grid)
library(RColorBrewer)

# Background color (https://stackoverflow.com/questions/30136725/plot-background-colour-in-gradient)
make_gradient <- function(deg = 90, n = 100, cols = blues9) {
  cols <- colorRampPalette(cols)(n + 1)
  rad <- deg / (180 / pi)
  mat <- matrix(
    data = rep(seq(0, 1, length.out = n) * cos(rad), n),
    byrow = TRUE,
    ncol = n
  ) +
    matrix(
      data = rep(seq(0, 1, length.out = n) * sin(rad), n),
      byrow = FALSE,
      ncol = n
    )
  mat <- mat - min(mat)
  mat <- mat / max(mat)
  mat <- 1 + mat * n
  mat <- matrix(data = cols[round(mat)], ncol = n)
  grid::rasterGrob(
    image = mat,
    width = unit(1, "npc"),
    height = unit(1, "npc"), 
    interpolate = TRUE
  )
} 
bg <- make_gradient(
  deg = 90, n = 500, cols = c("#012a4a", "#013a63", "#01497c", "#014f86", "#2a6f97", "#2c7da0")
)

# Stars
## Draw some small stars randomly
stars <- tibble(x = sample(seq(0, 15, 0.3), 20),
                y = sample(seq(4, 12, 0.3), 20))


# Plot
## Draw the main star manually
tibble(x = c(12.5, 12, 11, 10, 9, 8, 7, 5.9, 7, 5, 4.5, 3.7, 2, 2.7, 1, 2.9, 2.7, 4, 5.2, 5.2, 6, 7, 8, 9, 10, 11, 12, 13, 12, 11.5, 12.2, 12.6, 13, 12.3, 11.7, 12, 12.2, 12.35, 12.5),
       y = c(4.5, 4.87, 5.45, 5.79, 5.95, 5.9, 5.7, 5.15, 3.1, 3.7, 1, 3.3, 2.3, 4.9, 6, 6.9, 9.3, 7.9, 10, 7.3, 8.1, 8.9, 9.45, 9.7, 9.7, 9.5, 9.2, 8.7, 8.2, 8, 7.65, 7.4, 7.1, 6.7, 6.3, 6, 5.7, 5.3, 4.5)) %>% 
  ggplot(.,
         aes(x = x, y = y)) +
  annotation_custom(grob = bg, #Set the background
                    xmin = -Inf,
                    xmax = Inf,
                    ymin = -Inf,
                    ymax = Inf) +
  geom_point(data = stars, #Draw the star
             aes(x = x, y = y),
             color = "white") +
  geom_polypath(fill = "#f6aa1c") + #Fill the star
  annotate("text",
           x = 7.5,
           y = -1,
           label = "Merry Christmas from R-Asturies",
           color = "white",
           size = 14,
           family = "Christmas Bell - Personal Use") +
  lims(x = c(0,15),
       y = c(-3, 12)) +
  theme_void()

