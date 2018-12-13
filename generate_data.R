library(tidyverse)
library(data.table)

map <- list()

# Define colours
targaryen <- c("#000000",
							 "#4e0002",
							 "#9D0005",
							 "#9593A2",
							 "#D8D8D8")

targaryen2 <- c("#E1DFC4",
							 "#F52156",
							 "#CA001B",
							 "#B30000",
								"#600000")

stark <- c("#17181D",
					 "#25252A",
					 "#3C3E43",
					 "#575964",
					 "#9593A2")

# stark2 <- c("#0B1113",
# 					 "#1F2D2F",
# 					 "#1C262A",
# 					 "#2D3A3E",
# 					 "#989A9C")

stark2 <- c("#090A0C",
						"#591D18",
						"#938170",
						"#CCA15B",
						"#636166")

lannister <- c("#5C0000",
							 "#890000",
							 "#C50000",
							 "#FB7E00",
							 "#FFA700")


martell <- c("#F1B043",
						"#FF9517",
						"#EF7300",
						"#ED4700",
						"#B20000")

tully <- c("#131142",
					 "#DADEE1",
					 "#C1000E")

greyjoy <- c("#000000",
						 "#372E29",
						 "#726255",
						 "#F0C75E",
						 "#ECB939")

baratheon <- c("#02060B",
						 "#987411",
						 "#B89017",
						 "#F0BA00",
						 "#FEFEF9")

tyrell <- c("#36A107",
						"#4D852B",
						"#60AA42",
						"#C4B92A",
						"#C4B600")

white_walkers <- c("#263464",
									 "#345392",
									 "#5492D0",
									 "#6596C9",
									 "#51B2FF")

jon_snow <- c("#132525",
							"#113232",
							"#747374",
							"#95C2C1",
							"#36AFAE")

margaery <- c("#82B5C4",
							"#A9BC7E",
							"#D7C42A",
							"#CDA25C",
							"#C37E90")

daenerys <- c("#792427",
							"#545058",
							"#2B818E",
							"#80A098",
							"#D1BDA2")

game_of_thrones <- c("#9A1408",
							"#B32B1B",
							"#966628",
							"#AAA549",
							"#B4AF6D")

wildfire <- c("#000000",
							"#002807",
							"#006300",
							"#009C00",
							"#00C800",
							"#6EFF6E",
							# "#A9FED0",
							"#E6FFFF")

houses <- list(baratheon = baratheon,
							 greyjoy = greyjoy,
							 jon_snow = jon_snow,
							 lannister = lannister,
							 martell = martell,
							 stark = stark,
							 stark2 = stark2,
							 targaryen = targaryen,
							 targaryen2 = targaryen2,
							 tully = tully,
							 tyrell = tyrell,
							 white_walkers = white_walkers,
							 wildfire = wildfire,
							 margaery = margaery,
							 daenerys = daenerys,
							 game_of_thrones = game_of_thrones)



# Expand palette to accept contiuous scales or longer discrete scales
complete_palette <- function(house, n = 3e3){
	complete_col <- c()
	for(i in 1:(length(house)-1)){
		cols <- colorRampPalette(c(house[i], house[i+1]))
		complete_col <- c(complete_col, cols(n))
	}
	return(complete_col)
}

# Build DF map
make_map <- function(house_name){
	houses[[house_name]] %>%
		complete_palette() %>%
		grDevices::col2rgb() %>%
		t() %>%
		as.data.frame() %>%
		dplyr::rename(V1 = red) %>%
		dplyr::rename(V2 = green) %>%
		dplyr::rename(V3 = blue) %>%
		dplyr::mutate(house = house_name)
}

for(h in names(houses)){
	df <- make_map(h)
	map <- rbind(map,df)
}


got.map <- map
save(got.map, file = "data/got.map.rda", ascii = FALSE, compress = 'xz')
usethis::use_data(got.map, internal = TRUE, overwrite = TRUE)

