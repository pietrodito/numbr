test_that("create_ordered_script works", {

  qcos <- purrr::quietly(create_ordered_script)
  qcos("data-management", "temp/create-1-3")

  check_file_numbers("temp/create-1-3", 1:3)
  
  qcos("import", "temp/empty")
  check_file_numbers("temp/empty", 1)
 
  qcos("data-management", "temp/empty")
  check_file_numbers("temp/empty", 1:2)
})
