<div id="main" class="col-md-9" role="main">

# Package index

<div class="section level2">

## Total expected values

<div class="section-desc">

Functions for calculating the weighted mean values at decision tree
nodes.

</div>

</div>

<div class="section level2">

-   `Cdectree_expected_values()` : Cdectree_expected_values
-   `dectree_expected_recursive()` : Cost-effectiveness decision tree
    using recursive approach
-   `dectree_expected_values()` : Cost-effectiveness decision tree
    expected values
-   `dectree()` : Decision tree estimation
-   `dectree_expected_default()` : Cost-effectiveness decision tree
    expected values
-   `dectree_expected_recursive2()` : Cost-effectiveness decision tree
    using recursive approach for more than 2 child nodes
-   `run_cedectree()` : Run Cost-effectiveness Decision Tree

</div>

<div class="section level2">

## Transform between formats

<div class="section-desc">

Functions for switching between matrix, long or tree representations of
a decision tree.

</div>

</div>

<div class="section level2">

-   `child_list_to_transmat()` : Create transition matrix from tree
    children list
-   `long_to_transmat()` : Long format to transition matrix
-   `transmat_to_child_list()` : Create tree children list from
    transition matrix
-   `transmat_to_long()` : Transition matrix to long format

</div>

<div class="section level2">

## All other functions

<div class="section-desc">

Miscellaneous tools for manipulating tree values and probabilities.

</div>

</div>

<div class="section level2">

-   `branch_joint_probs()` : Branch Joint Probabilities
-   `create_ce_tree_df()` : Create cost-effectiveness decision tree data
    frame input
-   `create_ce_tree_long_df()` : Create Cost-Effectiveness Tree For Long
    Dataframe
-   `create_psa_inputs()` : Create PSA inputs
-   `define_model()` : Define decision tree model
-   `fill_complementary_probs()` : Fill Complementary Probabilities
-   `get_sd_from_normalCI()` : Get Standard Deviation from Normal
    Confidence Interval
-   `insert_to_transmat()` `insert_to_costmat()` `insert_to_probmat()` :
    Insert to transition matrix
-   `is_prob_matrix()` : Is object a transition probability matrix?
-   `match_branchlabel_to_prob()` : Match branch label to probabilities
-   `match_branch_to_label()` : Match branch to label
-   `MoM_beta()` : Method of Moments Beta Distribution Parameter
    Transformation
-   `MoM_gamma()` : Method of Moments Gamma Distribution Parameter
    Transformation
-   `new_transmat()` `new_tree_dat()` `new_dat_long()` : New Model
    Constructors
-   `rpert()` : Sample from Beta-PERT Distribution
-   `rbeta_more_params()` : Helper function for Beta distribution
    sampling with alternative parameters
-   `rgamma_more_params()` : Helper function for Gamma distribution
    sampling with alternative parameters
-   `sample_distributions()` : Sample from Standard Distributions
-   `terminal_pop()` : Terminal Leaf Node Populations
-   `trans_binarytree()` : Transition matrix to binary tree
-   `validate_transmat()` `validate_tree_dat()` `validate_dat_long()` :
    New Model Validation

</div>

<div class="section level2">

## Data

</div>

<div class="section level2">

-   `bcg_cost` : Costs in transition matrix format
-   `bcg_probs` : Probabilities in transition matrix format
-   `bcg_utility` : Utility in transition matrix format
-   `cost` : Costs in transition matrix format
-   `probs` : Probabilities in transition matrix format

</div>

</div>
