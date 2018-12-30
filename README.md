
[![Build
Status](https://travis-ci.org/n8thangreen/QALY.svg?branch=master)](https://travis-ci.org/n8thangreen/CEdecisiontree)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/n8thangreen/QALY?branch=master&svg=true)](https://ci.appveyor.com/project/n8thangreen/CEdecisiontree)
[![Coverage
status](https://codecov.io/gh/n8thangreen/QALY/branch/master/graph/badge.svg)](https://codecov.io/github/n8thangreen/CEdecisiontree?branch=master)
[![experimental](http://badges.github.io/stability-badges/dist/experimental.svg)](http://github.com/badges/stability-badges)

<!-- README.md is generated from README.Rmd. Please edit that file -->

# CEdecisiontree

An R package for lightweight cost-effectiveness analysis using decision
trees.

Currently contains functions to:

  - matrix (wide, sparse) representation

## To do

Request welcome; please use
[Issues](https://github.com/n8thangreen/CEdecisiontree/issues)

  - fully integrate src

## Installing CEdecisiontree

To install the development version from github:

``` r
library(devtools)
install_github("n8thangreen/CEdecisiontree")
```

Then, to load the package, use:

``` r
library(CEdecisiontree)
```

## Motivation

Full probabilty models could be fit using a Bayesian model with
e.g. jags or WinBUGS but when all values are statistics from literature
or expert knowledge a simple, direct model is often built in Excel. This
is a analogue to these.

## Basic example

Quietly load libraries.

``` r
suppressWarnings(suppressMessages(library(CEdecisiontree)))
suppressWarnings(suppressMessages(library(readr)))
suppressWarnings(suppressMessages(library(dplyr)))
suppressWarnings(suppressMessages(library(reshape2)))
suppressWarnings(suppressMessages(library(tidyr)))
```

We will consider a simple 7 node binary
tree.

<img src="figures/README_decisiontree_silverdecisions.png" width="400px" />

Load example data from the package.

``` r
data("cost")
data("probs")
```

The cost and probability matrices we will use in this example are sparse
arrays indicating the edge values (rows=from node, columns=to node).
There are therefore the same dimensions and have the same entry pattern.
Empty cells have `NA`.

``` r
cost
#> # A tibble: 3 x 7
#>     `1`   `2`   `3`   `4`   `5`   `6`   `7`
#>   <dbl> <int> <int> <int> <int> <int> <int>
#> 1    NA    10     1    NA    NA    NA    NA
#> 2    NA    NA    NA    10     1    NA    NA
#> 3    NA    NA    NA    NA    NA    10     1
```

``` r
probs
#> # A tibble: 3 x 7
#>     `1`   `2`   `3`   `4`   `5`   `6`   `7`
#>   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1    NA   0.2   0.8  NA    NA    NA    NA  
#> 2    NA  NA    NA     0.2   0.8  NA    NA  
#> 3    NA  NA    NA    NA    NA     0.2   0.8
```

The expected value at each node is calculate as follows.

``` r
dectree_expected_values(vals = cost,
                        p = probs)
#> [[1]]
#> [1] 5.6
#> 
#> [[2]]
#> [1] 2.8
#> 
#> [[3]]
#> [1] 2.8
#> 
#> [[4]]
#> [1] 0
#> 
#> [[5]]
#> [1] 0
#> 
#> [[6]]
#> [1] 0
#> 
#> [[7]]
#> [1] 0
```

There is also an Rcpp version of this function.

``` r
Cdectree_expected_values(vals = as.matrix(cost),
                         p = as.matrix(probs))
#> [1] 5.6 2.8 2.8 0.0 0.0 0.0 0.0
```

## Long arrays

Clearly, as the size of the tree increased the sparse matrix become
impractical. We can provide a long format array to address this. Let us
transform the wide array used previously to demonstrate the structure
and space saving.

``` r
probs_long <-
  probs %>%
  mutate('from' = rownames(.)) %>%
  melt(id.vars = "from",
       variable.name = 'to',
       value.name = 'prob') %>%
  na.omit()
#> Warning: package 'bindrcpp' was built under R version 3.4.4

cost_long <-
  cost %>%
  mutate('from' = rownames(.)) %>%
  melt(id.vars = "from",
       variable.name = 'to',
       value.name = 'cost') %>%
  na.omit()

merge(probs_long,
      cost_long)
#>   from to prob cost
#> 1    1  2  0.2   10
#> 2    1  3  0.8    1
#> 3    2  4  0.2   10
#> 4    2  5  0.8    1
#> 5    3  6  0.2   10
#> 6    3  7  0.8    1
```

## Other tree statistics

For additional information, inclusing for the purposes of model checking
we can calculate other tree statistics. We can obtain the contributing
cost as weighted by the chance of occurrence. This can be thought of as
a trade-off between the raw, original cost and branch position.

``` r
wcost <- branch_joint_probs(probs) * cost
wcost
#>    1  2   3   4    5   6    7
#> 1 NA  2 0.8  NA   NA  NA   NA
#> 2 NA NA  NA 0.4 0.16  NA   NA
#> 3 NA NA  NA  NA   NA 1.6 0.64
```

We can check that this sums to the same total expected cost.

``` r
sum(wcost, na.rm = TRUE)
#> [1] 5.6
```

We can also calculate the joint probabilities of traversing to each
terminal state using `branch_joint_probs`. Here we assume node labelling
order from root such that terminal nodes are last.

``` r
n_from_nodes <- nrow(probs)
terminal_states <- (n_from_nodes + 1):n_from_nodes

p_terminal_state <-
  branch_joint_probs(probs)[ ,terminal_states] %>%
  colSums(na.rm = TRUE)

p_terminal_state
#>    4    3 
#> 0.04 0.80
sum(p_terminal_state)
#> [1] 0.84
```

See package
[vignette](http://htmlpreview.github.io/?https://github.com/n8thangreen/CEdecisiontree/blob/master/inst/doc/vignette_main.html)
for more details and examples.

## License

GPL-3 ©
