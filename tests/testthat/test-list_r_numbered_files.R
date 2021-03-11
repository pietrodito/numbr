test_that("list_r_numbered_files works", {
  check_file_number_and_names(list_r_numbered_files("temp/files-1-2")$names,
                              2,
                              c("script.R", "script.R"))

  check_file_number_and_names(
    list_r_numbered_files("temp/files-1-2-with-low-r-extension")$files,
                              2,
                              c("1-script.r", "2-script.r"))


  check_file_number_and_names(
    list_r_numbered_files("temp/files-1-2-unnumbered-and-not-R-files")$names,
                              2,
                              c("script.R", "script.R"))

  check_file_numbers("temp/files-1-2-unnumbered-and-not-R-files", c(1,2))
  check_file_numbers("temp/files-1-3", c(1,3))


  check_file_numbers("temp/hundered-files", 1:100)
  check_file_numbers("temp/twenty-files", 1:20)
})
