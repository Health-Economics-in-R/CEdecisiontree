<div id="main" class="col-md-9" role="main">

# A simple cost-effectiveness analysis

<div class="section level2">

## Introduction

Although the `CEdecisiontree` package allows us to do calculations using
different values separately, the main purpose is to carry out
cost-effectiveness analyses. This is performed calling the `dectree()`
function for cost and health inputs using the wrapper `run_cedectree()`.

</div>

<div class="section level2">

## Example

<div id="cb1" class="sourceCode">

``` r
library(CEdecisiontree)
library(purrr)
library(tibble)
```

</div>

For a single outcome type

<div id="cb2" class="sourceCode">

``` r
tree_dat <- 
  tribble(
    ~from, ~to, ~vals, ~prob, 
    1,  2,   10,   0.7, 
    1,  3,   NA,   0.3, 
    2,  4,  100,   0.1, 
    2,  5,   NA,   0.9, 
    3,  6,  100,   0.9, 
    3,  7,   NA,   0.1)
```

</div>

The function `dectree()` requires the dataframe defining the tree above.
Optionally, it can also take PSA distributions on probabilities and
values, a PSA sample size `n`, and a list of groups of nodes
`state_list`. It then returns expected values for point estimates, and
for PSA if supplied. Also, pathway joint probabilities are returned if
states are provided.

<div id="cb3" class="sourceCode">

``` r
dectree(tree_dat,
        state_list = list(all = c(4,5,6,7)))
#> vals used for calculation.
#> $ev_point
#>   1   2   3   4   5   6   7   8 
#>  41  20  90 100   0 100   0   0 
#> 
#> $term_pop_point
#> $term_pop_point$all
#> [1] 1
```

</div>

For cost-effectiveness analysis including PSA

<div id="cb4" class="sourceCode">

``` r
# run_cedectree(tree_dat)
```

</div>

</div>

</div>
