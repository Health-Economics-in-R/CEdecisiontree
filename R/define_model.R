
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

    if (!is.list(transmat)) stop("transmat must be a list")
    if (length(transmat) != 2) stop("transmat must be length 2")
    if (!("prob" %in% names(transmat))) stop("Require prob")
    if (!("vals" %in% names(transmat))) stop("Require vals")
    assert_that(is_prob_matrix(transmat$prob))

    class(transmat) <- append("transmat", class(transmat))
    return(transmat)
  }
  if (!missing(tree_dat)) {

    if (!is.list(tree_dat)) stop("tree must be a list")
    if (length(tree_dat) != 2) stop("tree must be length 2")
    if (!is.list(tree_dat$child)) stop("child must be a list")

    class(tree_dat) <- c("tree_dat", class(tree_dat))
    return(tree_dat)
  }
  if (!missing(dat_long)) {

    if (!is.data.frame(dat_long)) stop("dat_long must be a dataframe")
    if (!("prob" %in% names(dat_long))) stop("Require prob column")
    if (!("vals" %in% names(dat_long))) stop("Require vals column")

    class(dat_long) <- append("dat_long", class(dat_long))
    return(dat_long)
  }
}
