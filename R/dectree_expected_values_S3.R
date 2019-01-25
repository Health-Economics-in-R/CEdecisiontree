
#' @param model List as \code{define_model()} output of type \code{tree_dat}, \code{transmat} or \code{dat_long}
#' @rdname dectree_expected_values.default
#' @export dectree_expected_values
#'
dectree_expected_values <- function(model, ...)
  UseMethod("dectree_expected_values")

#' @rdname dectree_expected_values
#' @export dectree_expected_values.tree_dat
#' @export
dectree_expected_values.tree_dat <- function(model) {

  dectree_expected_recursive(names(model$child)[1],
                             model$child,
                             model$dat)
}

#' @rdname dectree_expected_values
#' @export dectree_expected_values.transmat
#' @export
dectree_expected_values.transmat <- function(model){

  dectree_expected_values(model$vals,
                          model$prob)
}

#' @rdname dectree_expected_values
#' @export dectree_expected_values.dat_long
#' @export
dectree_expected_values.dat_long <- function(model) {

  model <-
    list(probs = long_to_transmat(model[, c("from", "to", "prob")]),
         vals = long_to_transmat(dplyr::select(model, -prob))
    )

  class(model) <- append("transmat", class(model))

  dectree_expected_values(model)
}
