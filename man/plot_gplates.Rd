% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_gplates.R
\name{plot_gplates}
\alias{plot_gplates}
\title{Plot a map of tectonic plates and boundries at any point in time of Earth's history}
\usage{
plot_gplates(
  mya,
  polyoutline,
  polyfill,
  coastoutline,
  coastfill,
  mapoutline,
  mapbackground,
  base_url = "http://gws.gplates.org/"
)
}
\arguments{
\item{mya}{a numeric vector of length one designating age to reconstruct in millions of years ago}

\item{polyoutline}{a character vector designating the color of the polygon outlines}

\item{polyfill}{a character vector designating the color of the polygons}

\item{coastoutline}{a character vector designating the color of the coast outlines}

\item{coastfill}{a character vector designating the color of the continents}

\item{mapoutline}{a character vector designating the color to ouline the map}

\item{mapbackground}{a character vector designating the color of the map background}

\item{base_url}{The url to use; make sure it ends with a slash}
}
\value{
a plot of the plates and continents at the selected age
}
\description{
Plot a map of tectonic plates and boundries at any point in time of Earth's history
}
