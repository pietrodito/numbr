create_folder_and_files <- function(subdir, filenames = NA) {

  subdir <- paste0("temp/", subdir)

  fs::dir_create(subdir)
  
  if(length(filenames > 0))
    fs::file_create(paste(subdir, filenames, sep = "/"))
    
  if(is_testing()) withr::defer(fs::dir_delete(subdir), teardown_env())
}

subdir <- "files-1-2"
filenames <- c("1-script.R", "2-script.R")
create_folder_and_files(subdir, filenames)

subdir <- "files-1-2-with-low-r-extension"
filenames <- c("1-script.r", "2-script.r")
create_folder_and_files(subdir, filenames)

subdir <- "files-1-2-unnumbered-and-not-R-files"
filenames <- c("1-script.R", "2-script.R",
               "data-management.R", "table-1.R",
               "random_not_R_file_1", "random_not_R_file_2")
create_folder_and_files(subdir, filenames)

subdir <- "files-1-3"
filenames <- c("1-script.R", "3-script.R")
create_folder_and_files(subdir, filenames)

subdir <- "files-2-5"
filenames <- c("2-script.R", "5-script.R")
create_folder_and_files(subdir, filenames)

subdir <- "delete-1-3-4"
filenames <- c("1-import.R", "3-data-management.R", "4-table-1.R")
create_folder_and_files(subdir, filenames)

subdir <- "create-1-3"
filenames <- c("1-script.R", "3-script.R")
create_folder_and_files(subdir, filenames)


subdir <- "twenty-files"
filenames <- paste0(1:20, "-script.R")
create_folder_and_files(subdir, filenames)

subdir <- "hundered-files"
filenames <- paste0(1:100, "-script.R")
create_folder_and_files(subdir, filenames)

subdir <- "insert-files-1-2-3"
filenames <- paste0(1:3, "-script.R")
create_folder_and_files(subdir, filenames)

subdir <- "empty"
create_folder_and_files(subdir)

if(is_testing()) withr::defer(fs::dir_delete("temp"), teardown_env())