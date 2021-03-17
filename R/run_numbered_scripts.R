run_numbered_scripts <- function(path = "R") {
  purrr::walk(list_r_numbered_files(path), source)
}