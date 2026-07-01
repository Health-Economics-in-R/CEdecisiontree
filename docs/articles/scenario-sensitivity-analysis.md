<div id="main" class="col-md-9" role="main">

# Scenario Sensitivity Analysis

<div class="section level2">

## Introduction

Scenario (or deterministic) sensitivity analysis is a common part of any
cost-effectiveness analysis \[@Briggs2012\]. Here we will carry this out
for a simple decision tree. This involves explicitly specifying values
for particular branch probability and/or values and calculating the
total expected value.

</div>

<div class="section level2">

## Example

<div id="cb1" class="sourceCode">

``` r
library(CEdecisiontree, quietly = TRUE)
library(assertthat, quietly = TRUE)
library(tibble, quietly = TRUE)
library(tidyverse, quietly = TRUE)
library(purrr, quietly = TRUE)
```

</div>

We create a complete design meaning all combinations on the grid of
input values. Alternatively, we may only want to do a one-way analysis
and so would set the non-varied term to some common baseline
distribution or fixed value. In our example, we will choose three values
for each parameter. We can think of this as a worst-, most likely and
best-case scenario.

<div id="cb2" class="sourceCode">

``` r
p <- c(NA_real_, 0.4, 0.6)

c2 <- c(10, 50, 100)
c3 <- c(5, 40, 150)

c_grid <-
  expand.grid(c2 = c2,
              c3 = c3) %>% 
  cbind(c1 = 0L, .) %>% 
  t() %>% 
  as.data.frame()

c_grid
#>    V1 V2  V3 V4 V5  V6  V7  V8  V9
#> c1  0  0   0  0  0   0   0   0   0
#> c2 10 50 100 10 50 100  10  50 100
#> c3  5  5   5 40 40  40 150 150 150
```

</div>

Then define the decision tree structure as just a basic binary tree.

<div id="cb3" class="sourceCode">

``` r
child <- list("1" = c(2, 3),
              "2" = NULL,
              "3" = NULL)
```

</div>

We can now loop over the inputs and generate a complete tree object for
each cost combination.

<div id="cb4" class="sourceCode">

``` r
tree_dat_sa <- list()

for (i in seq_along(c_grid)) {
  
  tree_dat_sa[[i]] <-
    define_model(
      tree_dat =
        list(child = child,
             dat = data.frame(
               node = names(child),
               prob = p,
               vals = c_grid[[i]])
        ))
}
```

</div>

This results in a list of trees.

<div id="cb5" class="sourceCode">

``` r
tree_dat_sa[[1]]
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
#> 2    2  0.4   10
#> 3    3  0.6    5
#> 
#> attr(,"class")
#> [1] "tree_dat" "list"
```

</div>

Now, it is straightforward to map over each of these trees to obtain the
total expected values.

<div id="cb6" class="sourceCode">

``` r
res <- map_dbl(tree_dat_sa, ~dectree_expected_values(.)[1])
res
#> [1]   7  23  43  28  44  64  94 110 130
```

</div>

<div class="section level3">

### Tornado plot

Lets create a tornado plot showing a one-way sensitivity analysis. We’ll
use my `ceplot`. By specifying the output data as a model frame it is
handled appropriately.

<div id="cb7" class="sourceCode">

``` r
library(ceplot)
library(reshape2)
library(magrittr)
library(plyr)
library(purrr)
library(dplyr)
library(ggplot2)

sa_dat <- as.data.frame(cbind(t(c_grid), res))

sa_model_dat <- model.frame(formula = res ~ c1 + c2 + c3,
                            data = sa_dat)

##TODO: ceplot package build error
# sa_model_dat %>%
#   ceplot::create_tornado_data() %>%
#   ceplot::ggplot_tornado() 
```

</div>

</div>

</div>

</div>
