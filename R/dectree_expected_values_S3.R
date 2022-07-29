
#' Cost-effectiveness decision tree expected values
#'
#' Root node expected value as the weighted mean of
#' probability and edge/node values e.g. costs or QALYS.
#'
#' The expected value at each node is calculate by
#'
#' \deqn{\hat{c}_i = c_i + \sum p_{ij} \hat{c}_j}
#'
#' The default calculation assumes that the costs are associated with the nodes.
#' An alternative would be to associate them with the edges.
#' For total expected cost this doesn't matter but for
#' the other nodes this is different to assuming the
#' costs are assigned to the nodes. The expected value would then be
#'
#' \deqn{\hat{c}_i = \sum p_{ij} (c_{ij} + \hat{c}_j)}
#'
#' @param model Object of \code{define_model()} consisting of output of type
#'             \code{tree_dat}, \code{transmat} or \code{dat_long}
#' @param ... Additional parameters
#'
#' @return Expected value at each node
#' @seealso \code{\link{define_model}}
#'
#' @export
#' @examples
#' data("cost")
#' data("probs")
#'
#' my_model <-
#'   define_model(
#'     transmat = list(vals = cost,
#'                     prob = probs))
#'
#' dectree_expected_values(model = my_model)
#'
dectree_expected_values <- function(model, ...)
  UseMethod("dectree_expected_values", model)


#' @rdname dectree_expected_values
#'
#' @export
#'
dectree_expected_values.tree_dat <- function(model, ...) {

  dectree_expected_recursive(names(model$child)[1],
                             model$child,
                             model$dat)
}

#' @rdname dectree_expected_values
#' @export
#'
dectree_expected_values.transmat <- function(model, ...){

  dectree_expected_default(model$vals,
                           model$prob)
}

#' @rdname dectree_expected_values
#' @export
#'
dectree_expected_values.dat_long <- function(model, ...) {

  val_name <-
    names(model)[!names(model) %in% c("from", "to", "prob")][1]
  message(paste(val_name, "used for calculation."))

  model <-
    list(probs = long_to_transmat(model, "prob"),
         vals = long_to_transmat(model, val_name))

  class(model) <- append("transmat", class(model))

  dectree_expected_values(model)
}

