
#' New Model Validation
#' @name validation
NULL


#' @rdname validation
#' @param transmat Transition probability matrix
#' @importFrom assertthat assert_that
#' @export
#'
validate_transmat <- function(transmat) {

  if (!is.list(transmat)) stop("transmat must be a list")
  if (length(transmat) != 2) stop("transmat must be length 2")
  if (!("prob" %in% names(transmat))) stop("Require named prob")
  if (!("vals" %in% names(transmat))) stop("Require named vals")
  if (dim(transmat$prob)[1] != dim(transmat$vals)[1])
    stop("First dimension of probs and vals don't match")
  if (dim(transmat$prob)[2] != dim(transmat$vals)[2])
    stop("Second dimension of probs and vals don't match")
  assert_that(is_prob_matrix(transmat$prob))

  transmat
}


#' @rdname validation
#' @param tree_dat Tree data
#' @export
#'
validate_tree_dat <- function(tree_dat) {

  if (!is.list(tree_dat)) stop("tree must be a list")
  if (length(tree_dat) != 2) stop("tree must be length 2")
  if (!("child" %in% names(tree_dat))) stop("Require named child")
  if (!("dat" %in% names(tree_dat))) stop("Require named dat")
  if (!is.list(tree_dat$child)) stop("child must be a list")
  if (!("node" %in% names(tree_dat$dat))) stop("Require named node")
  if (!("prob" %in% names(tree_dat$dat))) stop("Require named prob")
  if (!("vals" %in% names(tree_dat$dat))) stop("Require named vals")
  if (!all(tree_dat$dat$prob >= 0 | is.na(tree_dat$dat$prob)))
    stop("prob must be non-negative")
  if (!all(tree_dat$dat$prob <= 1 | is.na(tree_dat$dat$prob)))
    stop("prob must be no larger than 1")
  if (!all(as.character(tree_dat$dat$node) %in% names(tree_dat$child))) {
    stop("prob and vals assigned to node not in child list")
  }
  if (all(tree_dat$dat$node != 1)) stop("Require root node 1")

  tree_dat
}


#' @rdname validation
#' @param dat_long Long format data
#' @export
#'
validate_dat_long <- function(dat_long) {

  if (!is.data.frame(dat_long)) stop("dat_long must be a dataframe")
  if (!("prob" %in% names(dat_long))) stop("Require prob column")
  if (!("vals" %in% names(dat_long))) stop("Require vals column")

  dat_long
}

