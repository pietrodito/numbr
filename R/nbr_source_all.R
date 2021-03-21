#' Run all numbered scripts in the target directory.
#'
#' @param dir (chr) The target directory (default = "R")
#' @param confirm_duration (int) duration threshold to ask for confirmation (ms) 
#'
#' @export
nbr_source_all <- function(dir = "R", confirm_duration = 10*1e3) {
  if (Sys.getenv("RSTUDIO") == "1")
    rstudioapi::documentSaveAll()
  scripts <-list_r_numbered_files(dir)$files 
  nbr_source(tail(scripts, n = 1), dir, confirm_duration = confirm_duration)
}