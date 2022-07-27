
# CEdecisiontree <img src="man/figures/hexbadge.png" height="139" align="right"/>

<!-- badges: start -->

[![R-CMD-check](https://github.com/Health-Economics-in-R/CEdecisiontree/workflows/R-CMD-check/badge.svg)](https://github.com/Health-Economics-in-R/CEdecisiontree/actions)
[![Coverage
status](https://codecov.io/gh/Health-Economics-in-R/CEdecisiontree/branch/master/graph/badge.svg)](https://codecov.io/github/Health-Economics-in-R/CEdecisiontree?branch=master)
[![experimental](http://badges.github.io/stability-badges/dist/experimental.svg)](http://github.com/badges/stability-badges)
[![R-CMD-check](https://github.com/Health-Economics-in-R/CEdecisiontree/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Health-Economics-in-R/CEdecisiontree/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

<!-- README.md is generated from README.Rmd. Please edit that file -->

> An R package for lightweight cost-effectiveness analysis using
> decision trees.

Requests and comments welcome; please use
[Issues](https://github.com/n8thangreen/CEdecisiontree/issues).

## Installing CEdecisiontree

To install the development version from github:

``` r
library(remotes)
install_github("Health-Economics-in-R/CEdecisiontree")
```

Then, to load the package, use:

``` r
library(CEdecisiontree)
```

## Motivation

Decisions trees can be modelled as special cases of more general models
using available packages in R e.g. heemod, mstate or msm. Further, full
probability models could be fit using a Bayesian model with e.g. Stan,
jags or WinBUGS. However, simple decision tree models are often built in
Excel, using statistics from literature or expert knowledge. This
package is a analogue to these, such that models can be specified in a
very similar and simple way.

## Calculation

A decision tree is defined by parent-child pairs, i.e. from-to
connections, and the probability and associated value (e.g. cost) of
traversing each of the connections. Denote the probability of
transitioning from node
![i](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i "i")
to
![j](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;j "j")
as
![p\_{ij}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;p_%7Bij%7D "p_{ij}")
and the cost attributable to node
![i](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i "i")
as
![c_i](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;c_i "c_i").
Where no connection exists between two nodes we shall say that the
parent’s set of children is the empty set
![\emptyset](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cemptyset "\emptyset").
Denote the set of children by
![child(\cdot)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;child%28%5Ccdot%29 "child(\cdot)").
Clearly, there are no
![p\_{ij}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;p_%7Bij%7D "p_{ij}")
or
![c_j](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;c_j "c_j")
in this case but for computational purposes we will assume that
![p\_{ij} = NA](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;p_%7Bij%7D%20%3D%20NA "p_{ij} = NA")
and
![c_j = 0](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;c_j%20%3D%200 "c_j = 0").

The expected value at each node
![i \in S](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i%20%5Cin%20S "i \in S")
is calculated by ‘folding back’ using the recursive formula

<img src="https://latex.codecogs.com/svg.image?\hat{c}_i&space;=&space;c_i&space;&plus;&space;\sum_{j&space;\in&space;child(i)}&space;p_{ij}&space;\hat{c}_j" title="\hat{c}_i = c_i + \sum_{j \in child(i)} p_{ij} \hat{c}_j" />

with boundary values at the terminal nodes

<img src="https://latex.codecogs.com/svg.image?\hat{c}_i&space;=&space;c_i&space;\mbox{&space;for&space;}&space;i&space;=&space;\{&space;S:&space;child(s)&space;=&space;\emptyset&space;\}" title="\hat{c}_i = c_i \mbox{ for } i = \{ S: child(s) = \emptyset \}" />

## Basic example

Quietly load libraries.

``` r
library(CEdecisiontree)
library(readr)
library(dplyr)
library(reshape2)
library(tidyr)
library(assertthat)
```

We will consider a simple 7 node binary tree. Numeric labels are shown
above each node. Probabilities and costs are show above and below each
branch, respectively.

<img src="https://raw.githubusercontent.com/Health-Economics-in-R/CEdecisiontree/dev/man/figures/README_decisiontree_silverdecisions.png" width="400px" />

So if we were to write out the expected cost in full this would give

<img src="https://latex.codecogs.com/svg.image?p_{12}(c_{12}&space;&plus;&space;p_{24}c_{24}&space;&plus;&space;p_{25}c_{25})&space;&plus;&space;p_{13}(c_{13}&space;&plus;&space;p_{36}c_{36}&space;&plus;&space;p_{37}c_{37})" title="p_{12}(c_{12} + p_{24}c_{24} + p_{25}c_{25}) + p_{13}(c_{13} + p_{36}c_{36} + p_{37}c_{37})" />

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
#> # A tibble: 3 × 7
#>     `1`   `2`   `3`   `4`   `5`   `6`   `7`
#>   <dbl> <int> <int> <int> <int> <int> <int>
#> 1    NA    10     1    NA    NA    NA    NA
#> 2    NA    NA    NA    10     1    NA    NA
#> 3    NA    NA    NA    NA    NA    10     1
```

``` r
probs
#> # A tibble: 3 × 7
#>     `1`   `2`   `3`   `4`   `5`   `6`   `7`
#>   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1    NA   0.2   0.8  NA    NA    NA    NA  
#> 2    NA  NA    NA     0.2   0.8  NA    NA  
#> 3    NA  NA    NA    NA    NA     0.2   0.8
```

`probs` is a probability transition matrix. This is like `pmatrix.msm`
in the `msm` package, or `define_transition` in the `heemod` package.

The `transMat()` function in the `mstate` package creates a closely
related multi-state model transition matrix. Copying this package, we
can create a decision tree transition matrix to use with this.

``` r
CEdecisiontree:::trans_binarytree(depth = 3)
#>     to
#> from  1  2  3  4  5  6  7
#>    1 NA  1  2 NA NA NA NA
#>    2 NA NA NA  3  4 NA NA
#>    3 NA NA NA NA NA  5  6
```

The expected value at each node is calculate as follows.

``` r
my_model <-
  define_model(
    transmat = list(vals = cost,
                    prob = probs))

dectree_expected_values(model = my_model)
#>    1    2    3    4    5    6    7 
#>  5.6 12.8  3.8 10.0  1.0 10.0  1.0
```

There is also an Rcpp version of this function.

``` r
Cdectree_expected_values(vals = as.matrix(cost),
                         p = as.matrix(probs))
```

## Other tree statistics

For additional information, including for the purposes of model checking
we can calculate other tree statistics. We can obtain the contributing
cost as weighted by the chance of occurrence. This can be thought of as
a trade-off between the raw, original cost and branch position.

``` r
wcost <- branch_joint_probs(my_model) * cost
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
terminal state using `branch_joint_probs`. This is useful when an
alternative model set-up is used such that total costs and health values
are assigned to these terminal nodes only. Here we assume node labelling
order from root such that terminal nodes are last.

``` r
n_from_nodes <- nrow(probs)
n_to_nodes <- ncol(probs)
terminal_states <- (n_from_nodes + 1):n_to_nodes

p_terminal_state <-
  branch_joint_probs(my_model)[ ,terminal_states] %>%
  colSums(na.rm = TRUE)

p_terminal_state
#>    4    5    6    7 
#> 0.04 0.16 0.16 0.64
sum(p_terminal_state)
#> [1] 1
```

See package
[vignettes](https://health-economics-in-r.github.io/CEdecisiontree/articles/)
for more details and examples.

## Code of Conduct

Please note that the CEdecisiontree project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## License

[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
