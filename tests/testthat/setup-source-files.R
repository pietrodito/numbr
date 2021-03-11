files <- list.files("setup")
files <- paste0("setup/", files)
sapply(files, source)
