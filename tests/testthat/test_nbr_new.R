test_that("nbr_new works", {

  qnew <- purrr::quietly(nbr_new)
  qnew("data-management", "temp/create-1-3", edit_file = F)

  check_file_numbers("temp/create-1-3", 1:3)
  
  qnew("import", "temp/empty", edit_file = F)
  check_file_numbers("temp/empty", 1)
 
  qnew("data-management", "temp/empty", edit_file = F)
  check_file_numbers("temp/empty", 1:2)
})
