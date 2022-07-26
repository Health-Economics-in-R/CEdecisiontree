
#' Long format to transition matrix
#'
#' @param dat array of from, to, prob, vals
#' @param val_col default prob
#'
#' @return transition matrix
#' @export
#'
#' @examples
#'
#' dat <- data.frame(from = c(NA,1, 1),
#'                   to = c(1, 2, 3),
#'                   prob = c(NA, 0.5, 0.5),
#'                   vals = c(0, 1, 2))
#' long_to_transmat(dat)
#'
long_to_transmat <- function(dat,
                             val_col = "prob"){

  dat <- dat[!is.na(dat$from), ]
  dat <- dat[, c("from", "to", val_col)]

  # include missing from nodes so that transmat
  # has the right number of rows/square
  missing_nodes <- setdiff(1:max(dat$to), dat$from)
  missing_rows <-
    setNames(data.frame(missing_nodes, 2, NA),
             names(dat))

  dat <-
    dat %>%
    rbind(missing_rows) %>%
    dplyr::arrange(from)

  suppressMessages(
    reshape2::dcast(formula = from ~ to,
                    data = dat)[, -1] %>%  # remove from column
      data.frame("1" = NA, .,
                 check.names = FALSE))
}


#' Transition matrix to long format
#'
#' @param probs probability transition matrix
#'
#' @return array of from, to, prob
#' @export
#'
#' @examples
#'
#' tree <- list(prob = matrix(data = c(NA, 0.5, 0.5), nrow = 1),
#'               vals = matrix(data = c(NA, 1, 2), nrow = 1)#'               )
#'
#' transmat_to_long(tree$prob)
#'
transmat_to_long <- function(probs) {

  probs %>%
    mutate('from' = rownames(.)) %>%
    reshape2::melt(id.vars = "from",
                   variable.name = 'to',
                   value.name = 'prob') %>%
    na.omit()
}
