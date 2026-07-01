<div id="main" class="col-md-9" role="main">

# Sample from Standard Distributions

<div class="ref-description section level2">

Supply a list of defined distributions (log-normal, beta, gamma,
uniform, triangle) and one realisation is taken of each.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
sample_distributions(param.distns)
```

</div>

</div>

<div class="section level2">

## Arguments

-   param.distns:

    List of distribution names and their respective parameter values

</div>

<div class="section level2">

## Value

vector of sample points

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
sample_distributions(param.distns = list(distn = "unif", params = c(min=0, max=1)))
#> [1] 0.08075014
sample_distributions(param.distns = list(distn = "lognormal", params = c(mean=10, sd=1)))
#> [1] 58187.77
sample_distributions(param.distns = list(distn = "beta", params = c(mean=0.1, sd=0.1)))
#> [1] 0.4754471
sample_distributions(param.distns = list(distn = "beta", params = c(a=0.1, b=0.1)))
#> [1] 0.7935224
sample_distributions(param.distns = list(list(distn = "beta", params = c(a=0.1, b=0.1)),
                                         list(distn = "beta", params = c(a=0.1, b=0.1))))
#> [1] 0.9999998 0.9994582
```

</div>

</div>

</div>
