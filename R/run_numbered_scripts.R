#' Run all numbered scripts in the target directory.
#'
#' @param path (chr) The target directory (default = "R")
#'
#' @export
run_numbered_scripts <- function(path = "R") {
  if (Sys.getenv("RSTUDIO") == "1")
    rstudioapi::documentSaveAll()
  purrr::walk(list_r_numbered_files(path)$files,
              ~ source(paste0(path, "/", .)))
}