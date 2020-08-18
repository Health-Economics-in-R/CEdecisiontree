
#' Insert to transition matrix
#'
#' Insert values into a transition matrix
#' from a long array of \code{from}, \code{to} values
#'
#' @param dat long from-to-vals array. Either cost or prob.
#' @param mat transition matrix
#'
#' @return matrix
#' @export
#'
#' @examples
#'
#' #insert_to_transmat(dat, mat)
#'
insert_to_transmat <- function(dat,
                               mat) {

  for (r in seq_len(nrow(dat))) {

    i <- dat$from[r]
    j <- dat$to[r]

    mat[i, j] <-
      dat %>%
      filter(from == i,
             to == j) %>%
      select(-from, -to)
  }

  mat
}

#' Insert to cost matrix
#'
#' Insert values into a cost matrix
#' from a long array of \code{from}, \code{to} values
#'
#' @rdname insert_to_transmat
#' @export
#'
insert_to_costmat <- function(dat,
                              mat) {
  dat <- dat[ ,c("from", "to", "cost")]
  insert_to_transmat(dat, mat)
}

#' Insert to probability matrix
#'
#' Insert values into a probability matrix
#' from a long array of \code{from}, \code{to} values
#'
#' @rdname insert_to_transmat
#' @export
#'
insert_to_probmat <- function(dat,
                              mat) {
  dat <- dat[ ,c("from", "to", "prob")]
  insert_to_transmat(dat, mat)
}
