
#' Define model
#'
#' Basic constructor for decision tree classes for different data formats.
#'
#' @param transmat Transition probability matrix (from-to node)
#' @param tree_dat Hierarchical tree structure of parents and children
#' @param dat_long Long dataframe with from, to, prob, vals columns
#'
#' @return transmat, tree_dat or dat_long class object
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
                         dat_long) {

  if (!missing(transmat)) {

    transmat %>%
      validate_transmat() %>%
      return()
  }
  if (!missing(tree_dat)) {

    tree_dat %>%
      validate_tree_dat() %>%
      return()
  }
  if (!missing(dat_long)) {

    dat_long %>%
      validate_dat_long() %>%
      return()
  }

  stop("All tree data inputs are missing.")
}
