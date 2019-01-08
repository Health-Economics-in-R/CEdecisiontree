
#' Get tree children list
#'
#' @param transmat from-to matrix with \code{NA} for missing values.
#'
#' @return
#' @export
#'
#' @examples
get_children_list <- function(transmat) {

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
