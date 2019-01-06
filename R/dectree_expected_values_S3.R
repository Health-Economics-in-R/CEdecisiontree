
#' @export
dectree_expected_values <- function(dat)
  UseMethod("dectree_expected_values")



#' @rdname
#' @export
dectree_expected_values.tree_dat <- function(dat) {

  CEdecisiontree_recursive(dat$tree,
                           dat$vals)
}



#' @rdname
#' @export
dectree_expected_values.model_transmat <- function(dat){

  p <- dat$prob
  vals <- data$vals

  rows_sum_to_one <-
    apply(p, 1, function(x) sum(x, na.rm = TRUE)) %in% c(0, 1)

  if (!all(rows_sum_to_one)) {
    stop('rows must sum to 1')
  }

  # if(any(p>1) || any(p<0)) {
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

#' @rdname
#' @export
dectree_expected_values.dat_long <- function(dat) {

  dat <-
    list(probs = long_to_transmat(dat[, c("from", "to", "prob")]),
         vals = long_to_transmat(select(dat, -prob))
    )

  class(dat) <- append("transmat", class(dat))

  dectree_expected_values(dat)
}
