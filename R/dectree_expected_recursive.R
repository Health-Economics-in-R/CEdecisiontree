
#' Cost-effectiveness decision tree using recursive approach
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
#'   list("1" = c(2,3),
#'        "2" =  c(4,5),
#'        "3" =  c(6,7),
#'        "4" =  c(),
#'        "5" =  c(),
#'        "6" =  c(),
#'        "7" =  c())
#' dat <-
#'   data.frame(node = 1:7,
#'              prob = c(NA, rep(0.5, 6)),
#'              vals = c(10,2,3,16,5,6,7))
#'
#' root <- names(tree)[1]
#' dectree_expected_recursive(node = root, tree, dat)
#'
dectree_expected_recursive <- function(node,
                                       tree,
                                       dat) {

  if (is.na(node)) {
    return(0)
  }

  c_node <- dat$vals[dat$node == node]

  child <- tree[[node]]

  if (is.null(child)) {
    return(c_node)
  } else {

    pL <- dat$prob[dat$node == child[1]]
    pR <- dat$prob[dat$node == child[2]]

    if (any(is.na(pL))) pL <- 0
    if (any(is.na(pR))) pR <- 0

    return(c_node +
             pL*dectree_expected_recursive(child[1], tree, dat) +
             pR*dectree_expected_recursive(child[2], tree, dat))
  }
}

#
rm_node_from_tree <- function(tree, node)
  tree[setdiff(names(tree), node)]

