reorder_files <- function(path) {
  check_file_order <- purrr::quietly(check_file_order)
  if( ! check_file_order(path)$result) {
    ls_nb_result <- list_r_numbered_files(path)
    numbers <- ls_nb_result$numbers
    new_numbers <- seq_along(numbers)

   purrr::pwalk(list(numbers,
                    new_numbers,
                    ls_nb_result$names),
               function(nb, new_nb, name) {
                 fs::file_move(glue::glue(path, "/", nb, "-", name),
                               glue::glue(path, "/", new_nb, "-", name))
                          })
  }
}
