<div id="main" class="col-md-9" role="main">

# New Model Constructors

<div class="ref-description section level2">

New Model Constructors

New transition matrix

New tree data

New long data

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
new_transmat(transmat, ...)

new_tree_dat(tree_dat, ...)

new_dat_long(dat_long, fill_edges = TRUE, fill_probs = FALSE)
```

</div>

</div>

<div class="section level2">

## Arguments

-   transmat:

    Transition probability matrix. Rows are from nodes and columns are
    to nodes.

-   ...:

    Additional arguments

-   tree_dat:

    Hierarchical tree structure of parents and children in a list of
    vectors with integer values.

-   dat_long:

    Long format data frame with from, to, prob, vals columns.

-   fill_edges:

    If need missing edges to connect to a sink state; logical

-   fill_probs:

    Fill in missing probabilities; logical

</div>

</div>
