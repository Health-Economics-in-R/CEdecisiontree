
#' Decision Tree Expected Values With Node Costs
#'
#' \deqn{\hat{C}_i = C_i + \sum p_{ij} \hat{C}_j}
#'
#' @param vals Values on each edge/branch e.g. costs or QALYs (array)
#' @param p Transition probabilities (array)
#'
#' @return expected value at each node (list)
#' @export
#' @family CEdecisiontree
#'
#' @examples
dectree_expected_values_node <- function(vals,
                                         p){

  assert_that(is_prob_matrix(p))

  num_from_nodes <- nrow(vals)
  num_to_nodes <- ncol(vals)

  p <- as.matrix(p)
  vals <- as.matrix(vals)

  c_hat <- colSums(vals, na.rm = TRUE)

  for (i in num_from_nodes:1) {

    total <- 0
    print(paste("---", i, "-- init ", c_hat[i]))
    for (j in 1:num_to_nodes) {

      if (!is.na(p[i,j])) {
        print(paste("- Child", j, p[i,j], c_hat[j], sep = " -- "))

        total <- total + p[i,j]*c_hat[j]
      }
    }
    print(paste("total ",total))
    c_hat[i] <- total + c_hat[i]
    print(paste("updated chat: ",c_hat[i]))
  }

  return(c_hat)
}
