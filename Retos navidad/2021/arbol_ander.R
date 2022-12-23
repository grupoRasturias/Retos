library(ggplot2)
library(tidyr)

# ------- Arbol ------- #
# Definimos los parametros para el arbol
tree <- data.frame(white = 4,
                   green = c(3,5,7,9,11,9,7,5,3),
                   position = 1:9)
# Pasamos los datos a largo
tree <- tree %>% 
  pivot_longer(cols = c("white", "green"),
               names_to = "colors",
               values_to = "values")
# Creamos el tronco
tree$colors[which(tree$colors == "white" & tree$position == 5)] <- "brown"
# Establecemos el orden de los factores
tree$colors <- factor(tree$colors,
                      levels = c("green", "brown", "white"))

# ------- Bolas ------- #
balls <- tree[which(tree$colors == "green"),]
balls$values <- balls$values + 3

# ------- Tiras de luces ------- #
lights <- tree[which(tree$colors == "green"),]
lights$colors <- "up"
lights$values <- lights$values + 2
tmp <- tree[which(tree$colors == "green"),]
tmp$colors <- "down"
tmp$values <- 4
lights <- rbind(lights, tmp)
rm(tmp)

# ------- Bolas de luces aleatorias ------- #
rnd_lights <- do.call("rbind", replicate(5,
                                         tree[which(tree$colors == "green"),c(1,3)],
                                         simplify = FALSE))
rnd_lights$min <- 4
rnd_lights$max <- rnd_lights$values + 3
rnd_lights$values <- rnd_lights$values + sample(-5:8, size = 45, replace = TRUE)
rnd_lights <- rnd_lights[which(rnd_lights$values < rnd_lights$max & rnd_lights$values >= rnd_lights$min),]

# ------- Plot ------- #
ggplot() +
  geom_bar(data = tree,
           aes(x = position, y = values, fill = colors),
           stat = "identity") +
  scale_fill_manual(values = c("#008125", "#731F02", "#ffffff")) +
  geom_point(data = balls,
             aes(x = position, y = values),
             size = 5, color = "#D40707") +
  geom_line(data = lights,
             aes(x = position, y = values, group = position),
            color = "#D9D200") +
  geom_jitter(data = rnd_lights,
            aes(x = position, y = values),
            color = rainbow(length(rnd_lights$values))[sample(1:length(rnd_lights$values))],
            height = 0,
            size = runif(length(rnd_lights$values), 0, 3)) +
  xlim(c(-4, 14)) +
  ylim(c(0,18)) +
  ggtitle("¡Feliz Navidad!") +
  theme_light() +
  theme(panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.border = element_blank(),
        plot.title = element_text(size = 35, family = "Chalkboard", hjust = 0.5, vjust = -4.5),
        legend.position = "none")
