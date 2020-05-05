extractMotionParams <- function(input, ...) {
  require(fslr)
  require(neurobase)
  require(dplyr)
  
  moco_params = readLines(input)
  moco_params = strsplit(moco_params, split = " ")
  moco_params = sapply(moco_params, function(x) {
    as.numeric(x[!(x %in% "")])
  })
  moco_params = t(moco_params)
  colnames(moco_params) = paste0("MOCOparam", 1:ncol(moco_params)) #3 rotations, 3 translations
  
  mp = moco_params
  moco_params <- as.data.frame(moco_params)
  
  #mp[, 1:3] = mp[, 1:3] * 50
  
  mp[,1]=mp[,1]*(pi*50/180)
  mp[,2]=mp[,2]*(pi*50/180)
  mp[,3]=mp[,3]*(pi*50/180)
  
  mp = apply(mp, 2, diff)
  mp = rbind(rep(0, 6), mp)
  mp = abs(mp)
  moco_params$fd = rowSums(mp)
  
  output <- colMeans(moco_params)
  output$fd_max <- max(moco_params$fd)
  return(output)
  
  
  ## Optional plotting
  # mp[, 1:3] = mp[, 1:3] * 50
  # r = range(mp)
  # plot(mp[,1], type = "l", xlab = "Scan Number", main = "Motion Parameters",
  #      ylab = "Displacement (mm)",
  #      ylim = r * 1.25,
  #      lwd = 2,
  #      cex.main = 2,
  #      cex.lab = 1.5,
  #      cex.axis = 1.25)
  # for (i in 2:ncol(mp)) {
  #   lines(mp[, i], col = i)
  # }
}

