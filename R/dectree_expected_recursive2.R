
#' Cost-effectiveness decision tree using recursive approach for more than 2 child nodes
#'
#' @param node Node at which total expected value is to be calculate at
#' @param tree List of children by parents
#' @param vals Node labels, branch probabililities and value; dataframe
#'
#' @return Expected value at root node
#' @export
#' @seealso CEdecisiontree
#' @family CEdecisiontree
#'
#' @examples
#'
#' tree <-
#'   list("1" = c(2,3,5),
#'        "2" =  4,
#'        "3" =  c(6,7),
#'        "4" =  c(),
#'        "5" =  c(),
#'        "6" =  c(),
#'        "7" =  c())
#' dat <-
#'   data.frame(node = 1:7,
#'              prob = c(NA, rep(1, 6)),
#'              vals = c(10,2,3,16,5,6,7))
#'
#' root <- names(tree)[1]
#' dectree_expected_recursive2(node = root, tree, dat)
#'
dectree_expected_recursive2 <- function(node, tree, dat) {

  if (is.na(node)) {
    return(0)
  }

  c_node <- dat$vals[dat$node == node]

  child_idx <- tree[[node]]

  if (is.null(child_idx)) {
    return(c_node)
  } else {

    if (any(is.na(probs))) probs <- 0

    Ec <-
      purrr::map_dbl(
        child_idx,
        ~dat$prob[dat$node == .]*dectree_expected_recursive2(., tree, dat))

    return(c_node + sum(Ec))
  }
}

