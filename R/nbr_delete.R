#' This function deletes any script that matches one of the patterns passed as
#' parameter.
#' 
#' @param ... (chr) patterns used to select files for deletion
#' @param dir (chr) The target directory (default = "R")
#' @param confirm (lgl) If FALSE no confirmation is asked (default = T)
#' 
#' @export
nbr_delete <- function(..., dir = "R", confirm = T) {
  arguments <- unlist(list(...))
  ls_result <- list_r_numbered_files(dir)
  nb_files <- length(ls_result$files)

  if (nb_files > 0) {
    patterns <- rep(unlist(arguments), nb_files)
    files <-
      purrr::map(ls_result$files, ~ rep(., length(arguments)))
    files <- unlist(files)
    detection <- stringr::str_detect(files, patterns)
    detection <- matrix(detection, ncol = nb_files, byrow = F)

    colnames(detection) <- ls_result$files
    rownames(detection) <- arguments

    detection <- tibble::as_tibble(detection)
    detection$anycolxxx <- rowSums(detection) > 0

    is_there_any_match <- sum(detection$anycolxxx) > 0
    if (is_there_any_match) {
      detection <- dplyr::filter(detection, detection$anycolxxx)
      detection <- detection[,-ncol(detection)]

      messages <- purrr::map(seq_len(nrow(detection)),
                             function(i) {
                               list(pattern = arguments[i],
                                    detected = colnames(detection)[as.logical(detection[i,])])
                             })

      purrr::walk(messages, function(m) {
        message(paste(
          paste(m$pattern, "is in"),
          paste(m$detected, collapse = ", ")
        ))
      })

      detected <- unique(unlist(purrr::map(messages, ~ .$detected)))

      do_not_want_to_delete <- FALSE
      if (confirm) {
        do_not_want_to_delete <- utils::askYesNo(
          paste0(
            "All those files will be deleted:\n\n",
            paste(detected, collapse = "\n"),
            "\n\nContinue ?"
          ),
          default = TRUE,
          "No/Yes/Cancel"
        )
      }

      if (!is.na(do_not_want_to_delete) &
          !do_not_want_to_delete)  {
        detected <- paste0(dir, "/", detected)
        fs::dir_create(paste0(dir, "/Trash"))
        fs::file_move(detected, paste0(dir, "/Trash"))
      }
    }
  }
  reorder_scripts(dir)
  NULL
}