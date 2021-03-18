test_that("nbr_insert_at works", {
  
  nbr_insert_at(3, "data-management", "temp/insert-files-1-2-3", F)
  
  expect_equal(list_r_numbered_files("temp/insert-files-1-2-3")$files,
               c("1-script.R",
                 "2-script.R",
                 "3-data-management.R",
                 "4-script.R"))})


  nbr_insert_at(3, "HELLO", "temp/insert-twenty-files", F)

  expect_equal(list_r_numbered_files("temp/insert-twenty-files")$files,
              c(
                "01-script.R",
                "02-script.R",
                "03-HELLO.R",
                "04-script.R",
                "05-script.R",
                "06-script.R",
                "07-script.R",
                "08-script.R",
                "09-script.R",
                "10-script.R",
                "11-script.R",
                "12-script.R",
                "13-script.R",
                "14-script.R",
                "15-script.R",
                "16-script.R",
                "17-script.R",
                "18-script.R",
                "19-script.R",
                "20-script.R",
                "21-script.R"
              )
               )