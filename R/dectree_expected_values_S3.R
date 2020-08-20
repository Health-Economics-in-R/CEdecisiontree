
#' dectree_expected_values
#'
#' @param model List as \code{define_model()} output of type
#'             \code{tree_dat}, \code{transmat} or \code{dat_long}
#' @rdname dectree_expected_values.default
#' @export dectree_expected_values
#'
dectree_expected_values <- function(model, ...)
  UseMethod("dectree_expected_values", model)

#' dectree_expected_values.tree_dat
#'
#' @rdname dectree_expected_values
#' @export dectree_expected_values.tree_dat
#' @export
dectree_expected_values.tree_dat <- function(model) {

  dectree_expected_recursive(names(model$child)[1],
                             model$child,
                             model$dat)
}

#' dectree_expected_values.transmat
#'
#' @rdname dectree_expected_values
#' @export dectree_expected_values.transmat
#' @export
dectree_expected_values.transmat <- function(model){

  dectree_expected_values(model$vals,
                          model$prob)
}

#' dectree_expected_values.dat_long
#'
#' @rdname dectree_expected_values
#' @export dectree_expected_values.dat_long
#' @export
dectree_expected_values.dat_long <- function(model) {

  val_name <-
    names(model)[!names(model) %in% c("from", "to", "prob")][1]
  message(paste(val_name, "used for calculation."))

  model <-
    list(probs = long_to_transmat(model, "prob"),
         vals = long_to_transmat(model, val_name))

  class(model) <- append("transmat", class(model))

  dectree_expected_values(model)
}
