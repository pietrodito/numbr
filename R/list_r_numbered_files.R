list_r_numbered_files <- function(path = "R") {
  ls_result <- as.character(list_r_files(path))
  regex_number_hyphen <- "[0-9]+-"
  numbers <- stringr::str_match(ls_result, regex_number_hyphen)
  numbers <- stringr::str_remove(numbers, "-")
  numbered <- ! is.na(numbers)
  names <- stringr::str_remove(ls_result[numbered], "[0-9]+-")
  numbers_as_char <- as.character(na.omit(numbers))
  numbers <- as.integer(numbers_as_char)

  files <- character()
  if(length(numbers) > 0) files <- paste0(numbers_as_char, "-", names)

  df <- data.frame(files = files,
                   names = names,
                   numbers = numbers,
                   numbers_as_char = numbers_as_char)

  df <- dplyr::arrange(df, numbers)

  as.list(df)
}
