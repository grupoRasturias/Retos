library(car)
library(rgl)
library(readxl)

set.seed(18)
dd <- data.frame(  parte = c(rep("tronco", 500), rep("primera", 500), rep("segunda", 500), rep("tercera", 500), rep("cuarta", 500), rep("quinta", 200)), 
           valor.x = c(runif(500, min = -1, max = 1), 
                       runif(500, min = -10, max  = 10),
                       runif(500, min = -8, max  = 8),
                       runif(500, min = -6, max  = 6),
                       runif(500, min = -4, max  = 4),
                       runif(200, min = -2, max  = 2)
                       ), 
           valor.z = c(runif(500, min = -1, max = 1), 
                       runif(500, min = -10, max  = 10),
                       runif(500, min = -8, max  = 8),
                       runif(500, min = -6, max  = 6),
                       runif(500, min = -4, max  = 4),
                       runif(200, min = -2, max  = 2)
                       ), 
           valor.y = c(runif(500, 1, 3),
                       runif(500, 3, 4),
                       runif(500, 4, 5),
                       runif(500, 5, 6),
                       runif(500, 6, 7),
                       runif(200, 7, 8)
                       )
           )


dd$parte <- as.factor(dd$parte)

scatter3d(x = dd$valor.x, y = dd$valor.y, z = dd$valor.z, groups = dd$parte,
          surface=FALSE, grid = FALSE, ellipsoid = TRUE, threshold = 0.00001,
          surface.col = c("green","green", "green", "green", "green","chocolate2"),xlab = "", ylab = "",
          zlab = "", axis.scales = FALSE, labels = dd$label, sphere.size = 1)
spheres3d(x = c(0.638, 0.207, 0.581, 0.840, 0.192, 0.646, 0.438),
          y = c(0.545, 0.607, 0.881, 0.340, 0.292, 0.646, 0.538),
          z = c(0.238, 0.407, 0.381, 0.840, 0.792, 0.646, 0.738), radius = runif(7, min = 0.04, 0.06),
          col = c("red"))

