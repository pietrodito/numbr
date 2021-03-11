test_that("create_ordered_script works", {

  create_ordered_script("temp/create-1-3", "data-management")

  check_file_numbers("temp/create-1-3", 1:3)
})
