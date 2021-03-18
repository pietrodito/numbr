#' Create a new script and numbers it with the integer used as parameter.
#' All files are renumbered accordingly the directory. After creation the file
#' is open for edition.
#' 
#' @param path (chr) The target directory (default = "R")
#' @param pos  (int) The position at which the new file will be inserted
#' @param name (chr) The name of the new files (without number)
#' @param edit_file (lgl) If TRUE the file will be open (default = T)
#' 
#' @export
nbr_insert_at <- function(path = "R", pos, name, edit_file = T) {
  
  ls_result <- tibble::as_tibble(list_r_numbered_files(path))
  
  row_nb <- which(ls_result$numbers == pos)
  if(length(row_nb) == 1) {
  ls_result$numbers <- ls_result$numbers + (ls_result$numbers >= pos) 
  ls_result <- dplyr::add_row(
    ls_result,
    files = "tempnamethatdoesnotexist.R",
    names = paste0(name, ".R"),
    numbers = pos,
    numbers_as_char = "",
    .before = row_nb)
  }
  
  do.call(function() {
    fs::dir_create(paste0(path, "/temp/"))
    withr::defer_parent(fs::dir_delete(paste0(path, "/temp/")))
  }, args = list())
  
  
  ls_result <- dplyr::mutate(ls_result,
                             new_files = paste0(path, "/",
                                                ls_result$numbers, "-", names),
                             temp_files = paste0(path, "/temp/",
                                                ls_result$numbers, "-", names),
                             files = paste0(path, "/", ls_result$files))
  
  fs::file_create(paste0(path, "/tempnamethatdoesnotexist.R"))
  
  with(ls_result, purrr::walk2(files, temp_files, fs::file_move))
  with(ls_result, purrr::walk2(temp_files, new_files, fs::file_move))
  
  add_leading_zero(path)
  
  new_file <- paste0(path, list_r_numbered_files(path)$files[pos])
    
  if(edit_file)
    if(Sys.getenv("RSTUDIO") == "1")
      rstudioapi::navigateToFile(new_file)
  else
      utils::file.edit(new_file)
}