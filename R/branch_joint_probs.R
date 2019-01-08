
#' Branch Joint Probabilities
#'
#' This porvide a measure of the chances of following
#' particular paths.
#' These probabilities could be used to weight branch cost
#' or QALYs to indicate the relative contribution to the
#' total expected value.
#'
#' @param probs Branch conditional probabilities (matrix)
#'
#' @return transition matrix with joint probabilities
#' @export
#'
#' @examples
#' data(probs)
#' data(cost)
#' branch_joint_probs(probs) * cost
#'
branch_joint_probs <- function(probs) {

  assert_that(is_prob_matrix(probs))

  struct <- apply(probs, 2, function(x) !is.na(x))
  num_from_nodes <- nrow(struct)
  num_to_nodes <- ncol(struct)

  for (i in 1:num_from_nodes) {
    for (j in 1:num_from_nodes) {

      if (!is.na(probs[i, j])) {

        probs[j, ] <- probs[j, ] * as.numeric(probs[i, j])
      }
    }
  }
  return(probs)
}
