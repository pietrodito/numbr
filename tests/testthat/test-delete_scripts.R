test_that("nbr_delete works", {

  q_nbr_delete <- purrr::quietly(nbr_delete)

  expect_everything(q_nbr_delete( "data", path = "temp/delete-1-3-4", confirm = F),
                    NULL,
                    c("data is in 3-data-management.R")
                    ) 
  
  check_file_numbers("temp/delete-1-3-4", c(1,2))

  q_nbr_delete("3", path = "temp/delete-1-3-4", confirm = F)
  check_file_numbers("temp/delete-1-3-4", c(1, 2))

  q_nbr_delete("tab", path = "temp/delete-1-3-4", confirm = F)
  check_file_numbers("temp/delete-1-3-4", c(1))

  q_nbr_delete("1", path = "temp/delete-1-3-4", confirm = F)
  check_file_numbers("temp/delete-1-3-4", numeric())
  
  expect_equal(list_r_numbered_files("temp/delete-1-3-4/Trash")$files,
               c("1-import.R", "2-table-1.R", "3-data-management.R"))
  
})
