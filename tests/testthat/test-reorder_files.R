test_that("reorder files works", {

  check_file_order <- purrr::quietly(check_file_order)

  reorder_scripts("temp/files-1-2-unnumbered-and-not-R-files")
  expect_equal(
    check_file_order("temp/files-1-2-unnumbered-and-not-R-files")$result,
    TRUE)

  reorder_scripts("temp/files-1-3")
  expect_equal(check_file_order("temp/files-1-3")$result, TRUE)
})
