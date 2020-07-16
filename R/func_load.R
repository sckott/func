#' Load default parameter values
#' 
#' For a function or list of functions
#'
#' @export
#' @param fun Function object, not character name of function
#' @param envir Environment to load default parameters in to.
#' Default: `globalenv()`
#' @examples \dontrun{
#' # one function
#' foo <- function(w=5, y=4) w+y
#' func_load(foo)
#' w; y
#'
#' # many functions
#' foo <- function(w=5, y=4) w+y
#' bar <- function(a="a", b="b") c(a,b)
#' func_load(c(foo, bar))
#' w; y; a; b
#' }
func_load <- function(fun, envir=globalenv()) {
  assert(fun, c("function", "list"))
  if (length(fun) == 1) {
    invisible(iter(fun, envir))
  } else {
    lapply(fun, assert, y = "function")
    invisible(lapply(fun, iter, envir=envir))
  }
}

iter <- function(x, envir) {
  argslist <- as.list(x, all=TRUE)
  args <- pop(argslist)
  for (i in seq_along(args)) {
    assign(names(args[i]), args[[i]], envir=envir)
  }
}

# drop last element of list or vector
pop <- function(x) x[-length(x)]
