<div id="main" class="col-md-9" role="main">

# Create Cost-Effectiveness Tree For Long Dataframe

<div class="ref-description section level2">

Completely specifying cost-effectiveness decision tree. Matches labels
on branches to the corresponding probabilities and cost/utility values.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
create_ce_tree_long_df(
  tree_list = NA,
  tree_mat = NA,
  label_probs,
  label_costs,
  label_health,
  pname_from_to,
  cname_from_to,
  hname_from_to
)
```

</div>

</div>

<div class="section level2">

## Arguments

-   tree_list:

    Parent-child ids format

-   tree_mat:

    Matrix format

-   label_probs:

    List

-   label_costs:

    List

-   label_health:

    Health labels

-   pname_from_to:

    Dataframe name, from, to

-   cname_from_to:

    Dataframe name, from, to

-   hname_from_to:

    Health names for from-to edges

</div>

<div class="section level2">

## Value

Long format dataframe for input to \`define_model()\` or \`dectree()\`.
Note this is for a single edge value type (e.g. cost or QALY). Use
\`run_cedectree()\` for cost and health.

</div>

<div class="section level2">

## See also

<div class="dont-index">

\[CEdecisiontree::define_model()\] \[CEdecisiontree::dectree()\]
\[CEdecisiontree::run_cedectree()\]

</div>

</div>

</div>
