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
#> <environment: 0x7fcd7bd862d8>
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
#> <environment: 0x7fcd7c991328>
```


## Meta

* Please [report any issues or bugs](https://github.com/sckott/func/issues).
* License: MIT
* Please note that this project is released with a [Contributor Code of Conduct][coc].
By participating in this project you agree to abide by its terms.

[coc]: https://github.com/sckott/func/blob/master/CODE_OF_CONDUCT.md
