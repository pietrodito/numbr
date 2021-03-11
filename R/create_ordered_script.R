create_ordered_script <- function(path="R", name) {
  nbs <- list_r_numbered_files(path)$numbers

  first_gap <- 0
  if (length(nbs) == 0)
    first_gap <- 1
  else {
    first_integers <- seq_along(nbs)
    first_gap <- min(which(!(first_integers == nbs)))
    if (first_gap == 0)
      first_gap <- length(nbs) + 1
    fs::file_create(paste0(path, "/", first_gap, "-", name, ".R"))
  }
}
