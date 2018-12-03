library(tidyverse)
library(data.table)

map <- tibble()

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

stark2 <- c("#0B1113",
					 "#1F2D2F",
					 "#1C262A",
					 "#2D3A3E",
					 "#989A9C")

stark3 <- c("#090A0C",
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
					 "#5F002E",
					 "#C1000E",
					 "#C5C2C3",
					 "#DADEE1")

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

tyrell <- c("#4D852B",
						"#539A37",
						"#60AA42",
						"#AA9F2E",
						"#C4B92A")

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

houses <- tibble(baratheon,greyjoy,jon_snow,lannister,martell,stark,stark2,stark3,targaryen,targaryen2,tully,tyrell,white_walkers)



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
		dplyr::mutate(movie = house_name)
}

for(h in colnames(houses)){
	df <- make_map(h)
	map <- rbind(map,df)
}


got.map <- map
save(got.map, file = "data/got.map.rda", ascii = FALSE, compress = 'xz')
usethis::use_data(got.map, internal = TRUE, overwrite = TRUE)

