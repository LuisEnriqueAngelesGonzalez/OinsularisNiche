library(raster)
pacman::p_load(ntbox, rgl, marmap, oce, raster, stringr, oceanmap, tmap, lubridate, dplyr, plyr, gplots,
               tmaptools, fields, maptools, binovisualfields, rgdal, maps, rworldmap, mapplots, geoR, sf, 
               ncdf4, prettymapr, SDMTools, RColorBrewer, Metrics, ROCR, mapdata, pgirmess, ggplot2, gapminder, forcats)
#Load source functions

source("code/0_auxiliar_functions.R")


# Binary map --------------------------------------------------------------

fileSuitability           <- "Final_Models/M_4_F_lqph_Set1_E/Oct_ins_median.asc"
filePresence              <- "dataset/Oct_ins_train.csv"

bin <- binary_map(fileSuitability = fileSuitability, 
                  filePresence = filePresence, 
                  prop = 5/100)

writeRaster(x = bin$model, filename ="Final_Models/Oct_ins_median_bin.asc")


# Binarize scenarios: Extrapolation (E) -----------------------------------
setwd("./../..") #back to the directory
# List files pattern
list_files      <- list.files(path ='Final_Models/M_4_F_lqph_Set1_E', full.names = TRUE)
pattern_RCP     <- str_detect(list_files, "0_median")
files_RCP       <- list_files[pattern_RCP] #filter

#Covert to stack the .asc files
stack_files_RCP <- stack(files_RCP)

# binarize each scenario
bin_scenarios(binmodel = bin, stack_files_RCP = stack_files_RCP, folder_name = "M_0.5_F_lq_Set1_E_bin")

\