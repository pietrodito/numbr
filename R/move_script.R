move_script <- function(name, new_name, path = "R") {
 script <- paste0(path, "/", name)
 new_script <- paste0(path, "/", new_name)
 
 files <- list(script)
 new_files <- list(new_script)
 
 data_file <- paste0(path, "/.nbr/", name, nbr_data_suffix)
 info_file <- paste0(path, "/.nbr/", name, nbr_info_suffix)
 
 if (fs::file_exists(data_file)) {
   files <- append(files, data_file)
   new_files <- append(new_files, paste0(paste0(path, "/.nbr/", new_name), nbr_data_suffix))
 }
 if (fs::file_exists(info_file)) {
   files <- append(files, info_file)
   new_files <- append(new_files, paste0(paste0(path, "/.nbr/", new_name), nbr_info_suffix))
 }
 
 purrr::walk2(files, new_files, fs::file_move) 
}