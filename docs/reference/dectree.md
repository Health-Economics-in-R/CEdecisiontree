<div id="main" class="col-md-9" role="main">

# Decision tree estimation

<div class="ref-description section level2">

Single edge value (e.g. cost or QALY) wrapper.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
dectree(
  dat_long,
  label_probs_distns = NULL,
  label_vals_distns = NULL,
  state_list = NULL,
  vals_col = NA,
  n = 100
)
```

</div>

</div>

<div class="section level2">

## Arguments

-   dat_long:

    Long format data frame with from, to, prob, vals columns.

-   label_probs_distns:

    Probability distribution names

-   label_vals_distns:

    Value distribution names

-   state_list:

    State list sets, usually terminal nodes

-   vals_col:

    Name of values column; defaults to vals

-   n:

    Number of PSA samples; default 100

</div>

<div class="section level2">

## Value

List of expected values at each node, joint probabilities at terminal
state set and PSA samples of these if distributions provided.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
library(purrr)
#> Warning: package 'purrr' was built under R version 4.5.3
library(tibble)
#> Warning: package 'tibble' was built under R version 4.5.3

dat_long <-
 tribble(
   ~from, ~to, ~vals, ~prob,
   1,  2,   10,   0.7,
   1,  3,   NA,   0.3,
   2,  4,  100,   0.1,
   2,  5,   NA,   0.9,
   3,  6,  100,   0.9,
   3,  7,   NA,   0.1)

dectree(dat_long,
   state_list = list(all = c(4,5,6,7)))
#> vals used for calculation.
#> $ev_point
#>   1   2   3   4   5   6   7   8 
#>  41  20  90 100   0 100   0   0 
#> 
#> $term_pop_point
#> $term_pop_point$all
#> [1] 1
#> 
#> 
```

</div>

</div>

</div>
