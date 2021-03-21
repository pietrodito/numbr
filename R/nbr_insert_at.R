#' Create a new script and numbers it with the integer used as parameter.
#' All files are renumbered accordingly the directory. After creation the file
#' is open for edition.
#' 
#' @param pos  (int) The position at which the new file will be inserted
#' @param name (chr) The name of the new script (without number)
#' @param dir (chr) The target directory (default = "R")
#' @param edit_file (lgl) If TRUE the file will be open (default = T)
#' 
#' @export
nbr_insert_at <- function(pos, name, dir = "R", edit_file = T) {
  
  tempname <- function() "tempnamethatdoesnotexist.R"
  
  ls_result <- tibble::as_tibble(list_r_numbered_files(dir))
  
  row_nb <- which(ls_result$numbers == pos)
  if(length(row_nb) == 1) {
  ls_result$numbers <- ls_result$numbers + (ls_result$numbers >= pos) 
  ls_result <- dplyr::add_row(
    ls_result,
    files = tempname(),
    names = paste0(name, ".R"),
    numbers = pos,
    numbers_as_char = "",
    .before = row_nb)
  }
  
  
  ls_result <- dplyr::mutate(ls_result,
                             new_files = paste0(ls_result$numbers, "-", names),
                             temp_files = paste0("temp-",
                                                ls_result$numbers, "-", names),
                             files = paste0(ls_result$files))
  
  
  fs::file_create(paste0(dir, "/", tempname()))
  
  with(ls_result, purrr::walk2(files, temp_files,
                               ~ move_script(.x, .y, dir)))
  with(ls_result, purrr::walk2(temp_files, new_files,
                               ~ move_script(.x, .y, dir)))
  
  add_leading_zero(dir)
  
  new_file <- paste0(dir, list_r_numbered_files(dir)$files[pos])
    
  if(edit_file)
    if(Sys.getenv("RSTUDIO") == "1")
      rstudioapi::navigateToFile(new_file)
  else
      utils::file.edit(new_file)
}