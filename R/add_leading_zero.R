add_leading_zero <- function(path) {

  helper <- Vectorize(function(nb_digits, n) {
    leading_zero <- strrep("0", nb_digits - 1 - floor(log10(n)))
    paste0(leading_zero, n)
  }, vectorize.args = "n")

  ls_result <- list_r_numbered_files(path)

  nbs <- ls_result$numbers

  nb_digits <- 1 + floor(log10(tail(nbs, 1)))

  old_files <- paste0(path, "/", ls_result$files)
  new_files <- paste0(path, "/", helper(nb_digits, nbs), "-", ls_result$names)

  purrr::map2(old_files, new_files, fs::file_move)
}

