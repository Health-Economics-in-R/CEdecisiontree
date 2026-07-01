<div id="main" class="col-md-9" role="main">

# Define decision tree model

<div class="ref-description section level2">

Basic constructor for decision tree classes for different data formats.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
define_model(transmat, tree_dat, dat_long, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   transmat:

    Transition probability matrix. Rows are from nodes and columns are
    to nodes.

-   tree_dat:

    Hierarchical tree structure of parents and children in a list of
    vectors with integer values.

-   dat_long:

    Long format data frame with from, to, prob, vals columns.

-   ...:

    additional arguments

</div>

<div class="section level2">

## Value

transmat, tree_dat or dat_long class object

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
define_model(transmat =
              list(prob = matrix(data=c(NA, 0.5, 0.5), nrow = 1),
                   vals = matrix(data=c(NA, 1, 2), nrow = 1)
              ))
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

define_model(tree_dat =
              list(child = list("1" = c(2, 3),
                                "2" = NULL,
                                "3" = NULL),
                   dat = data.frame(node = 1:3,
                                    prob = c(NA, 0.5, 0.5),
                                    vals = c(0, 1, 2))
              ))
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

define_model(dat_long = data.frame(from = c(NA, 1, 1),
                                   to = 1:3,
                                   prob = c(NA, 0.5, 0.5),
                                   vals = c(0, 1, 2)))
#>   from to prob vals
#> 1   NA  1   NA    0
#> 2    1  2  0.5    1
#> 3    1  3  0.5    2
#> 4    2  4   NA    0
#> 5    3  4   NA    0
```

</div>

</div>

</div>
