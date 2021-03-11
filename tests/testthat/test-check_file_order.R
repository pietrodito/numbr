test_that("check_file_order works", {

  check_file_order <- purrr::quietly(check_file_order)

  expect_everything(check_file_order("temp/files-1-2"), TRUE)

  expect_everything(check_file_order("temp/files-1-2-unnumbered-and-not-R-files"),
                    TRUE,
                    unnumbered_message)

  expect_everything(check_file_order("temp/files-1-3"),
                    FALSE)

  expect_everything(check_file_order("temp/files-2-5"),
                    FALSE)
})
