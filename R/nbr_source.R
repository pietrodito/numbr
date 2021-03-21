#' Source script and all previous script that have been modified
#' since last time they were sourced.
#' 
#' @param script (chr) The name of the script file
#' @param dir (chr) The target directory (default = "R")
#' @param confirm_duraion (int) duration threshold to ask for confirmation (ms) 
#' 
#' @export
nbr_source <- function(script,
                       dir = "R",
                       confirm_duration = 15*1e3) {
  
  format_dir <- function(dir) paste0(stringr::str_remove(dir, "/*$"), "/")
  dir <- format_dir(dir)
  
  metadata_dir <- paste0(dir, "/.nbr/")
  create_metadir_if_necessary <- function() {
    if (!fs::dir_exists(metadata_dir))
      fs::dir_create(metadata_dir)
  }
  create_metadir_if_necessary()
  
  move_metafiles <- function(from, dest)
    fs::file_move(fs::dir_ls(from, regexp = ".*(data|info)$"), dest)
  move_metafiles(metadata_dir, dir)
  withr::defer((move_metafiles(dir, metadata_dir)))
  
  get_numbered_script_info <- function() {
    regex_numbered_scripts <- "[0-9]+-.*\\.R"
    ls_result <-
        as.character(fs::dir_ls(dir, regexp = regex_numbered_scripts))
    scripts <- stringr::str_remove(ls_result, dir)
    fs::file_info(paste0(dir, scripts))
  }
  
  infos <- get_numbered_script_info()
  
  (
    infos
    %>% dplyr::mutate(
     extension = as.character(stringr::str_match(infos$path, "\\.[Rr].*")),
     extension =  factor(extension, 
                         levels = c(".R", ".R.Rdata", ".R.info")),
     name = stringr::str_remove(infos$path, dir),
     name = stringr::str_remove(name, "\\.[Rr].*"))
    %>% dplyr::select(c("name", "extension", "modification_time"))
  %>% tidyr::spread(
      key = extension,
      value = modification_time,
      drop = F)
    %>% dplyr::filter(name < script)
    %>% dplyr::mutate(
      has_changed = .R > .R.Rdata)
  ) -> infos
  infos$has_changed = tidyr::replace_na(infos$has_changed, T)
  
  if (any(infos$has_changed)) {
    last_unchanged <- min(which(infos$has_changed)) - 1
    infos$need_rerun <- seq_len(nrow(infos)) > last_unchanged
    
    last_state <- new.env()
    if (last_unchanged > 0)
      last_state <-
      readr::read_rds(paste0(dir, infos$name[last_unchanged], ".R.Rdata"))
    
    scripts_to_source <- dplyr::filter(infos, infos$need_rerun)
    
    
    source_and_write_duration <- function(name, envir) {
      filepath <- paste0(dir, name, ".R")
      info_file <- paste0(filepath, nbr_info_suffix)
      want_to_source <- TRUE
      if (fs::file_exists(info_file)) {
        last_duration <- readr::read_rds(info_file)
        if (last_duration > confirm_duration) {
          want_to_source <- utils::askYesNo(
            paste0(
              "> ", name, ".R last execution duration was: ", last_duration,"ms\n",
              "Continue ?"
            ),
            default = TRUE,
            "Yes/No/Cancel"
          )
        }
      }
      
      if (!is.na(want_to_source) &
          want_to_source)  {
        duration <- tryCatch(
            error = function(cnd) {
              stop("in ", name, ".R: ", conditionMessage(cnd), call. = F)},
            ceiling(microbenchmark::microbenchmark(source(filepath, local = envir),
                                         times = 1L)$time / 1e6))
        message(paste0(name, ".R sourced in ", duration, "ms"))
        readr::write_rds(duration, paste0(filepath, nbr_info_suffix))
        readr::write_rds(envir, paste0(filepath, nbr_data_suffix))
      }
    }
    
    purrr::walk(scripts_to_source$name,
                ~ source_and_write_duration(., envir = last_state))
    list2env(as.list(last_state), .GlobalEnv)
    rm(last_state)
  }
}
