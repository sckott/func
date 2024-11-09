func
====



[![R-check](https://github.com/sckott/func/workflows/R-check/badge.svg)](https://github.com/sckott/func/actions/)


`func` - tools for function development

## Installation


```r
install.packages("remotes")
remotes::install_github("sckott/func")
```


```r
library('func')
```

## usage

- `func_load()`: load default parameter values for a function or vector/list of functions


```r
mars <- function() 5
venus <- function(z = mars(), m = list(goo = "bar"), v = function(e) e) {
  list(z, z, v)
}
mars()
#> [1] 5
venus()
#> [[1]]
#> [1] 5
#> 
#> [[2]]
#> [1] 5
#> 
#> [[3]]
#> function(e) e
#> <environment: 0x7f98b10b9988>
z
#> Error in eval(expr, envir, enclos): object 'z' not found
m
#> Error in eval(expr, envir, enclos): object 'm' not found
v
#> Error in eval(expr, envir, enclos): object 'v' not found
func_load(venus)
class(z); z
#> [1] "numeric"
#> [1] 5
class(m); m
#> [1] "list"
#> $goo
#> [1] "bar"
class(v); v
#> [1] "function"
#> function(e) e
#> <environment: 0x7f98b367bdc8>
```

- `func_load_path()`: same as `func_load()`, but for functions in a file


```r
tmpf <- tempfile(fileext=".R")
cat("myfunc <- function() 2\nfun <- function(bar = 5, zzz = myfunc()) bar + 1\n", file=tmpf)
func_load_path(path=tmpf)
bar
#> [1] 5
zzz
#> [1] 2
```


## Meta

* Please [report any issues or bugs](https://github.com/sckott/func/issues).
* License: MIT
* Please note that this project is released with a [Contributor Code of Conduct][coc].
By participating in this project you agree to abide by its terms.

[coc]: https://github.com/sckott/func/blob/main/CODE_OF_CONDUCT.md
