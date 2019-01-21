
#' fill_transmat
#'
#' @param dat long from-to array
#' @param mat transition matrix
#'
#' @return
#' @export
#'
#' @examples
#'
fill_transmat <- function(dat,
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

#
fill_costmat <- function(dat,
                         mat) {
  dat <- dat[ ,c("from", "to", "cost")]
  fill_transmat(dat, mat)
}

#
fill_probmat <- function(dat,
                         mat) {
  dat <- dat[ ,c("from", "to", "prob")]
  fill_transmat(dat, mat)
}
