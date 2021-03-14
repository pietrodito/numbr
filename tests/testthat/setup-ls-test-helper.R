check_file_number_and_names <-
  function(ls_result, number, filenames) {
    expect_equal(length(ls_result), number)
    expect_equal(as.character(ls_result), filenames)
  }

check_file_numbers <- function(path, numbers) {
  ls_result <- list_r_numbered_files(path)
 actuals <- as.integer(ls_result$numbers)
 expect_equal(actuals , numbers)
}
