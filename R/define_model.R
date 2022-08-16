
#' Define decision tree model
#'
#' Basic constructor for decision tree classes for
#' different data formats.
#'
#' @template args-transmat
#' @template args-tree_dat
#' @template args-dat_long
#' @param ... additional arguments
#'
#' @return transmat, tree_dat or dat_long class object
#' @import dplyr
#'
#' @export
#'
#' @examples
#'
#' define_model(transmat =
#'               list(prob = matrix(data=c(NA, 0.5, 0.5), nrow = 1),
#'                    vals = matrix(data=c(NA, 1, 2), nrow = 1)
#'               ))
#'
#' define_model(tree_dat =
#'               list(child = list("1" = c(2, 3),
#'                                 "2" = NULL,
#'                                 "3" = NULL),
#'                    dat = data.frame(node = 1:3,
#'                                     prob = c(NA, 0.5, 0.5),
#'                                     vals = c(0, 1, 2))
#'               ))
#'
#' define_model(dat_long = data.frame(from = c(NA, 1, 1),
#'                                    to = 1:3,
#'                                    prob = c(NA, 0.5, 0.5),
#'                                    vals = c(0, 1, 2)))
define_model <- function(transmat,
                         tree_dat,
                         dat_long, ...) {

  if (missing(transmat) &&
      missing(tree_dat) &&
      missing(dat_long))
    stop("All tree data inputs are missing.")

  if (!missing(transmat)) {

    return(
      new_transmat(transmat, ...))
  }
  if (!missing(tree_dat)) {

     return(
      new_tree_dat(tree_dat, ...))
  }
  if (!missing(dat_long)) {

    return(
      new_dat_long(dat_long, ...))
  }
}
