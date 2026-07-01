<div id="main" class="col-md-9" role="main">

# Long format to transition matrix

<div class="ref-description section level2">

Long format to transition matrix

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
long_to_transmat(dat, val_col = "prob")
```

</div>

</div>

<div class="section level2">

## Arguments

-   dat:

    array of from, to, prob, vals

-   val_col:

    Name of value column; default prob (string)

</div>

<div class="section level2">

## Value

Transition matrix

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
dat <- data.frame(from = c(NA,1, 1),
                  to = c(1, 2, 3),
                  prob = c(NA, 0.5, 0.5),
                  vals = c(0, 1, 2))
long_to_transmat(dat)
#>    1   2   3
#> 1 NA 0.5 0.5
#> 2 NA  NA  NA
#> 3 NA  NA  NA
```

</div>

</div>

</div>
