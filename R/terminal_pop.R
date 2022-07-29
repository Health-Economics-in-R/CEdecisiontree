
#' Terminal Leaf Node Populations
#'
#' Joint probabilities of sets of nodes.
#' This is useful to then provide starting state
#' populations to a Markov model.
#'
#' @param model dat_long class
#' @param state_list Groups of (usually) terminal nodes; List of vectors
#'
#' @return Vector of probabilities
#' @export
#'
#' @examples
#'
#' tree_dat <-
#'  tibble::tribble(
#'    ~from, ~to, ~vals, ~prob,
#'    1,  2,   10,   0.7,
#'    1,  3,   NA,   0.3,
#'    2,  4,  100,   0.1,
#'    2,  5,   NA,   0.9,
#'    3,  6,  100,   0.9,
#'    3,  7,   NA,   0.1)
#'
#' term_pop <-
#'   define_model(dat_long = tree_dat) |>
#'   terminal_pop(state_list = c(4,5,6,7))
#'
#' sum(unlist(term_pop))
#'
terminal_pop <- function(model,
                         state_list) {

  if (is.null(state_list)) return(NULL)

  res <- vector("list", length(state_list))
  names(res) <- names(state_list)

  for (i in seq_along(state_list)) {

    res[[i]] <-
      branch_joint_probs(
        model,
        nodes = state_list[[i]]) %>%
      map_dbl(prod) %>%
      sum()
  }

  return(res)
}
