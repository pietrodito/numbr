expect_everything <- function(quiet_call, result, message = NA, warning = NA) {

  empty_char_if_na <- function(x) if(is.na(x)) character() else x
  message <- empty_char_if_na(message)
  warning <- empty_char_if_na(warning)

  search_into <- function(expected, actuals) {
   if(length(expected) != 0)
     expect_true(any(stringr::str_detect(actuals, expected)))
   else
     expect_true(length(actuals) == 0)
  }

  expect_equal(quiet_call$result, result)
  search_into(message, quiet_call$messages)
  search_into(warning, quiet_call$warnings)
}
