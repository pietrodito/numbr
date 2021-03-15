test_that("create_ordered_script works", {

  create_ordered_script("data-management", "temp/create-1-3")

  check_file_numbers("temp/create-1-3", 1:3)
  
  create_ordered_script("import", "temp/empty")
  check_file_numbers("temp/empty", 1)
  
  create_ordered_script("data-management", "temp/empty")
  check_file_numbers("temp/empty", 1:2)
})
