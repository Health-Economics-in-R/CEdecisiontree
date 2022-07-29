
#' Run Cost-effectiveness Decision Tree
#'
#' Wrapper for `dectree()` for both costs and health value.
#'
#' @template args-dat_long
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
run_cedectree <- function(dat_long,
                          label_probs_distns = NULL,
                          label_costs_distns = NULL,
                          label_health_distns = NULL,
                          state_list = NULL,
                          n = 100) {

  cost <-
    dat_long %>%
    rename(vals = cost) %>%
    select(!contains("health")) %>%
    dectree(label_probs_distns,
            label_costs_distns,
            state_list,
            n = n)

  health <-
    dat_long %>%
    rename(vals = health) %>%
    select(!contains("cost")) %>%
    dectree(label_probs_distns,
            label_health_distns,
            state_list,
            n = n)

  list(cost = cost,
       health = health)
}
