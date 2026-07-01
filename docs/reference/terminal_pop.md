<div id="main" class="col-md-9" role="main">

# Terminal Leaf Node Populations

<div class="ref-description section level2">

Joint probabilities of sets of nodes. This is useful to then provide
starting state populations to a Markov model.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
terminal_pop(model, state_list)
```

</div>

</div>

<div class="section level2">

## Arguments

-   model:

    dat_long class

-   state_list:

    Groups of (usually) terminal nodes; List of vectors

</div>

<div class="section level2">

## Value

Vector of probabilities

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
tree_dat <-
 tibble::tribble(
   ~from, ~to, ~vals, ~prob,
   1,  2,   10,   0.7,
   1,  3,   NA,   0.3,
   2,  4,  100,   0.1,
   2,  5,   NA,   0.9,
   3,  6,  100,   0.9,
   3,  7,   NA,   0.1)

term_pop <-
  define_model(dat_long = tree_dat) |>
  terminal_pop(state_list = c(4,5,6,7))

sum(unlist(term_pop))
#> [1] 1
```

</div>

</div>

</div>
