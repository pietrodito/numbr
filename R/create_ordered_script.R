#' Create a new script 
#' @export
create_ordered_script <- function(name, path = "R", edit_file = T) {
  nbs <- list_r_numbered_files(path)$numbers

  first_gap <- 0
  if (length(nbs) == 0)
    first_gap <- 1
  else {
    first_integers <- seq_along(nbs)
    discordant <- which(!(first_integers == nbs))
    if(length(discordant) == 0)
      first_gap <- length(nbs) + 1
    else
      first_gap <- min(discordant)
  }
  new_file <- paste0(path, "/", first_gap, "-", name, ".R")
  
  fs::file_create(new_file)
  add_leading_zero(path)
  message(paste0("File created: ", new_file))
    
  if(edit_file) file.edit(new_file)  
}
