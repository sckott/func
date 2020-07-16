#' Load default parameter values 
#' 
#' For function(s) in a file
#'
#' @export
#' @param path Path to a file with one or more functions. required
#' @inheritParams func_load
#' @examples \dontrun{
#' tmpf <- tempfile(fileext=".R")
#' cat("fun <- function(bar = 5) bar + 1\n", file=tmpf)
#' func_load_path(path=tmpf)
#' bar
#' }
func_load_path <- function(path, envir=globalenv(), eval=TRUE) {
  tempenv <- new.env()
  source(path, local=tempenv)
  fxn <- get(ls(tempenv), envir=tempenv)
  func_load(fxn, envir=envir, eval=eval)
}
