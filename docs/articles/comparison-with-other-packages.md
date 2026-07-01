<div id="main" class="col-md-9" role="main">

# Comparison with other packages

<div class="section level2">

## Comparison with heemod

The heemod package is designed to simulate more general models but let
us perform the same analysis to compare. First, we need to define the
transition matrix. This is essentially the same as above except because
heemod simulates over a predefined number of iterations or *cycles* we
need to add a final absorbing sink state (i.e. *p*_(*i**i*) = 1) with no
associated costs.

<div id="cb1" class="sourceCode">

``` r
library(heemod)

mat_base <- define_transition(
  state_names = as.character(1:8),
  0, 0.2, 0.8,0,0,0,0,0, 
  0,0,0, 0.2, 0.8,0,0,0,  
  0,0,0,0,0, 0.2, 0.8,0,
  0,0,0,0,0,0,0,1,
  0,0,0,0,0,0,0,1,
  0,0,0,0,0,0,0,1,
  0,0,0,0,0,0,0,1,
  0,0,0,0,0,0,0,1
)
```

</div>

Define cost at each node:

<div id="cb2" class="sourceCode">

``` r
state_1 <- define_state(
  cost_total = 0,
  qaly = 0)

state_2 <- define_state(
  cost_total = 10,
  qaly = 1)

state_3 <- define_state(
  cost_total = 1,
  qaly = 1)

state_4 <- define_state(
  cost_total = 10,
  qaly = 1)

state_5 <- define_state(
  cost_total = 1,
  qaly = 1)

state_6 <- define_state(
  cost_total = 10,
  qaly = 1)

state_7 <- define_state(
  cost_total = 1,
  qaly = 1)

state_8 <- define_state(
  cost_total = 0,
  qaly = 0)

strat_base <- define_strategy(
  transition = mat_base,
  "1" = state_1,
  "2" = state_2,
  "3" = state_3,
  "4" = state_4,
  "5" = state_5,
  "6" = state_6,
  "7" = state_7,
  "8" = state_8
)
```

</div>

Finally, we get the expected cost £5600 for 100 cycles which is
equivalent to £5.6 in our previous analysis.

<div id="cb3" class="sourceCode">

``` r
run_model(
  strat_base,
  cycles = 100,
  cost = cost_total,
  effect = qaly)
#> No named model -> generating names.
#> 1 strategy run for 100 cycles.
#> 
#> Initial state counts:
#> 
#> 1 = 1000L
#> 2 = 0L
#> 3 = 0L
#> 4 = 0L
#> 5 = 0L
#> 6 = 0L
#> 7 = 0L
#> 8 = 0L
#> 
#> Counting method: 'life-table'.
#> 
#>  
#> 
#> Counting method: 'beginning'.
#> 
#>  
#> 
#> Counting method: 'end'.
#> 
#> Values:
#> 
#>   cost_total qaly
#> I       5600 2000
```

</div>

</div>

</div>
