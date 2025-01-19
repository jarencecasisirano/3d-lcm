# PROJ error

plib <- Sys.getenv("PROJ_LIB")
prj <- system.file("proj", package = "terra")[1]
Sys.setenv("PROJ_LIB" = prj)

# and perhaps set it back when done so that you can use Postgres
# Sys.setenv("PROJ_LIB" = plib)

# 1. PACKAGES

libs <- c(
  "terra",
  "giscoR",
  "sf",
  "tidyverse",
  "ggtern",
  "elevatr",
  "png",
  "rayshader",
  "magick"
)

installed_libraries <- libs %in% rownames(
  installed.packages()
)

if(any(installed_libraries == F)){
  install.packages(
    libs[!installed_libraries]
  )
}

invisible(
  lapply(
    libs, library, character.only = T
  )
)

# 2. COUNTRY BORDERS

country_sf <- giscoR::gisco_get_countries(
  country = "BA",
  resolution = "1"
)

plot(sf::st_geometry(country_sf))

png("bih-borders.png")
plot(sf::st_geometry(country_sf))
dev.off()

# 3 DOWNLOAD ESRI LAND COVER TILES

urls <- c(
  "https://lulctimeseries.blob.core.windows.net/lulctimeseriesv003/lc2023/33T_20230101-20240101.tif",
  "https://lulctimeseries.blob.core.windows.net/lulctimeseriesv003/lc2023/34T_20230101-20240101.tif"
)

options(timeout = 120)

for(url in urls){
  download.file(
    url = url,
    destfile = basename(url),
    mode = "wb"
  )
}

# 4 LOAD TILES

raster_files <- list.files(
  path = getwd(),
  pattern = "tif",
  full.names = T
)

crs <- "EPSG:4326"

for(raster in raster_files){
  rasters <- terra::rast(raster)
  
  country <- country_sf |>
    sf::st_transform(
      crs = terra::crs(
        rasters
      )
    )
  
  land_cover <- terra::crop(
    rasters,
    terra::vect(
      country
    ),
    snap = "in",
    mask = T
  ) |>
  terra::aggregate(
    fact = 5,
    fun = "modal"
  ) |>
  terra::project(crs)
  
  terra::writeRaster(
    land_cover,
    paste0(
      raster,
      "_bosnia",
      ".tif"
    )
  )
}

# 5 LOAD VIRTUAL LAYER

r_list <- list.files(
  path = getwd(),
  pattern = "_bosnia",
  full.names = T
)

land_cover_vrt <- terra::vrt(
  r_list,
  "bosnia_land_cover_vrt.vrt",
  overwrite = T
)
