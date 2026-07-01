<div id="main" class="col-md-9" role="main">

# Run Cost-effectiveness Decision Tree

<div class="ref-description section level2">

Wrapper for \`dectree()\` for both costs and health value.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
run_cedectree(
  dat_long,
  label_probs_distns = NULL,
  label_costs_distns = NULL,
  label_health_distns = NULL,
  state_list = NULL,
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

-   label_costs_distns:

    Cost distribution names

-   label_health_distns:

    Health value distribution names

-   state_list:

    State list sets, usually terminal nodes

-   n:

    Number of PSA samples; default 100

</div>

<div class="section level2">

## Value

List of cost, health \`dectree()\` output

</div>

<div class="section level2">

## See also

<div class="dont-index">

dectree

</div>

</div>

</div>
