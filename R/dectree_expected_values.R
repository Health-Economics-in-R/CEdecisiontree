
#' Decision Tree Expected Values
#'
#' Root node expected value as the weighted mean of
#' probability and edge/node values e.g. costs or QALYS.
#'
#' \deqn{\hat{C}_i = C_i + \sum p_{ij} \hat{C}_j}
#'
#'
#' At the moment, the default calculation assumes
#' that the costs are associated with the edges and not
#' the 'to' node.
#' For total expected cost this doesnt matter but for
#' the other nodes this is different to assuming the
#' costs are assigned to the nodes.
#'
#' \deqn{C_i = \sum p_{ij} (C_{ij} + C_j)}
#'
#' @param vals Values on each edge/branch e.g. costs or QALYs (array)
#' @param p Transition probabilities matrix
#' @param dat default: NA
#'
#' @return Expected value at each node (list)
#' @export
#' @family CEdecisiontree
#'
#' @examples
#'
dectree_expected_values.default <- function(vals,
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

# edge costs
# C++ structure
dectree_expected_values_C <- function(vals,
                                      p){

  assert_that(is_prob_matrix(p))

  num_from_nodes <- nrow(vals)
  num_to_nodes <- ncol(vals)

  c_hat <- rep(0, num_to_nodes)

  for (i in num_from_nodes:1) {

    total <- 0

    for (j in 1:num_to_nodes) {

      if (!is.na(vals[i,j])) {

        total <- total + p[i,j]*(vals[i,j] + c_hat[j])
      }
    }

    c_hat[i] <- total
  }

  return(c_hat)
}
