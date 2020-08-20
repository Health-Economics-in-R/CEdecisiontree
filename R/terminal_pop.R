
#' terminal_pop
#'
#' @param model long format
#' @param state_list
#'
#' @return
#' @export
#'
#' @examples
#'
terminal_pop <- function(model,
                         state_list) {

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
