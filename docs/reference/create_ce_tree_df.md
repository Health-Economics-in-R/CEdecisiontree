<div id="main" class="col-md-9" role="main">

# Create cost-effectiveness decision tree data frame input

<div class="ref-description section level2">

Using look up table, rather than separate lists, of values and labels.
Can prepare these external to R and read them in.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
create_ce_tree_df(label_branch_tab, label_val_tab, tree_struc)
```

</div>

</div>

<div class="section level2">

## Arguments

-   label_branch_tab:

    Look up table

-   label_val_tab:

    Look up table

-   tree_struc:

    List of parent child branches

</div>

<div class="section level2">

## Value

tibble in long format

</div>

</div>
