
#' Cost-effectiveness decision tree expected values
#'
#' Root node expected value as the weighted mean of
#' probability and edge/node values e.g. costs or QALYS.
#'
#' The expected value at each node is calculate by
#'
#' \deqn{\hat{c}_i = c_i + \sum p_{ij} \hat{c}_j}
#'
#' The default calculation assumes that the costs are associated with the nodes.
#' An alternative would be to associate them with the edges.
#' For total expected cost this doesn't matter but for
#' the other nodes this is different to assuming the
#' costs are assigned to the nodes. The expected value would then be
#'
#' \deqn{\hat{c}_i = \sum p_{ij} (c_{ij} + \hat{c}_j)}
#'
#' @param vals Values on each edge/branch e.g. costs or QALYs (array)
#' @param p Transition probabilities matrix
#' @param dat Long node-edge value array; default: \code{NA}
#'
#' @return Expected value at each node (vector)
#' @export
#'
#' @examples
#'
#' # dectree_expected_default(vals, p)
#'
dectree_expected_default <- function(vals,
                                     p,
                                     dat = NA){

  if (!any(is.na(dat))) {

    p <- long_to_transmat(dat[, c("from", "to", "prob")])
    vals <- long_to_transmat(select(dat, -prob))
  }

  assert_that(is_prob_matrix(p))

  num_from_nodes <- nrow(vals)
  num_to_nodes <- ncol(vals)

  p <- as.matrix(p)
  vals <- as.matrix(vals)

  c_hat <- colSums(vals, na.rm = TRUE)

  for (i in num_from_nodes:1) {


    total <- 0
    for (j in 1:num_to_nodes) {

      if (!is.na(p[i,j])) {

        total <- total + p[i,j]*c_hat[j]
      }
    }
    c_hat[i] <- total + c_hat[i]

  }

  return(c_hat)
}

