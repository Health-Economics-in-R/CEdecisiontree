<div id="main" class="col-md-9" role="main">

# Using function dispatch

<div class="section level2">

## Introduction

So far, we have passed particular data formats to
`dectree_expected_values`, where we need to be explicit about which
arguments they are associated with. Alternatively, we can define the
model upfront and then pass this object to `dectree_expected_values` for
it to dispatch to the appropriate function using S3.

</div>

<div class="section level2">

## Example

<div id="cb1" class="sourceCode">

``` r
library(CEdecisiontree)
library(dplyr)
library(assertthat)
```

</div>

Let us create 3 input variables, in line with the 3 formats we have met
already, using the `define_model` function.

<div id="cb2" class="sourceCode">

``` r
model_transmat <- 
  define_model(transmat =
                 list(prob = matrix(data = c(NA, 0.5, 0.5), nrow = 1),
                      vals = matrix(data = c(NA, 1, 2), nrow = 1)
                 ))
model_transmat
#> $prob
#>      [,1] [,2] [,3]
#> [1,]   NA  0.5  0.5
#> 
#> $vals
#>      [,1] [,2] [,3]
#> [1,]   NA    1    2
#> 
#> attr(,"class")
#> [1] "transmat" "list"

model_tree <- 
  define_model(tree_dat =
                 list(child = list("1" = c(2, 3),
                                   "2" = NULL,
                                   "3" = NULL),
                      dat = data.frame(node = 1:3,
                                       prob = c(NA, 0.5, 0.5),
                                       vals = c(0, 1, 2))
                 ))
model_tree
#> $child
#> $child$`1`
#> [1] 2 3
#> 
#> $child$`2`
#> NULL
#> 
#> $child$`3`
#> NULL
#> 
#> 
#> $dat
#>   node prob vals
#> 1    1   NA    0
#> 2    2  0.5    1
#> 3    3  0.5    2
#> 
#> attr(,"class")
#> [1] "tree_dat" "list"

model_long <- 
  define_model(dat_long = data.frame(from = c(NA,1, 1),
                                     to = c(1, 2, 3),
                                     prob = c(NA, 0.5, 0.5),
                                     vals = c(0, 1, 2)))
model_long
#>   from to prob vals
#> 1   NA  1   NA    0
#> 2    1  2  0.5    1
#> 3    1  3  0.5    2
#> 4    2  4   NA    0
#> 5    3  4   NA    0
```

</div>

Now it is simply a case of passing this to main function call.

<div id="cb3" class="sourceCode">

``` r
dectree_expected_values(model_transmat)
#> [1] 1.5 1.0 2.0
dectree_expected_values(model_tree)
#>   1   2   3 
#> 1.5 1.0 2.0
dectree_expected_values(model_long)
#> vals used for calculation.
#>   1   2   3   4 
#> 1.5 1.0 2.0 0.0
```

</div>

</div>

</div>
