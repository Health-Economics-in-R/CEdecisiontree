
#' run_cedectree
#'
#' Wrapper for `dectree()` for costs and health value.
#'
#' @param tree_dat Decision tree data in `dat_long` format
#' @param label_probs_distns Probability distribution names
#' @param label_costs_distns Cost distribution names
#' @param label_health_distns Health value distribution names
#' @param state_list State list sets, usually terminal nodes
#' @param n Number of PSA samples; default 100
#' @seealso dectree
#'
#' @return List of cost, health `dectree()` output
#' @export
#'
run_cedectree <- function(tree_dat,
                          label_probs_distns = NULL,
                          label_costs_distns = NULL,
                          label_health_distns = NULL,
                          state_list = NULL,
                          n = 100) {

  cost <-
    tree_dat %>%
    rename(val = cost) %>%
    select(-name.health, -health) %>%
    dectree(label_probs_distns,
            label_costs_distns,
            state_list,
            n = n)

  health <-
    tree_dat %>%
    rename(val = health) %>%
    select(-name.cost, -cost) %>%
    dectree(label_probs_distns,
            label_health_distns,
            state_list,
            n = n)

  list(cost = cost,
       health = health)
}
