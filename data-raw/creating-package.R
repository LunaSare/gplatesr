# creating gplatesr package

setwd("~/")
usethis::create_package("gplatesr")
setwd("~/gplatesr")
usethis::use_git()
usethis::use_readme_md()
usethis::use_data_raw()


use_test("gplates_reconstruct")
