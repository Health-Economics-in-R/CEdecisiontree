
#' Branch Joint Probability
#'
#' @param probs Branch conditional probabilities (array)
#'
#' @return
#' @export
#'
#' @examples
#' branch_joint_probs(probs) * cost
#'
branch_joint_probs <- function(probs) {

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
