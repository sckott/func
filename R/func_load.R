#' Load default parameter values
#' 
#' Of a function or list of functions
#'
#' @export
#' @param fun Function object, not character name of function
#' @param envir Environment to load default parameters in to.
#' Default: `globalenv()`
#' @examples \dontrun{
#' # A single function
#' foo <- function(x=5, y=4) x+y
#' func_load(foo)
#' x; y
#'
#' # Many functions
#' foo <- function(x=5, y=4) x+y
#' bar <- function(a="a", b="b") c(a,b)
#' func_load(c(foo, bar))
#' x; y; a; b
#' }
func_load <- function(fun, envir=globalenv()) {
  iter <- function(x) {
    argslist <- as.list(x, all=TRUE)
    args <- argslist[-length(argslist)]
    for (i in seq_along(args)) {
      assign(names(args[i]), args[[i]], envir=envir)
    }
  }

  if (length(fun) == 1) {
    invisible(iter(fun))
  } else {
    invisible(lapply(fun, iter))
  }
}
