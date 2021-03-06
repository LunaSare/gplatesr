#' Plot a map of tectonic plates and boundries at any point in time of Earth's history
#'@param mya a numeric vector of length one designating age to reconstruct in millions of years ago
#'@param polyoutline a character vector designating the color of the polygon outlines
#'@param polyfill a character vector designating the color of the polygons
#'@param coastoutline a character vector designating the color of the coast outlines
#'@param coastfill a character vector designating the color of the continents
#'@param mapoutline a character vector designating the color to ouline the map
#'@param mapbackground a character vector designating the color of the map background
#'@param base_url The url to use; make sure it ends with a slash
#'@return a plot of the plates and continents at the selected age
#'@export

plot_gplates <- function(mya, polyoutline, polyfill, coastoutline, coastfill, mapoutline, mapbackground, base_url='http://gws.gplates.org/') {
    # original code from https://github.com/GPlates/gplates_web_service_doc/blob/master/R/run_example.R
  recon_time <- mya
  dat <- gplates_reconstruct_coastlines(recon_time, base_url=base_url)
  dat2 <- gplates_reconstruct_static_polygons(recon_time, base_url=base_url)
  #gplates_plate_polygons() can only be used with reconstruction models SETON2012 (the default) and MULLER2016 which only extend to 200 and 230 Ma, respectively.
  # dat3 <- gplates_plate_polygons(recon_time)
  dat_map <- ggplot2::fortify(dat)
  dat2_map <- ggplot2::fortify(dat2)
  #dat3_map <- ggplot2::fortify(dat3)
  outline <- sp::bbox(dat)
  outline <- data.frame(xmin=-180,xmax=180,ymin=-90,ymax=90)
  gg <- ggplot2::ggplot()

  gg <- gg + ggplot2::geom_map(data=dat2_map, map=dat2_map, ggplot2::aes(x=long, y=lat, map_id=id),color=polyoutline, size=0.15, fill=polyfill)
  #gg <- gg + ggplot2::geom_map(data=dat3_map, map=dat3_map, ggplot2::aes(x=long, y=lat, map_id=id),color=plateoutline, size=0.15, fill=platefill)
  gg <- gg + ggplot2::geom_map(data=dat_map, map=dat_map, ggplot2::aes(x=long, y=lat, map_id=id), color=coastoutline, size=0.15, fill=coastfill)

  gg <- gg + ggplot2::geom_rect(data=outline, ggplot2::aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), color=mapoutline, fill=NA, size=0.3)

  gg <- gg + ggplot2::scale_size(name="Magnitude", trans="exp", labels=c(5:8), range=c(1, 20))
  gg <- gg + ggplot2::coord_map("mollweide")
  gg <- gg + ggthemes::theme_map()
  #gg <- gg + ggplot2::ggtitle(sprintf('Time = %0.1fMa', recon_time)) #throwing an error
  gg <- gg + ggplot2::theme(panel.border = ggplot2::element_blank())

  #to color map backround in the absence of gplates_plate_polygons() usage
  gg <- gg + ggplot2::theme(panel.background = ggplot2::element_rect(fill = mapbackground))

  return(gg)
}


#' Plot a map of tectonic plates and boundries at any point in time of Earth's history keeping Cartesian coordinates
#'@param mya a numeric vector of length one designating age to reconstruct in millions of years ago
#'@param polyoutline a character vector designating the color of the polygon outlines
#'@param polyfill a character vector designating the color of the polygons
#'@param coastoutline a character vector designating the color of the coast outlines
#'@param coastfill a character vector designating the color of the continents
#'@param mapoutline a character vector designating the color to ouline the map
#'@param mapbackground a character vector designating the color of the map background
#'@param base_url The url to use; make sure it ends with a slash
#'@return a plot of the plates and continents at the selected age
#'@export

plot_gplates_cartesian <- function(mya, polyoutline, polyfill, coastoutline, coastfill, mapoutline, mapbackground, base_url='http://gws.gplates.org/') {
    # original code from https://github.com/GPlates/gplates_web_service_doc/blob/master/R/run_example.R
  recon_time <- mya
  dat <- gplates_reconstruct_coastlines(recon_time, base_url=base_url)
  dat2 <- gplates_reconstruct_static_polygons(recon_time, base_url=base_url)
  #gplates_plate_polygons() can only be used with reconstruction models SETON2012 (the default) and MULLER2016 which only extend to 200 and 230 Ma, respectively.
  # dat3 <- gplates_plate_polygons(recon_time)
  dat_map <- ggplot2::fortify(dat)
  dat2_map <- ggplot2::fortify(dat2)
  #dat3_map <- ggplot2::fortify(dat3)
  outline <- sp::bbox(dat)
  outline <- data.frame(xmin=-180,xmax=180,ymin=-90,ymax=90)
  gg <- ggplot2::ggplot()

  gg <- gg + ggplot2::geom_map(data=dat2_map, map=dat2_map, ggplot2::aes(x=long, y=lat, map_id=id),color=polyoutline, size=0.15, fill=polyfill)
  #gg <- gg + ggplot2::geom_map(data=dat3_map, map=dat3_map, ggplot2::aes(x=long, y=lat, map_id=id),color=plateoutline, size=0.15, fill=platefill)
  gg <- gg + ggplot2::geom_map(data=dat_map, map=dat_map, ggplot2::aes(x=long, y=lat, map_id=id), color=coastoutline, size=0.15, fill=coastfill)

  gg <- gg + ggplot2::geom_rect(data=outline, ggplot2::aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), color=mapoutline, fill=NA, size=0.3)

  gg <- gg + ggplot2::scale_size(name="Magnitude", trans="exp", labels=c(5:8), range=c(1, 20))
  #gg <- gg + ggplot2::coord_map("mollweide") #hoping this fixes the issue with phylopic additions
  gg <- gg + ggthemes::theme_map()
  gg <- gg + ggplot2::ggtitle(sprintf('Time = %0.1fMa', recon_time))
  gg <- gg + ggplot2::theme(panel.border = ggplot2::element_blank())

  #to color map backround in the absence of gplates_plate_polygons() usage
  gg <- gg + ggplot2::theme(panel.background = ggplot2::element_rect(fill = mapbackground))

  return(gg)
}

#' Plot map as in plot_gplates with default black background and white landmasses
#'@inherit plot_gplates
#'@export

black_white <- function(mya, base_url='http://gws.gplates.org/') {
  age_plot <- plot_gplates(mya = mya, polyoutline = "black", polyfill = "black", coastoutline = "#d8d8d6", coastfill = "white", mapoutline = "white", mapbackground = "black", base_url=base_url)
  return(age_plot)
}

#' Plot map as in plot_gplates with user set land and sea colors
#'@inherit plot_gplates
#'@param land What color to paint the land
#'@param sea What color to paint the sea
#'@param mapbackground What color to paint the background (that which isn't the globe or plates)
#'
#' Burn the sky, boil the sea -- you can't take my color palette from me!
#'@export
land_sea <- function(mya, base_url='http://gws.gplates.org/', land="gray", sea="white", mapbackground="white") {
  age_plot <- plot_gplates(mya = mya, polyoutline = sea, polyfill = sea, coastoutline = land, coastfill = land, mapoutline = land, mapbackground = mapbackground, base_url=base_url)
  return(age_plot)
}
