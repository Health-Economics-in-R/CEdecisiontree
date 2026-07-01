<div id="main" class="col-md-9" role="main">

# Branch Joint Probabilities

<div class="ref-description section level2">

Provides a measure of the chances of following particular paths through
the decision tree.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
branch_joint_probs(model, nodes = NA, ...)

# S3 method for class 'transmat'
branch_joint_probs(model, nodes = NA, ...)

# S3 method for class 'dat_long'
branch_joint_probs(model, nodes = NA, cumul = FALSE, ...)

# Default S3 method
branch_joint_probs(model, nodes, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   model:

    Branch conditional probabilities (matrix)

-   nodes:

    Which nodes to return; default to all

-   ...:

    Additional parameters

</div>

<div class="section level2">

## Value

Transition matrix with joint probabilities

</div>

<div class="section level2">

## Details

These probabilities could be used to weight branch costs or QALYs to
indicate the relative contribution to the total expected value.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
model <-
  define_model(
    transmat =
      list(prob =
             matrix(data = c(NA, 0.5, 0.5, NA,  NA,  NA,  NA,
                             NA, NA, NA,   0.1, 0.9, NA,  NA,
                             NA, NA, NA,   NA,  NA,  0.9, 0.1),
                    nrow = 3,
                    byrow = TRUE),
           vals =
             matrix(data = c(NA, 1,  5,  NA, NA, NA, NA,
                             NA, NA, NA, 1,  9,  NA, NA,
                             NA, NA, NA, NA, NA, 9,  1),
                    nrow = 3,
                    byrow = TRUE)))
model
#> $prob
#>      [,1] [,2] [,3] [,4] [,5] [,6] [,7]
#> [1,]   NA  0.5  0.5   NA   NA   NA   NA
#> [2,]   NA   NA   NA  0.1  0.9   NA   NA
#> [3,]   NA   NA   NA   NA   NA  0.9  0.1
#> 
#> $vals
#>      [,1] [,2] [,3] [,4] [,5] [,6] [,7]
#> [1,]   NA    1    5   NA   NA   NA   NA
#> [2,]   NA   NA   NA    1    9   NA   NA
#> [3,]   NA   NA   NA   NA   NA    9    1
#> 
#> attr(,"class")
#> [1] "transmat" "list"    

branch_joint_probs(model)
#>      [,1] [,2] [,3] [,4] [,5] [,6] [,7]
#> [1,]   NA  0.5  0.5   NA   NA   NA   NA
#> [2,]   NA   NA   NA 0.05 0.45   NA   NA
#> [3,]   NA   NA   NA   NA   NA 0.45 0.05

# weighted vals
branch_joint_probs(model)*model$vals
#>      [,1] [,2] [,3] [,4] [,5] [,6] [,7]
#> [1,]   NA  0.5  2.5   NA   NA   NA   NA
#> [2,]   NA   NA   NA 0.05 4.05   NA   NA
#> [3,]   NA   NA   NA   NA   NA 4.05 0.05

# long data format
df <-
  data.frame(
    from = c(1,2,1),
    to = c(2,3,4),
    prob = c(0.1,0.5,0.9),
    vals = c(1,2,3))

mod <- define_model(dat_long = df)

branch_joint_probs(mod, nodes = 4)
#> $`4`
#> [1] 1.0 0.9
#> 
#0.9

branch_joint_probs(mod, nodes = 3)
#> $`3`
#> [1] 1.0 0.5 0.1
#> 
#0.1*0.5

branch_joint_probs(mod, nodes = 3)[[1]] |> cumprod()
#> [1] 1.00 0.50 0.05
```

</div>

</div>

</div>
