
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
dectree_expected_values <- function(vals,
                                    p){

  if (!all(apply(p, 1, function(x) sum(x, na.rm = TRUE)) == 1)) {
    stop('rows must sum to 1')
  }

  # if(#####){
  #   stop('probabilities must be between 0 and 1')
  # }

  struct <- apply(vals, 2, function(x) !is.na(x))

  child <- list()

  for (i in 1:nrow(struct)) {

    child[[i]] <- which(struct[i,])
  }

  num_from_nodes <- nrow(struct)
  num_to_nodes <- ncol(struct)

  c_hat <- rep(0, num_to_nodes)

  for (i in num_from_nodes:1) {

    J <- child[[i]]

    for (j in J) {

      c_hat[i] <- c_hat[i] + p[i,j]*(vals[i,j] + c_hat[j])
    }
  }

  return(c_hat)
}


