
#' Decision Tree Expected Values
#'
#' \deqn{C_i = \sum p_{ij} (C_{ij} + C_j)}
#'
#' @param vals Values on each edge (array) e.g. costs or QALYs
#' @param p Transition probabilities (array)
#'
#' @return expected value at each node (list)
#' @export
#'
#' @examples
#' dectree_expected_values(cost, probs)
#'

## this is the list version which
## dosent assume a binary tree structure
dectree_expected_values <- function(vals,
                                    p){
  rows_sum_to_one <-
    apply(p, 1, function(x) sum(x, na.rm = TRUE)) == 1

  if (!all(rows_sum_to_one)) {
    stop('rows must sum to 1')
  }

  # if(#####){
  #   stop('probabilities must be between 0 and 1')
  # }

  struct <- !is.na(vals)

  num_from_nodes <- nrow(struct)
  num_to_nodes <- ncol(struct)

  c_hat <- rep(0, num_to_nodes)

  for (i in rev(seq_len(num_from_nodes))) {

    J <- which(struct[i,])

    for (j in J) {

      c_hat[i] <- c_hat[i] + p[i,j]*(vals[i,j] + c_hat[j])
    }
  }

  return(c_hat)
}

# C++ structure
dectree_expected_values_C <- function(vals,
                                      p){

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
