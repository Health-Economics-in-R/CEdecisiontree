<div id="main" class="col-md-9" role="main">

# Create transition matrix from tree children list

<div class="ref-description section level2">

Create transition matrix from tree children list by parents.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
child_list_to_transmat(tree)
```

</div>

</div>

<div class="section level2">

## Arguments

-   tree:

    parent-child node list.

</div>

<div class="section level2">

## Value

matrix

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
child_list_to_transmat(tree =
                         list('1' = c(2, 3),
                              '2' = c(4),
                              '3' = c(6, 7)))
#>    1   2   3  4  5   6   7
#> 1 NA 0.5 0.5 NA NA  NA  NA
#> 2 NA  NA  NA  1 NA  NA  NA
#> 3 NA  NA  NA NA NA 0.5 0.5
#> 4 NA  NA  NA NA NA  NA  NA
#> 5 NA  NA  NA NA NA  NA  NA
#> 6 NA  NA  NA NA NA  NA  NA
#> 7 NA  NA  NA NA NA  NA  NA
```

</div>

</div>

</div>
