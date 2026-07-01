<div id="main" class="col-md-9" role="main">

# Building a decision tree from components

<div class="section level2">

## Introduction

For small decision trees it is simple to directly write down structure
of the tree and its values.

However, for larger trees this may become unwieldy and error prone. We
can take advantage of some of the tree characteristics though:

-   Sections of the tree may be repeated

-   A particular unit cost or health measure may be used on multiple
    edges

-   Multiple trees may use the same cost and health values

-   Tree structure and labeling may remain the same but values assigned
    change e.g. in sensitivity analysis or alternative interventions

Thus, we can separate the *structure* of the tree, the *labeling* of
edges and the *values* assigned to those labels. In this way we have
flexibility in modify any one of these and better adhere to the DRY
principle and the benefits it offers.

For instance, we can think of the value assignment like a relational
table with key-value pairs where the key is `Label`. For the decision
tree tree with cost values, edges are labeled as follows:

| Label     | From node | To node |
|-----------|-----------|---------|
| vaccinate | 1         | 2       |
| disease   | 2         | 4       |
| disease   | 3         | 6       |

and joined with the values table:

| Label        | Cost | Prob | Health |
|--------------|------|------|--------|
| vaccinate    | 10   | 0.7  | 0      |
| vacc_disease | \-   | 0.1  | \-     |
| disease      | 100  | 0.9  | 0.5    |

</div>

<div class="section level2">

## Example

Let us demonstrate this approach using a simple tree.

<div id="cb1" class="sourceCode">

``` r
library(CEdecisiontree)
library(dplyr)
```

</div>

First, we define the structure of the tree in list format without any
additional information. Let’s make a two-step binary tree.

<div id="cb2" class="sourceCode">

``` r
tree_struc <-
  list(
    '1' = c(2,3),
    '2' = c(4,5),
    '3' = c(6,7))
```

</div>

Now we can add labels and values to this tree. Define the set of cost,
health values and probabilities, independent of the tree structure.

<div id="cb3" class="sourceCode">

``` r
label_cost <-
  list(
    "vaccinate" = 10,
    "disease" = 100)

label_probs <- 
  list(
    "vaccinate" = 0.7,
    "vacc_disease" = 0.1,
    "disease" = 0.9)

label_health <- 
  list(
    "disease" = 0.5)
```

</div>

Next, assign cost, probability and health labels to particular branches.

<div id="cb4" class="sourceCode">

``` r
library(tibble)
#> Warning: package 'tibble' was built under R version 4.5.3

cost_label_branch <- 
  tribble(~name,      ~from, ~to,
          "vaccinate", 1,    2,
          "disease",   2,    4,
          "disease",   3,    6)

prob_label_branch <- 
  tribble(~name,      ~from, ~to,
          "vaccinate",    1,  2,
          "vacc_disease", 2,  4,
          "disease",      3,  6)

health_label_branch <- 
  tribble(~name,     ~from, ~to,
          "disease", 2,     4,
          "disease", 3,     6)
```

</div>

Finally, we can pull it all together and create a single decision tree
long format data frame.

<div id="cb5" class="sourceCode">

``` r
tree_dat <-
  create_ce_tree_long_df(
    tree_list = tree_struc,
    label_probs = label_probs,
    label_costs = label_cost,
    label_health = label_health,
    pname_from_to = prob_label_branch,
    cname_from_to = cost_label_branch,
    hname_from_to = health_label_branch)

tree_dat
FALSE   from to name.cost cost    name.prob prob name.health health
FALSE 1    1  2 vaccinate   10    vaccinate  0.7        <NA>     NA
FALSE 2    1  3      <NA>   NA         <NA>  0.3        <NA>     NA
FALSE 3    2  4   disease  100 vacc_disease  0.1     disease    0.5
FALSE 4    2  5      <NA>   NA         <NA>  0.9        <NA>     NA
FALSE 5    3  6   disease  100      disease  0.9     disease    0.5
FALSE 6    3  7      <NA>   NA         <NA>  0.1        <NA>     NA
```

</div>

The above example may seem a little over-elaborate. This demonstrates an
example where all of the components are defined separately and then
combined to obtain a single object with all the input values.
Alternatively, we could define the label look up table and the values
look up table outside of R and simply read this in and join to obtain an
equivalent object.

<div id="cb6" class="sourceCode">

``` r
library(reshape2)
#> Warning: package 'reshape2' was built under R version 4.5.3

label_branch_tab <- read.csv(here::here("data-raw/label-branch table.csv"))
label_branch_tab
#>     unit        label from to
#> 1   cost    vaccinate    1  2
#> 2   cost      disease    2  4
#> 3   cost      disease    3  6
#> 4   prob    vaccinate    1  2
#> 5   prob vacc_disease    2  4
#> 6   prob      disease    3  6
#> 7 health      disease    2  4
#> 8 health      disease    3  6

label_val_tab <- read.csv(here::here("data-raw/label-val table.csv"))
label_val_tab
#>     unit        label   val
#> 1   cost    vaccinate  10.0
#> 2   cost      disease 100.0
#> 3   prob    vaccinate   0.7
#> 4   prob vacc_disease   0.1
#> 5   prob      disease   0.9
#> 6 health      disease   0.5

tree_dat2 <-
  create_ce_tree_df(label_branch_tab,
                    label_val_tab,
                    tree_struc)
tree_dat2
#> # A tibble: 6 × 5
#>   from     to  cost health  prob
#>   <chr> <dbl> <dbl>  <dbl> <dbl>
#> 1 1         2    10   NA     0.7
#> 2 1         3    NA   NA     0.3
#> 3 2         4   100    0.5   0.1
#> 4 2         5    NA   NA     0.9
#> 5 3         6   100    0.5   0.9
#> 6 3         7    NA   NA     0.1
```

</div>

This data frame can now be used in the main cost-effectiveness analysis.

<div id="cb7" class="sourceCode">

``` r
tree_costs <- tree_dat2
names(tree_costs)[names(tree_costs) == "cost"] <- "vals"

treemod <- define_model(dat_long = tree_costs)
#> Removing column(s) health

dectree_expected_values(model = treemod)
#> vals used for calculation.
#>   1   2   3   4   5   6   7   8 
#>  41  20  90 100   0 100   0   0
```

</div>

We can run both the cost and health analyses together.

<div id="cb8" class="sourceCode">

``` r
run_cedectree(tree_dat2)
#> vals used for calculation.
#> vals used for calculation.
#> $cost
#> $cost$ev_point
#>   1   2   3   4   5   6   7   8 
#>  41  20  90 100   0 100   0   0 
#> 
#> $cost$term_pop_point
#> NULL
#> 
#> 
#> $health
#> $health$ev_point
#>    1    2    3    4    5    6    7    8 
#> 0.17 0.05 0.45 0.50 0.00 0.50 0.00 0.00 
#> 
#> $health$term_pop_point
#> NULL
```

</div>

</div>

</div>
