#'Plot a map of selected age 
#'@param mya a numeric vector of length one designating age to reconstruct in millions of years ago
#'@param polyoutline a character vector designating the color of the polygon outlines
#'@param polyfill a character vector designating the color of the polygons
#'@param coastoutline a character vector designating the color of the coast outlines
#'@param coastfill a character vector designating the color of the continents
#'@param plateoutline a character vector designating the color of the plate outlines
#'@param platefill a character vector designating the color of the plates
#'@return a plot of the plates and continents at the selected age
#'@export
#plot a map
plot_gplates <- function(mya, polyoutline, polyfill, coastoutline, coastfill, plateoutline, platefill) {

  recon_time <- mya #140 mya
  dat <- gplates_reconstruct_coastlines(recon_time)
  dat2 <- gplates_reconstruct_static_polygons(recon_time)
  dat3 <- gplates_plate_polygons(recon_time)
  dat_map <- ggplot2::fortify(dat)
  dat2_map <- ggplot2::fortify(dat2)
  dat3_map <- ggplot2::fortify(dat3)
  outline <- sp::bbox(dat)
  outline <- data.frame(xmin=-180,xmax=180,ymin=-90,ymax=90)
  gg <- ggplot()

  gg <- gg + geom_map(data=dat2_map, map=dat2_map, aes(x=long, y=lat, map_id=id),color=polyoutline, size=0.15, fill=polyfill)
  gg <- gg + geom_map(data=dat3_map, map=dat3_map, aes(x=long, y=lat, map_id=id),color=plateoutline, size=0.15, fill=platefill)
  gg <- gg + geom_map(data=dat_map, map=dat_map, aes(x=long, y=lat, map_id=id), color=coastoutline, size=0.15, fill=coastfill)

  gg <- gg + geom_rect(data=outline,aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), color=1, fill=NA, size=0.3)
  gg <- gg + scale_size(name="Magnitude", trans="exp", labels=c(5:8), range=c(1, 20))
  gg <- gg + coord_map("mollweide")
  gg <- gg + ggthemes::theme_map()
  gg <- gg + ggtitle(sprintf('Time = %0.1fMa', recon_time))
  gg <- gg + theme(panel.border=element_blank())

  return(gg)
}
