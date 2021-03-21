test_that("move_script works", {
  
  move_script("1-script.R", "4-test.R",
              path = "temp/move-files-1-2-3-data-info")
  
  expect_equal(sort(as.character(
    fs::dir_ls("temp/move-files-1-2-3-data-info"))),
               paste0("temp/move-files-1-2-3-data-info/",
                      sort(c("2-script.R", "3-script.R", "4-test.R"))))
  
  expect_equal(sort(as.character(
    fs::dir_ls("temp/move-files-1-2-3-data-info/.nbr/"))),
               paste0("temp/move-files-1-2-3-data-info/.nbr/",
                            sort(c(
                               paste0(c("2-script.R", "3-script.R", "4-test.R"),
                                    nbr_data_suffix),
                            paste0(c("2-script.R", "3-script.R", "4-test.R"),
                                   nbr_info_suffix)))))
})
