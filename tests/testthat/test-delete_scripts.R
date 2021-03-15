test_that("delete_scripts works", {

  qdf <- purrr::quietly(delete_scripts)

  qdf("temp/delete-1-3-4", "data", confirm = F)
  check_file_numbers("temp/delete-1-3-4", c(1,4))

  qdf("temp/delete-1-3-4", "3", confirm = F)
  check_file_numbers("temp/delete-1-3-4", c(1, 4))


  qdf("temp/delete-1-3-4", "tab", confirm = F)
  check_file_numbers("temp/delete-1-3-4", c(1))

  qdf("temp/delete-1-3-4", "1", confirm = F)
  check_file_numbers("temp/delete-1-3-4", numeric())
})
