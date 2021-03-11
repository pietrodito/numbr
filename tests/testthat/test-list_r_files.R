test_that("list_r_files works", {
  check_file_number_and_names(list_r_files("temp/files-1-2"),
                              2,
                              c("1-script.R", "2-script.R"))

  check_file_number_and_names(
    list_r_files("temp/files-1-2-with-low-r-extension"),
    2,
    c("1-script.r", "2-script.r"))


  check_file_number_and_names(
    list_r_files("temp/files-1-2-unnumbered-and-not-R-files"),
                              4,
                              c("1-script.R", "2-script.R",
                                "data-management.R", "table-1.R"))
})

