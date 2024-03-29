
#' Decision tree estimation
#'
#' Single edge value (e.g. cost or QALY) wrapper.
#'
#' @template args-dat_long
#' @param label_probs_distns Probability distribution names
#' @param label_vals_distns Value distribution names
#' @param state_list State list sets, usually terminal nodes
#' @param vals_col Name of values column; defaults to vals
#' @param n Number of PSA samples; default 100
#'
#' @return List of expected values at each node,
#'         joint probabilities at terminal state set
#'         and PSA samples of these if distributions provided.
#' @import purrr
#' @import dplyr
#' @export
#'
#' @examples
#' library(purrr)
#' library(tibble)
#'
#' dat_long <-
#'  tribble(
#'    ~from, ~to, ~vals, ~prob,
#'    1,  2,   10,   0.7,
#'    1,  3,   NA,   0.3,
#'    2,  4,  100,   0.1,
#'    2,  5,   NA,   0.9,
#'    3,  6,  100,   0.9,
#'    3,  7,   NA,   0.1)
#'
#' dectree(dat_long,
#'    state_list = list(all = c(4,5,6,7)))
#'
dectree <- function(dat_long,
                    label_probs_distns = NULL,
                    label_vals_distns = NULL,
                    state_list = NULL,
                    vals_col = NA,
                    n = 100) {

  if (!is.na(vals_col))
    names(dat_long)[names(dat_long) == vals_col] <- "vals"

  # expected values
  ev_point <-
    define_model(dat_long = dat_long) |>
    dectree_expected_values()

  # pathway joint probabilities
  term_pop_point <-
    define_model(dat_long = dat_long,
                 fill_edges = FALSE) |>
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

    dat_long_sa <-
      dat_long |>
      as_tibble() |>
      select(-.data$prob, -.data$vals) |>
      dplyr::left_join(label_probs_distns,
                       by = "name.prob") |>
      dplyr::left_join(label_vals_distns,
                       by = name_vals)

    model_sa <- list()

    for (i in seq_len(n)) {

      model_sa[[i]] <-
        define_model(
          dat_long =
            data.frame(
              from = dat_long_sa$from,
              to   = dat_long_sa$to,
              prob = map_dbl(dat_long_sa$prob, ~sample_distributions(.)),
              vals = map_dbl(dat_long_sa$vals, ~sample_distributions(.))),
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

