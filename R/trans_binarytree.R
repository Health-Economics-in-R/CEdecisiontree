
#' Transition matrix to binary tree
#'
#' This is adapted from mstate::trans.illness
#' Create a complete binary tree transition matrix.
#'
#' @param names Node names
#' @param depth Depth of tree
#'
#' @return Matrix of TRUE and FALSE
#' @export
#'
#' @examples
trans_binarytree <- function(names,
                             depth = 2)
{
  tmat <- matrix(NA, depth, 2*depth + 1)

  for (i in seq_len(depth)) {

    tmat[i, (2*i):(2*i + 1)] <- (2*i - 1):(2*i)
  }

  if (!missing(names))
    if (length(names) != depth)
      stop("incorrect length of \"names\" argument")

  dimnames(tmat) <- list(from = seq_len(depth), to = seq_len(2*depth + 1))
  return(tmat)
}
