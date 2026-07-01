<div id="main" class="col-md-9" role="main">

# Fill Complementary Probabilities

<div class="ref-description section level2">

Only one of each pair of branches is assigned a probability and then the
other event probability is filled-in afterwards. This is good because
specify fewer input values and if sampling probabilities we don't know
the complementary probability.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
fill_complementary_probs(dat_long)
```

</div>

</div>

<div class="section level2">

## Arguments

-   dat_long:

    Long format data frame with from, to, prob, vals columns.

</div>

<div class="section level2">

## Value

Long format tree object

</div>

<div class="section level2">

## Details

Only works for binary trees or when one of n is missing.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
dat <- tibble::tribble(~from, ~to, ~prob, ~vals,
                       1,  2,  NA,    10,
                       1,  3,  0.8,    1,
                       2,  4,  0.2,   10,
                       2,  5,  NA,     1,
                       3,  6,  0.2,   10,
                       3,  7,  0.8,    1)
fill_complementary_probs(dat)
#> # A tibble: 6 × 4
#>    from    to  prob  vals
#>   <dbl> <dbl> <dbl> <dbl>
#> 1     1     2   0.2    10
#> 2     1     3   0.8     1
#> 3     2     4   0.2    10
#> 4     2     5   0.8     1
#> 5     3     6   0.2    10
#> 6     3     7   0.8     1
```

</div>

</div>

</div>
