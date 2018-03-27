# Visualize

library(ggplot2)

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class), color = 'blue')

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class, color = class))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))













