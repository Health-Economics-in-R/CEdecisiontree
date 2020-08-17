# new model validation  ---------------------------------------------------

#
validate_transmat <- function(transmat) {

  if (!is.list(transmat)) stop("transmat must be a list")
  if (length(transmat) != 2) stop("transmat must be length 2")
  if (!("prob" %in% names(transmat))) stop("Require named prob")
  if (!("vals" %in% names(transmat))) stop("Require named vals")
  if (dim(transmat$prob != dim(transmat$vals))) stop("Dimensions of probs and vals don't match")
  assert_that(is_prob_matrix(transmat$prob))

  transmat
}

#
validate_tree_dat <- function(tree_dat) {

  if (!is.list(tree_dat)) stop("tree must be a list")
  if (length(tree_dat) != 2) stop("tree must be length 2")
  if (!is.list(tree_dat$child)) stop("child must be a list")
  if (!("node" %in% names(tree_dat))) stop("Require named node")
  if (!("prob" %in% names(tree_dat))) stop("Require named prob")
  if (!("vals" %in% names(tree_dat))) stop("Require named vals")
  if (!all(tree_dat$dat$prob >= 0 & tree_dat$dat$prob <= 1)) {
    stop("prob must be between 0 and 1")
  }
  if(!all(as.character(tree_dat$dat$node) %in% names(tree_dat$child))) {
    stop("prob and vals assigned to node not in child list")
  }
  if (all(tree_dat$dat$node != 1)) stop("Require root node 1")

  tree_dat
}

#
validate_dat_long <- function(dat_long) {

  if (!is.data.frame(dat_long)) stop("dat_long must be a dataframe")
  if (!("prob" %in% names(dat_long))) stop("Require prob column")
  if (!("vals" %in% names(dat_long))) stop("Require vals column")

  dat_long
}

