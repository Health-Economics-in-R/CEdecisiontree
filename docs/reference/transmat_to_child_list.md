<div id="main" class="col-md-9" role="main">

# Create tree children list from transition matrix

<div class="ref-description section level2">

Create tree children list by parents from a transition matrix.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
transmat_to_child_list(transmat)
```

</div>

</div>

<div class="section level2">

## Arguments

-   transmat:

    Transition probability matrix. Rows are from nodes and columns are
    to nodes.

</div>

<div class="section level2">

## Value

list

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
transmat <-
  list(prob = matrix(data = c(NA, 0.5, 0.5), nrow = 1),
       vals = matrix(data = c(NA, 1, 2), nrow = 1)
       )
transmat_to_child_list(transmat$prob)
#> $`1`
#> [1] 2 3
#> 
#> $`2`
#> integer(0)
#> 
#> $`3`
#> integer(0)
#> 
```

</div>

</div>

</div>
