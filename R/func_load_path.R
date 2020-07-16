#' Load default parameter values 
#' 
#' From a file
#'
#' @export
#' @param path Path to a file with one or more functions.
#' required
#' @param envir Environment to load default parameters in to.
#' Default: .GlobalEnv
#' @examples \dontrun{
#' tmpf <- tempfile(fileext=".R")
#' cat("fun <- function(bar = 5) bar + 1\n", file=tmpf)
#' func_load_path(path=tmpf)
#' bar
#' }
func_load_path <- function(path, envir=globalenv()) {
  tempenv <- new.env()
  source(path, local=tempenv)
  fxn <- get(ls(tempenv), envir=tempenv)
  func_load(fxn, envir=envir)
}
