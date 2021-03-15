#' @export
create_ordered_script <- function(name, path = "R") {
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
    fs::file_create(paste0(path, "/", first_gap, "-", name, ".R"))
    add_leading_zero(path)
}
