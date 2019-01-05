
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
#'
#' vals <-
#'   data.frame(node = 1:7,
#'              probs = c(NA, rep(0.5, 6)),
#'              cost = c(10,2,3,16,5,6,7))
#'
#'  CEdecisiontree_recursive(tree, vals)
#'
CEdecisiontree_recursive <- function(tree,
                                     vals) {

  parent <- names(tree)[1]
  c_node <- vals$cost[vals$node == parent]
  child <- tree[[1]]

  if (is.null(child)) {
    return(c_node)

  } else {

    subtree <- rm_node_from_tree(tree, c(parent, child))
    subtreeL <- c(tree[as.character(child[1])], subtree)
    subtreeR <- c(tree[as.character(child[2])], subtree)

    pL <- vals$probs[vals$node == child[1]]
    pR <- vals$probs[vals$node == child[2]]

    return(c_node +
             pL*CEdecisiontree_recursive(subtreeL, vals) +
             pR*CEdecisiontree_recursive(subtreeR, vals))
  }
}

#
rm_node_from_tree <- function(tree,
                              node)
  tree[setdiff(names(tree), node)]
