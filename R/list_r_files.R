list_r_files <- function(path = "R") {
  ls_result <- fs::dir_ls(path, regexp = "\\.[Rr]$")
  stringr::str_match(ls_result, "[^/]+.[Rr]$")
}

