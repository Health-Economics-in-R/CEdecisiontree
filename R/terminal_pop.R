
#' terminal_pop
#'
#' Joint probabilities of sets of nodes.
#' This is useful to then provide starting state
#' populations to a Markov model.
#'
#' @param model dat_long format
#' @param state_list Groups of usually terminal nodes
#'
#' @return Vector of probabilities
#' @export
#'
#' @examples
#'
terminal_pop <- function(model,
                         state_list) {

  if (is.null(state_list)) return(NULL)

  res <- list()
  state_names <- names(state_list)

  for (i in seq_along(state_list)) {

    res[[state_names[i]]] <-
      branch_joint_probs(
        model,
        nodes = state_list[[i]]) %>%
      map_dbl(prod) %>%
      sum()
  }

  return(res)
}
