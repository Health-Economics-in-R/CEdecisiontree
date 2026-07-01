
#' Create transition matrix from tree children list
#'
#' Create transition matrix from tree children list by parents.
#'
#' @param tree parent-child node list.
#'
#' @return matrix
#' @export
#'
#' @examples
#'
#' child_list_to_transmat(tree =
#'                          list('1' = c(2, 3),
#'                               '2' = c(4),
#'                               '3' = c(6, 7)))
#'
child_list_to_transmat <- function(tree) {

  n_nodes <- max(unlist(tree))
  out <- matrix(NA, nrow = n_nodes, ncol = n_nodes)

  for (i in seq_along(tree)) {
    children <- tree[[i]]
    n_to <- length(children)
    if (n_to > 0) {
      for (child in children) {
        if (!is.na(child)) {
          out[i, child] <- 1/n_to
        }
      }
    }
  }

  return(data.frame(out, check.names = FALSE))
}
