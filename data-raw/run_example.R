# library(magrittr)
# library(rgeos)
# library(rgdal) # needs gdal > 1.11.0
# library(ggplot2)
# library(jsonlite)
# library(httr)
# library(ggthemes)
# install.packages(c("rgeos", "ggthemes"))
install.packages("mapproj")
recon_time <- 140

dat <- gplates_reconstruct_coastlines(recon_time)
length(dat)
names(dat)
class(dat)
mode(dat)

dat2 <- gplates_reconstruct_static_polygons(recon_time)
length(dat2)
names(dat2)
class(dat2)
mode(dat2)

dat3 <- gplates_plate_polygons(recon_time)
length(dat3)
names(dat3)
class(dat3)
mode(dat3)

#coords = gplates_reconstruct_point(20,-25,recon_time)
# getting:
# Error in file(con, "r") :
#   cannot open the connection to 'http://gws.gplates.org/reconstruct/reconstruct_points/?points=20,-25&time=140&model=default'
# In addition: Warning message:
# In file(con, "r") :
#   cannot open URL 'https://gws.gplates.org/reconstruct/reconstruct_points/?points=20,-25&time=140&model=default': HTTP status was '400 Bad Request'
#
dat_map <- fortify(dat)
dat2_map <- fortify(dat2)
dat3_map <- fortify(dat3)

outline <- bbox(dat)
outline <- data.frame(xmin=-180,xmax=180,ymin=-90,ymax=90)

gg <- ggplot()
gg <- gg + geom_map(data=dat2_map, map=dat2_map,
                    aes(x=long, y=lat, map_id=id),
                    color="white", size=0.15, fill="#d8d8d6")
gg <- gg + geom_map(data=dat_map, map=dat_map,
                    aes(x=long, y=lat, map_id=id),
                    color="white", size=0.15, fill="darkkhaki")
gg <- gg + geom_map(data=dat3_map, map=dat3_map,
                    aes(x=long, y=lat, map_id=id),
                    color="red", size=0.15, fill=NA)
#gg <- gg + geom_point(aes(x=coords[1], y=coords[2]))
gg <- gg + geom_rect(data=outline,
                     aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
                     color=1, fill=NA, size=0.3)
gg <- gg + scale_size(name="Magnitude", trans="exp", labels=c(5:8), range=c(1, 20))
gg <- gg + coord_map("mollweide")
gg <- gg + theme_map()
gg <- gg + ggtitle(sprintf('Time = %0.1fMa', recon_time))
gg <- gg + theme(panel.border=element_blank())
gg
