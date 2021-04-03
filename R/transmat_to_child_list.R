
#' Create tree children list from transition matrix
#'
#' Create tree children list by parents from a transition matrix.
#'
#' @param transmat from-to matrix with \code{NA} for missing values.
#'
#' @return list
#' @export
#'
#' @examples
#'
#' transmat <-
#'   list(prob = matrix(data = c(NA, 0.5, 0.5), nrow = 1),
#'          vals = matrix(data = c(NA, 1, 2), nrow = 1)
#'        )
#' transmat_to_child_list(transmat$prob)
#'
transmat_to_child_list <- function(transmat) {

  empty_rows <-
    matrix(NA,
           ncol = ncol(transmat),
           nrow = ncol(transmat) - nrow(transmat)) %>%
    `colnames<-`(colnames(transmat))

  transmat <- rbind.data.frame(transmat, empty_rows)

  split(!is.na(transmat),
        seq_len(nrow(transmat))) %>%
    lapply(which)
}

