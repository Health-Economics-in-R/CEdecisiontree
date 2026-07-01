<div id="main" class="col-md-9" role="main">

# Cost-effectiveness decision tree expected values

<div class="ref-description section level2">

Root node expected value as the weighted mean of probability and
edge/node values e.g. costs or QALYS.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
dectree_expected_default(vals, p, dat = NA)
```

</div>

</div>

<div class="section level2">

## Arguments

-   vals:

    Values on each edge/branch e.g. costs or QALYs (array)

-   p:

    Transition probabilities matrix

-   dat:

    Long node-edge value array; default: `NA`

</div>

<div class="section level2">

## Value

Expected value at each node (vector)

</div>

<div class="section level2">

## Details

The expected value at each node is calculate by

$$\\hat{c}\_i = c_i + \\sum p\_{ij} \\hat{c}\_j$$

The default calculation assumes that the costs are associated with the
nodes. An alternative would be to associate them with the edges. For
total expected cost this doesn't matter but for the other nodes this is
different to assuming the costs are assigned to the nodes. The expected
value would then be

$$\\hat{c}\_i = \\sum p\_{ij} (c\_{ij} + \\hat{c}\_j)$$

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
# dectree_expected_default(vals, p)
```

</div>

</div>

</div>
