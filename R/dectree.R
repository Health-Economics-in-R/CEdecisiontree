
#' Decision Tree
#'
#' @param tree_dat decision tree data
#' @param label_probs_distns probability distribution names
#' @param label_costs_distns cost distribution names
#' @param state_list State list
#' @param n default 100
#'
#' @return
#' @export
#'
#' @examples
#'
dectree <- function(tree_dat,
                    label_probs_distns,
                    label_costs_distns,
                    state_list,
                    n = 100) {
  ev_point <-
    tree_dat %>%
    define_model(dat_long = .) %>%
    dectree_expected_values()

  # PSA ----

  tree_dat_sa <-
    tree_dat %>%
    select(-prob, -vals) %>%
    dplyr::left_join(label_probs_distns,
                     by = "name.prob") %>%
    dplyr::left_join(label_costs_distns,
                     by = "name.cost") %>%
    as_tibble()

  model_sa <- list()

  for (i in seq_len(n)) {

    model_sa[[i]] <-
      define_model(
        dat_long =
          data.frame(
            from = tree_dat_sa$from,
            to   = tree_dat_sa$to,
            prob = unlist(
              lapply(tree_dat_sa$prob, sample_distributions)),
            vals = unlist(
              lapply(tree_dat_sa$vals, sample_distributions))),
        fill_probs = TRUE)
  }

  ev_sa <- map_df(model_sa, dectree_expected_values)

  # pathway joint probabilities ----

  term_pop_point <-
    tree_dat %>%
    define_model(dat_long = ., fill_edges = FALSE) %>%
    terminal_pop(state_list)

  term_pop_sa <-
    map_df(model_sa, terminal_pop, state_list)

  list(ev_point = ev_point,
       ev_sa = ev_sa,
       term_pop_point = term_pop_point,
       term_pop_sa = term_pop_sa)
}
