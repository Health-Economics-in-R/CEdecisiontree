<div id="main" class="col-md-9" role="main">

# Cost-effectiveness decision tree using recursive approach for more than 2 child nodes

<div class="ref-description section level2">

Cost-effectiveness decision tree using recursive approach for more than
2 child nodes

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
dectree_expected_recursive2(node, tree, dat)
```

</div>

</div>

<div class="section level2">

## Arguments

-   node:

    Node at which total expected value is to be calculate at

-   tree:

    List of children by parents

-   dat:

    Node labels, branch probabilities and value; data frame

</div>

<div class="section level2">

## Value

Expected value at root node

</div>

<div class="section level2">

## See also

<div class="dont-index">

CEdecisiontree

Other CEdecisiontree: `dectree_expected_recursive()`

</div>

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
tree <-
  list("1" = c(2,3,5),
       "2" =  4,
       "3" =  c(6,7),
       "4" =  c(),
       "5" =  c(),
       "6" =  c(),
       "7" =  c())
dat <-
  data.frame(node = 1:7,
             prob = c(NA, rep(1, 6)),
             vals = c(10,2,3,16,5,6,7))

root <- names(tree)[1]
dectree_expected_recursive2(node = root, tree, dat)
#> [1] 49
```

</div>

</div>

</div>
