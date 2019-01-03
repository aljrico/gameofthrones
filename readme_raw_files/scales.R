library(gameofthrones)
library(tidyverse)
library(gridExtra)

gg <- ggplot(diamonds, aes(carat, stat(count), fill = cut)) +
	geom_density(position = "fill") +
	xlab("") +
	ylab("")
gg1 <- gg +
	scale_fill_got(discrete = TRUE, option = "white_walkers", name = "") +
	ggtitle("White Walkers ")

gg2 <- gg +
	scale_fill_got(discrete = TRUE, option = "Lannister", name = "") +
	ggtitle("House Lannister ")

gg3 <-gg +
	scale_fill_got(discrete = TRUE, option = "Tyrell", name = "") +
	ggtitle("House Tyrell ")

gg4 <- gg +
	scale_fill_got(discrete = TRUE, option = "Stark", name = "") +
	ggtitle("House Stark ")

gg5 <- gg +
	scale_fill_got(discrete = TRUE, option = "Tully", name = "") +
	ggtitle("House Tully ")

gg6 <- gg +
	scale_fill_got(discrete = TRUE, option = "Martell", name = "") +
	ggtitle("House Martell ")

gg7 <- gg +
	scale_fill_got(discrete = TRUE, option = "Targaryen", name = "") +
	ggtitle("House Targaryen ")

gg8 <- gg +
	scale_fill_got(discrete = TRUE, option = "Targaryen2", name = "") +
	ggtitle("House Targaryen2 ")

gg9 <- gg +
	scale_fill_got(discrete = TRUE, option = "Stark2", name = "") +
	ggtitle("House Stark2 ")

gg10 <- gg +
	scale_fill_got(discrete = TRUE, option = "Greyjoy", name = "") +
	ggtitle("House Greyjoy ")

gg11 <- gg +
	scale_fill_got(discrete = TRUE, option = "Baratheon", name = "") +
	ggtitle("House Baratheon ")

gg12 <- gg +
	scale_fill_got(discrete = TRUE, option = "Jon_Snow", name = "") +
	ggtitle("Jon Snow")

gg13 <- gg +
	scale_fill_got(discrete = TRUE, option = "Margaery", name = "") +
	ggtitle("Lady Margaery")

gg14 <- gg +
	scale_fill_got(discrete = TRUE, option = "Daenerys", name = "") +
	ggtitle("Daenerys")

gg15 <- gg +
	scale_fill_got(discrete = TRUE, option = "game_of_thrones", name = "") +
	ggtitle("Game of Thrones")

gg16 <- gg +
	scale_fill_got(discrete = TRUE, option = "Wildfire", name = "") +
	ggtitle("Wildfire")



grid.arrange(gg1,gg2,gg3,gg4,gg5,gg6)
grid.arrange(gg7,gg8,gg9,gg10,gg11,gg12)
grid.arrange(gg13,gg14,gg15,gg16)

