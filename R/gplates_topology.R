# library(jsonlite)
# library(rgdal)
# library(httr)

#' Reconstruct plate polygons
#' @inherit gplates_reconstruct_point
#' @return An S4 object of class SpatialPolygonsDataFrame
#' @export

#need to add warning for user if age is > 200 ma. Plate polygons are unavailable for models that go deeper than 200 ma
gplates_plate_polygons <- function(age, base_url='http://gws.gplates.org/'){
  url <- paste0(base_url,'topology/plate_polygons/')

#  url <- 'http://gws.gplates.org/topology/plate_polygons/'
  query <- sprintf('?time=%d&model=defalut',as.integer(age))

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
gplates_plate_boundaries <- function(age, base_url='http://gws.gplates.org/'){

  url <- paste0(base_url,'topology/plate_boundaries/')

 # url <- 'http://gws.gplates.org/topology/plate_boundaries/'
  query <- sprintf('?time=%d&model=GOLONKA',as.integer(age))

  fullrequest <- sprintf(paste0(url,query))
  print(fullrequest)

  r <- httr::GET(fullrequest)
  bin <- httr::content(r, "raw")
  writeBin(bin, paste0(tempdir(), "/myfile.geojson"))

  pb <- rgdal::readOGR(dsn=paste0(tempdir(), "/myfile.geojson"), layer="OGRGeoJSON", stringsAsFactors=FALSE)

  return(pb)
}
