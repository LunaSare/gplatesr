# creating gplatesr package
# library(usethis)
setwd("~/")
usethis::create_package("gplatesr")
setwd("~/gplatesr")
usethis::use_git()
usethis::use_readme_md()
usethis::use_data_raw()
# move this file to data-raw
# write function descriptions. Then:
roxygen2::roxygenise() # this creates man folder
# write down global function definitions inside functions.
# write some tests:
usethis::use_test("gplates_reconstruct")
# write vignette based on files run_example.R and run_plate_boundary_example.R
install.packages("rmarkdown")
usethis::use_vignette("gplates_examples")
