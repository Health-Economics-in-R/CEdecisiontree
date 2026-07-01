<div id="main" class="col-md-9" role="main">

# Transition matrix to long format

<div class="ref-description section level2">

Transition matrix to long format

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
transmat_to_long(probs)
```

</div>

</div>

<div class="section level2">

## Arguments

-   probs:

    Probability transition matrix

</div>

<div class="section level2">

## Value

array of from, to, prob

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
tree <- list(
   prob = matrix(data = c(NA, 0.5, 0.5), nrow = 1),
   vals = matrix(data = c(NA, 1, 2), nrow = 1))

transmat_to_long(tree$prob)
#> New names:
#> • `` -> `...1`
#> • `` -> `...2`
#> • `` -> `...3`
#>   from to prob
#> 2    1  2  0.5
#> 3    1  3  0.5
```

</div>

</div>

</div>
