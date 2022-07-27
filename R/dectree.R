
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
#' @import purrr
#' @export
#'
#' @examples
#' library(purrr)
#' library(tibble)
#'
#' tree_dat <-
#'  tribble(
#'    ~from, ~to, ~vals, ~prob,
#'    1,  2,   10,   0.7,
#'    1,  3,   NA,   0.3,
#'    2,  4,  100,   0.1,
#'    2,  5,   NA,   0.9,
#'    3,  6,  100,   0.9,
#'    3,  7,   NA,   0.1)
#'
#' dectree(tree_dat,
#'    state_list = list(all = c(4,5,6,7)))
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

  point_params <-
    list(ev_point = ev_point,
         term_pop_point = term_pop_point)

  psa_params <- NULL

  # PSA ----

  if (!is.null(label_probs_distns) &&
      !is.null(label_vals_distns)) {

    name_vals <- intersect(names(label_vals_distns),
                           c("name.cost", "name.health"))

    tree_dat_sa <-
      tree_dat %>%
      as_tibble() %>%
      select(-prob, -vals) %>%
      dplyr::left_join(label_probs_distns,
                       by = "name.prob") %>%
      dplyr::left_join(label_vals_distns,
                       by = name_vals)

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
          fill_probs = TRUE,
          fill_edges = FALSE)
    }

    ev_sa <- map_df(model_sa, dectree_expected_values)

    term_pop_sa <-
      map_df(model_sa, terminal_pop, state_list)

    psa_params <-
      list(ev_sa = ev_sa,
           term_pop_sa = term_pop_sa)
  }

  c(point_params, psa_params)
}

