<div id="main" class="col-md-9" role="main">

# Is object a transition probability matrix?

<div class="ref-description section level2">

Is object a transition probability matrix?

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
is_prob_matrix(probs, dp = 5)
```

</div>

</div>

<div class="section level2">

## Arguments

-   probs:

    matrix of transition probabilities

-   dp:

    Decimal places; Tolerance for equivalence

</div>

<div class="section level2">

## Value

logical

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
if (FALSE) { # \dontrun{
probs <- matrix(c(1,0,0,1), nrow = 2)
is_prob_matrix(probs)

probs <- matrix(c(2,0,-1,1), nrow = 2)
assert_that(is_prob_matrix(probs))
} # }
```

</div>

</div>

</div>
