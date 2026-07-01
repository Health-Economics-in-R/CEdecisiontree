<div id="main" class="col-md-9" role="main">

# Match branch label to probabilities

<div class="ref-description section level2">

We have a look-up table of labels and values. We can join the values to
nodes/edges via their labels.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
match_branchlabel_to_prob(probs_names, branch_probs_long)
```

</div>

</div>

<div class="section level2">

## Arguments

-   probs_names:

    label-probability look-up

-   branch_probs_long:

    long format tree object with labels

</div>

<div class="section level2">

## Value

dataframe

</div>

<div class="section level2">

## See also

<div class="dont-index">

[match_branch_to_label](match_branch_to_label.md)

</div>

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
probs_long <-
  tibble::tribble(~from, ~to, ~name,
                  1, 2, "pos",
                  1, 3, "neg")
probs_names <-
  tibble::tribble(~prob, ~name,
                  0.4, "pos",
                  0.6, "neg")

match_branchlabel_to_prob(probs_names, probs_long)
#> # A tibble: 2 × 4
#>    prob name   from    to
#>   <dbl> <chr> <dbl> <dbl>
#> 1   0.4 pos       1     2
#> 2   0.6 neg       1     3
```

</div>

</div>

</div>
