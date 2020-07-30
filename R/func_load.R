#' Load default parameter values
#' 
#' For a function or list of functions
#'
#' @export
#' @param fun (function) Function object, not character name of function.
#' required
#' @param envir Environment to load default parameters in to.
#' Default: `globalenv()`. required
#' @param eval (logical) evaluate `call`s?. default: `TRUE`. If `TRUE`, 
#' any parameter values that have class `call` will be run through
#' `rlang::eval_tidy()`. For example: lists, anonymous functions, function
#' calls themselves. required
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
#' 
#' # function with a function as a default parameter
#' mars <- function() 5
#' venus <- function(z = mars(), m = list(goo = "bar"), v = function(e) e) {
#'   list(z, z, v)
#' }
#' mars()
#' venus()
#' z
#' m
#' v
#' func_load(venus)
#' class(z); z
#' class(m); m
#' class(v); v
#' 
#' ## eval=FALSE
#' func_load(venus, eval=FALSE)
#' class(z); z
#' class(m); m
#' class(v); v
#' }
func_load <- function(fun, envir=globalenv(), eval=TRUE) {
  assert(fun, c("function", "list"))
  if (length(fun) == 1) {
    invisible(each_fun(fun, envir, eval))
  } else {
    lapply(fun, assert, y = "function")
    invisible(lapply(fun, each_fun, envir=envir, eval=eval))
  }
}

each_fun <- function(x, envir, eval) {
  argslist <- as.list(x, all=TRUE)
  args <- pop(argslist)
  for (i in seq_along(args)) {
    if (is.name(args[[i]])) next
    z <- if (eval && is.call(args[[i]])) rlang::eval_tidy(args[[i]]) else args[[i]]
    assign(names(args[i]), z, envir=envir)
  }
}

# drop last element of list or vector
pop <- function(x) x[-length(x)]
