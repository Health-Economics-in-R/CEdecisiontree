<div id="main" class="col-md-9" role="main">

# Transition matrix to binary tree

<div class="ref-description section level2">

This is adapted from `mstate::trans.illness`. Create a complete binary
tree transition matrix.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
trans_binarytree(names, depth = 2)
```

</div>

</div>

<div class="section level2">

## Arguments

-   names:

    Node names

-   depth:

    Depth of tree; integer

</div>

<div class="section level2">

## Value

Matrix of TRUE and FALSE

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
trans_binarytree(c("A", "B"), depth = 2)
#>     to
#> from  1  2  3  4  5
#>    1 NA  1  2 NA NA
#>    2 NA NA NA  3  4
```

</div>

</div>

</div>
