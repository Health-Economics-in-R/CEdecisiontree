<div id="main" class="col-md-9" role="main">

# Using other input formats

The main aim of the CEdecisiontree package is to provide a bridge to
models that would be otherwise build in Excel. Because of this the
transition matrix format for input arguments is the primary format.
However, this is not necessarily the easiest to define, manipulate or
compute with. Here we give some examples alternative formats.

<div class="section level2">

## Setup

Quietly load libraries.

<div id="cb1" class="sourceCode">

``` r
library(CEdecisiontree)
library(readr)
library(dplyr)
library(reshape2)
library(tidyr)
library(assertthat)
```

</div>

Load example data from the package.

<div id="cb2" class="sourceCode">

``` r
data("cost")
data("probs")
```

</div>

</div>

<div class="section level2">

## Tree structure

Generally, we can specify a tree by who the children are for each parent
node. This can be more compuationally efficient.

<div id="cb3" class="sourceCode">

``` r
tree <-
 list("1" = c(2,3),
      "2" =  c(4,5),
      "3" =  c(6,7),
      "4" =  c(),
      "5" =  c(),
      "6" =  c(),
      "7" =  c())
dat <-
 data.frame(node = 1:7,
            prob = c(NA, 0.2, 0.8, 0.2, 0.8, 0.2, 0.8),
            vals = c(0,10,1,10,1,10,1))
tree
#> $`1`
#> [1] 2 3
#> 
#> $`2`
#> [1] 4 5
#> 
#> $`3`
#> [1] 6 7
#> 
#> $`4`
#> NULL
#> 
#> $`5`
#> NULL
#> 
#> $`6`
#> NULL
#> 
#> $`7`
#> NULL
dat
#>   node prob vals
#> 1    1   NA    0
#> 2    2  0.2   10
#> 3    3  0.8    1
#> 4    4  0.2   10
#> 5    5  0.8    1
#> 6    6  0.2   10
#> 7    7  0.8    1

dectree_expected_recursive(names(tree)[1], tree, dat)
#> [1] 5.6
```

</div>

We can obtain the list of children from the probability matrix (or any
other structure defining transition matrix).

<div id="cb4" class="sourceCode">

``` r
transmat_to_child_list(probs)
#> $`1`
#> [1] 2 3
#> 
#> $`2`
#> [1] 4 5
#> 
#> $`3`
#> [1] 6 7
#> 
#> $`4`
#> integer(0)
#> 
#> $`5`
#> integer(0)
#> 
#> $`6`
#> integer(0)
#> 
#> $`7`
#> integer(0)
```

</div>

</div>

<div class="section level2">

## Single long array

If we keep with flat arrays then clearly, as the size of the tree
increased the sparse matrices become impractical. We can provide a long
format array to address this. Let us transform the wide array used
previously to demonstrate the structure and space saving.

<div id="cb5" class="sourceCode">

``` r
probs_long <-
  probs %>%
  mutate('from' = rownames(.)) %>%
  melt(id.vars = "from",
       variable.name = 'to',
       value.name = 'prob') %>%
  mutate(to = as.numeric(to)) %>% 
  na.omit()

cost_long <-
  cost %>%
  mutate('from' = rownames(.)) %>%
  melt(id.vars = "from",
       variable.name = 'to',
       value.name = 'vals') %>%
  mutate(to = as.numeric(to)) %>% 
  na.omit()

dat_long <-
  merge(probs_long,
        cost_long)

dat_long
#>   from to prob vals
#> 1    1  2  0.2   10
#> 2    1  3  0.8    1
#> 3    2  4  0.2   10
#> 4    2  5  0.8    1
#> 5    3  6  0.2   10
#> 6    3  7  0.8    1
```

</div>

We can use the long array as the input argument instead of the separate
transition matrices. Internally, we simple convert back to a matrix
using `long_to_transmat()` so for larger trees this may be inefficient.

<div id="cb6" class="sourceCode">

``` r
dectree_expected_values(
  define_model(dat_long = dat_long))
#> vals used for calculation.
#>    1    2    3    4    5    6    7    8 
#>  5.6 12.8  3.8 10.0  1.0 10.0  1.0  0.0
```

</div>

</div>

<div class="section level2">

## Computation speed

We can compare the computation times for the recursive and non-recursive
formulations.

<div id="cb7" class="sourceCode">

``` r
microbenchmark::microbenchmark(dectree_expected_values(define_model(dat_long = dat_long)),
                               dectree_expected_recursive(names(tree)[1], tree, dat), times = 100L)
#> Unit: microseconds
#>                                                        expr     min       lq
#>  dectree_expected_values(define_model(dat_long = dat_long)) 12650.9 12848.80
#>       dectree_expected_recursive(names(tree)[1], tree, dat)   214.7   235.05
#>       mean   median      uq     max neval cld
#>  13483.660 12982.50 13620.3 18484.9   100  a 
#>    274.887   273.75   308.6   360.6   100   b
```

</div>

For this example the recursive formulation is much quicker. Change in
memory before and after running the functions.

<div id="cb8" class="sourceCode">

``` r
pryr::mem_change(dectree_expected_values(  define_model(dat_long = dat_long)))
#> vals used for calculation.
#> 1.4 kB
pryr::mem_change(dectree_expected_recursive(names(tree)[1], tree, dat))
#> 736 B
```

</div>

</div>

</div>
