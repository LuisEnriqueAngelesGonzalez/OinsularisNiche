#Auxiliar functions for presence/absence maps

binary_map <- function(fileSuitability, filePresence, prop, ...){
  
  model       <- raster::raster(fileSuitability)
  presence    <- read.csv(filePresence)
  presence    <- presence[, c(2,3)]
  suits       <- sort(stats::na.omit(raster::extract(x = model, y = presence)))
  npoints     <- length(suits)
  nsuits      <- npoints * prop 
  int_npoints <- round(nsuits)
  
  if(int_npoints < npoints && npoints > 10){
    thpos <- ceiling(nsuits)
  }else{
    thpos <- int_npoints
  }
  thr <- suits[thpos]
  
  model[model < thr] <- 0
  model[model != 0] <- 1 
  
  return(list(model = model, threshold = thr))
}


bin_scenarios <- function(binmodel, stack_files_RCP, folder_name){
  
  #Define threshold
  threshold <- binmodel$threshold
  
  #Create new folder
  dir.create(paste0("Final_Models/", folder_name))
  setwd(paste0("Final_Models/", folder_name))
  
  #Bin according threshold
  for(i in 1:dim(stack_files_RCP)[3]){
    stack_files_RCP[[i]][stack_files_RCP[[i]] < threshold] <- 0
    stack_files_RCP[[i]][stack_files_RCP[[i]] != 0] <- 1 
    writeRaster(x = stack_files_RCP[[i]], filename = paste0(names(stack_files_RCP)[[i]], "_bin.asc"))
  }
  
}
