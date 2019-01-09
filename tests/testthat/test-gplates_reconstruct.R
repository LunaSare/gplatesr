context("test-gplates_reconstruct")

test_that("gplates_reconstruct_point works", {
    expect_error(gplates_reconstruct_point(lon = 15,lat = 15, age = 65))
})

test_that("gplates_reconstruct_coastlines works", {
    # only one age at a time:
    expect_error(gplates_reconstruct_coastlines(c(100, 140)))
})
