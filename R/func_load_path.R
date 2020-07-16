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
  fxns <- lapply(ls(tempenv), get, envir=tempenv)
  invisible(lapply(fxns, each_fun_from_path, envir = envir, eval = eval,
    env_from = tempenv))
}

each_fun_from_path <- function(x, envir, eval, env_from) {
  argslist <- as.list(x, all=TRUE)
  args <- pop(argslist)
  for (i in seq_along(args)) {
    z <- if (eval && is.call(args[[i]])) rlang::eval_tidy(args[[i]], env=env_from) else args[[i]]
    assign(names(args[i]), z, envir=envir)
  }
}
