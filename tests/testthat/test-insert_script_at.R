test_that("insert_script_at works", {
  
  insert_script_at("temp/insert-files-1-2-3", 3, "data-management")
  
  expect_equal(list_r_numbered_files("temp/insert-files-1-2-3")$files,
               c("1-script.R",
                 "2-script.R",
                 "3-data-management.R",
                 "4-script.R"))})
