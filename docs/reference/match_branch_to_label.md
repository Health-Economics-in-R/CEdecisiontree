<div id="main" class="col-md-9" role="main">

# Match branch to label

<div class="ref-description section level2">

Assume that there are node labels and these may be non-unique. We assign
these labels by joining a lookup table of labels and edges with the tree
object, in this case the long array format.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
match_branch_to_label(probs_long, probs_from_to_lookup)
```

</div>

</div>

<div class="section level2">

## Arguments

-   probs_long:

    Long format array tree object

-   probs_from_to_lookup:

    edge-label look-up table

</div>

<div class="section level2">

## Value

dataframe

</div>

<div class="section level2">

## Details

Separating the tree structure and labelling means that we can reuse the
same tree with different labels e.g. another test or treatment

</div>

<div class="section level2">

## See also

<div class="dont-index">

[match_branchlabel_to_prob](match_branchlabel_to_prob.md)

</div>

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
probs_long <-
  tibble::tribble(~from, ~to, ~prob,
                  1, 2, 0.5,
                  1, 3, 0.5)
pname_from_to <-
  tibble::tribble(~from, ~to, ~name,
                  1, 2, "pos",
                  1, 3, "neg")

match_branch_to_label(probs_long, pname_from_to)
#>   from to name
#> 1    1  2  pos
#> 2    1  3  neg
```

</div>

</div>

</div>
