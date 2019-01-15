# library(jsonlite)
# library(rgdal)
# library(httr)

#' Reconstruct plate polygons
#' @inherit gplates_reconstruct_point
#' @return An S4 object of class SpatialPolygonsDataFrame
#' @export
gplates_plate_polygons <- function(age){

  url <- 'http://gws.gplates.org/topology/plate_polygons/'
  query <- sprintf('?time=%d&model=PALEOMAP',age)

  fullrequest <- sprintf(paste0(url,query))
  print(fullrequest)

  r <- httr::GET(fullrequest)
  bin <- httr::content(r, "raw")
  writeBin(bin, paste0(tempdir(), "/myfile.geojson"))

  dat <- rgdal::readOGR(dsn=paste0(tempdir(), "/myfile.geojson"), layer="OGRGeoJSON", stringsAsFactors=FALSE)

  return(dat)
}

#' Reconstruct plate boundaries
#' @inherit gplates_reconstruct_point
#' @return An S4 object of class SpatialLinesDataFrame
#' @export
gplates_plate_boundaries <- function(age){

  url <- 'http://gws.gplates.org/topology/plate_boundaries/'
  query <- sprintf('?time=%d&model=PALEOMAP',age)

  fullrequest <- sprintf(paste0(url,query))
  print(fullrequest)

  r <- httr::GET(fullrequest)
  bin <- httr::content(r, "raw")
  writeBin(bin, paste0(tempdir(), "/myfile.geojson"))

  pb <- rgdal::readOGR(dsn=paste0(tempdir(), "/myfile.geojson"), layer="OGRGeoJSON", stringsAsFactors=FALSE)

  return(pb)
}
