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
# save an image for the readme:
recon_time <- 140
dat <- gplates_reconstruct_coastlines(recon_time)
dat2 <- gplates_reconstruct_static_polygons(recon_time)
dat3 <- gplates_plate_polygons(recon_time)
dat_map <- fortify(dat)
dat2_map <- fortify(dat2)
dat3_map <- fortify(dat3)
outline <- bbox(dat)
outline <- data.frame(xmin=-180,xmax=180,ymin=-90,ymax=90)
gg <- ggplot()
gg <- gg + geom_map(data=dat2_map, map=dat2_map,
                    aes(x=long, y=lat, map_id=id),
                    color="white", size=0.15, fill="#d8d8d6")
gg <- gg + geom_map(data=dat_map, map=dat_map,
                    aes(x=long, y=lat, map_id=id),
                    color="white", size=0.15, fill="darkkhaki")
gg <- gg + geom_map(data=dat3_map, map=dat3_map,
                    aes(x=long, y=lat, map_id=id),
                    color="red", size=0.15, fill=NA)
#gg <- gg + geom_point(aes(x=coords[1], y=coords[2]))
gg <- gg + geom_rect(data=outline,
                     aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
                     color=1, fill=NA, size=0.3)
gg <- gg + scale_size(name="Magnitude", trans="exp", labels=c(5:8), range=c(1, 20))
gg <- gg + coord_map("mollweide")
gg <- gg + theme_map()
gg <- gg + ggtitle(sprintf('Time = %0.1fMa', recon_time))
gg <- gg + theme(panel.border=element_blank())
gg

png("vignettes/plate-recons-140.png", width = 680, height = 480, units = "px", pointsize = 12)
print(gg)
dev.off()
