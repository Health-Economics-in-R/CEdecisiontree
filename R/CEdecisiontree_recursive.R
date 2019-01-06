
#' CEdecisiontree_recursive
#'
#' @param tree List of children by parents
#' @param vals Node labels, probabililities and costs; dataframe
#'
#' @return Expected cost at root node
#' @export
#' @seealso CEdecisiontree
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
#' CEdecisiontree_recursive(node = root, tree, dat)
#'
CEdecisiontree_recursive <- function(node,tree,dat) {

  c_node <- dat$vals[dat$node == node]

  child <- tree[[node]]

  if (is.null(child)) {
    return(c_node)
  } else {

    pL <- dat$prob[dat$node == child[1]]
    pR <- dat$prob[dat$node == child[2]]

    return(c_node +
             pL*CEdecisiontree_recursive(child[1], tree, dat) +
             pR*CEdecisiontree_recursive(child[2], tree, dat))
  }
}

#
rm_node_from_tree <- function(tree,
                              node)
  tree[setdiff(names(tree), node)]
