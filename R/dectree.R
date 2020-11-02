
#' Decision Tree
#'
#' Single edge value (e.g. cost or QALY) wrapper.
#'
#' @param tree_dat Decision tree data in `dat_long` format
#' @param label_probs_distns Probability distribution names
#' @param label_vals_distns Value distribution names
#' @param state_list State list sets, usually terminal nodes
#' @param n Number of PSA samples; default 100
#'
#' @return List of expected values at each node,
#'         joint probabilities at terminal state set
#'         and PSA samples of these if distributions provided.
#' @export
#'
#' @examples
#'
dectree <- function(tree_dat,
                    label_probs_distns = NULL,
                    label_vals_distns = NULL,
                    state_list = NULL,
                    n = 100) {

  # expected values
  ev_point <-
    tree_dat %>%
    define_model(dat_long = .) %>%
    dectree_expected_values()

  # pathway joint probabilities
  term_pop_point <-
    tree_dat %>%
    define_model(dat_long = .,
                 fill_edges = FALSE) %>%
    terminal_pop(state_list)

  # PSA ----

  if (!is.null(label_probs_distns) &&
      !is.null(label_vals_distns)) {

    tree_dat_sa <-
      tree_dat %>%
      select(-prob, -vals) %>%
      dplyr::left_join(label_probs_distns,
                       by = "name.prob") %>%
      dplyr::left_join(label_vals_distns,
                       by = "name.vals") %>%
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

    term_pop_sa <-
      map_df(model_sa, terminal_pop, state_list)
  }

  list(ev_point = ev_point,
       ev_sa = ev_sa,
       term_pop_point = term_pop_point,
       term_pop_sa = term_pop_sa)
}

