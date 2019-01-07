context("test-gplates_reconstruct")

test_that("gplates_reconstruct_point works", {
    library(jsonlite)
    library(rgdal)
    gplates_reconstruct_point(lon = 15,lat = 15, age = 65)
})
