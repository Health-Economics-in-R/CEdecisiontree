
# edge costs
# C++ structure
dectree_expected_values_C <- function(vals,
                                      p){

  assert_that(is_prob_matrix(p))

  num_from_nodes <- nrow(vals)
  num_to_nodes <- ncol(vals)

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
