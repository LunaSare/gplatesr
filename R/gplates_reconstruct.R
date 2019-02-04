#' Launch the service via docker
#' @export

launch_docker <- function() {
    #docker <- stevedore::docker_client()
    #docker$container$run("alpine:3.1", c("echo", "hello world"))
    #system("docker run --rm -it -p 8888:80 gplates/gws")
    system("docker run --rm -p 8888:80 gplates/gws", wait=FALSE)
}


#' Reconstruct a point
#' @param lon A numeric vector of length one.
#' @param lat A numeric vector of length one.
#' @param age A numeric vector of length one indicating the geologic time to reconstruct.
#' @param base_url The url to use; make sure it ends with a slash
#' @return Coordinates
#' @export

gplates_reconstruct_point <- function(lon,lat,age, base_url='http://gws.gplates.org/'){
  url <- paste0(base_url,'reconstruct/reconstruct_points/')
  query <- sprintf('?points=%d,%d&time=%d&model=GOLONKA',lon,lat,age) #The Paleobiodb navigator uses GOLONKA, PALEOMAP extends to 750 ma, default only to 200 ma

  fullrequest <- sprintf(paste0(url,query))

  print(fullrequest)
  rawdata <- readLines(fullrequest, warn="F")
  dat <- jsonlite::fromJSON(rawdata)

  rcoords = dat['coordinates'][[1]]
  return(rcoords)
}

#' Reconstruct ancient coastlines
#' @inherit gplates_reconstruct_point
#' @return An S4 object of class SpatialPolygonsDataFrame
#' @export
gplates_reconstruct_coastlines <- function(age, base_url='http://gws.gplates.org/'){
  url <- paste0(base_url,'reconstruct/coastlines/')
  query <- sprintf('?time=%d&model=GOLONKA',age)

  fullrequest <- sprintf(paste0(url,query))
  print(fullrequest)

  r <- httr::GET(fullrequest)
  bin <- httr::content(r, "raw")
  writeBin(bin, paste0(tempdir(), "/myfile.geojson"))

  dat <- rgdal::readOGR(dsn=paste0(tempdir(), "/myfile.geojson"), layer="OGRGeoJSON", stringsAsFactors=FALSE)

  return(dat)
}

#' Reconstruct static polygons
#' @inherit gplates_reconstruct_point
#' @return An S4 object of class SpatialPolygonsDataFrame
#' @export
gplates_reconstruct_static_polygons <- function(age, base_url='http://gws.gplates.org/'){
    url <- paste0(base_url,'reconstruct/static_polygons/')
  #url <- 'http://gws.gplates.org/reconstruct/static_polygons/'
  query <- sprintf('?time=%d&model=GOLONKA',age)

  fullrequest <- sprintf(paste0(url,query))
  print(fullrequest)

  r <- httr::GET(fullrequest)
  bin <- httr::content(r, "raw")
  writeBin(bin, paste0(tempdir(), "/myfile.geojson"))

  dat <- rgdal::readOGR(dsn=paste0(tempdir(), "/myfile.geojson"), layer="OGRGeoJSON", stringsAsFactors=FALSE)

  return(dat)
}
