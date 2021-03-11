unnumbered_message <- "Unnumbered files found."
non_consecutive_warning <- glue::glue("Non consecutive files found. ",
                                      "Consider use fix_non_consecutive()")

check_file_order <- function(path = "R") {

  ls_result <- list_r_files(path)
  numbers <- list_r_numbered_files(path)$numbers

  if(length(numbers) != length(ls_result))
    message(unnumbered_message)

  numbers <- sort(numbers)

  identical(numbers, seq_along(numbers))
}
