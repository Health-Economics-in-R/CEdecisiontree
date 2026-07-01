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
dectree_expected_values(model, ...)

# S3 method for class 'tree_dat'
dectree_expected_values(model, ...)

# S3 method for class 'transmat'
dectree_expected_values(model, ...)

# S3 method for class 'dat_long'
dectree_expected_values(model, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   model:

    Object of `define_model()` consisting of output of type `tree_dat`,
    `transmat` or `dat_long`

-   ...:

    Additional parameters

</div>

<div class="section level2">

## Value

Expected value at each node

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

## See also

<div class="dont-index">

`define_model`

</div>

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
data("cost")
data("probs")

my_model <-
  define_model(
    transmat = list(vals = cost,
                    prob = probs))

dectree_expected_values(model = my_model)
#>    1    2    3    4    5    6    7 
#>  5.6 12.8  3.8 10.0  1.0 10.0  1.0 
```

</div>

</div>

</div>
