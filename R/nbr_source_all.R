#' Run all numbered scripts in the target directory.
#'
#' @param dir (chr) The target directory (default = "R")
#'
#' @export
nbr_source_all <- function(dir = "R") {
  if (Sys.getenv("RSTUDIO") == "1")
    rstudioapi::documentSaveAll()
  scripts <-list_r_numbered_files(dir)$files 
  nbr_source(tail(scripts, n = 1), dir)
}