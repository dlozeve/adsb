library(tidyverse)

adsb <- read_csv("aller.csv",col_names=c("msg_type","trans_type","sessionID","aircraftID","hexIdent","flightID","date_generated","time_generated","date_logged","time_logged","callsign","altitude","groundSpeed","track","latitude","longitude","verticalRate","squawk","alert","emergency","spi","isOnGround"))

adsb[,c("sessionID","aircraftID","flightID","date_generated","time_generated","date_logged","time_logged")] <- NULL

cs_table <- adsb[,c("hexIdent","callsign")] %>% filter(!is.na(callsign)) %>% distinct()
cs_table <- cs_table[order(cs_table$callsign),]
print(cs_table, n=30)

## We keep only rows with position or altitude
positions <- adsb %>% filter(trans_type == 3)
positions <- positions[,c("hexIdent","latitude","longitude","altitude")]
## We add the column with the callsigns
positions <- full_join(cs_table, positions, by="hexIdent")
## We remove all NAs
positions <- positions[complete.cases(positions),]
positions

ggplot(positions, aes(x=longitude, y=latitude, color=callsign)) +
    geom_point() +
    guides(color=FALSE)

ggplot(positions[!is.na(positions$callsign),], aes(x=longitude, y=latitude, color=callsign)) +
    geom_line() +
    guides(color=FALSE)


library(leaflet)

m <- leaflet(positions) %>% addTiles() %>%
    addCircles(lng = ~longitude, lat = ~latitude,
               radius = 5,
               popup = ~callsign)
m

