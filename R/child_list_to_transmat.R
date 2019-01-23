
#' Get transition matrix from tree children list
#'
#' Get transition matrix from tree children list by parents.
#'
#' @param tree list.
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

    n_to <- length(tree[[i]])
    out[i, tree[[i]][1]] <- 1/n_to
    out[i, tree[[i]][2]] <- 1/n_to
  }

  return(data.frame(out, check.names = FALSE))
}
