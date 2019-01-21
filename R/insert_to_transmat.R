
#' insert_to_transmat
#'
#' @param dat long from-to array
#' @param mat transition matrix
#'
#' @return matrix
#' @export
#'
#' @examples
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

#' @rdname insert_to_transmat
#'
insert_to_costmat <- function(dat,
                              mat) {
  dat <- dat[ ,c("from", "to", "cost")]
  insert_to_transmat(dat, mat)
}

#' @rdname insert_to_transmat
#'
insert_to_probmat <- function(dat,
                              mat) {
  dat <- dat[ ,c("from", "to", "prob")]
  insert_to_transmat(dat, mat)
}
