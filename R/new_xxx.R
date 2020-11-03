# new model constructors --------------------------------------------------

#' new_transmat
#'
new_transmat <- function(transmat, ...) {

  if (length(transmat) != 2 &&
      all(c("prob", "vals") %in% names(transmat))) {
    transmat <- transmat[c("prob", "vals")]
  }

  validate_transmat(transmat)

  structure(transmat, class = c("transmat", class(transmat)))
}


#' new_tree_dat
#'
new_tree_dat <- function(tree_dat, ...) {

  if (length(tree_dat) != 2 &&
      all(c("child", "dat") %in% names(tree_dat))) {
    tree_dat <- tree_dat[c("child", "dat")]
  }
  # include root node
  if (all(tree_dat$dat$node != 1)) {
    tree_dat$dat$node <- rbind(c(1, NA_real_, 0),
                               tree_dat$dat)
  }

  validate_tree_dat(tree_dat)

  structure(tree_dat, class = c("tree_dat", class(tree_dat)))
}

#' new_dat_long
#'
#' @param dat_long Long format tree data
#' @param fill_edges If need missing edges to connect to a sink state
#' @param fill_probs Fill in missing probabilities
#'
#' @export
#'
new_dat_long <- function(dat_long,
                         fill_edges = TRUE,
                         fill_probs = FALSE) {

  validate_dat_long(dat_long)

  keep_cols <- names(dat_long) %in% c("from", "to", "vals", "prob")

  if (any(!keep_cols))
    message(c("Removing column(s) ",
              paste(names(dat_long)[!keep_cols], collapse = " ")))
  dat_long <- dat_long[, keep_cols]

  if (fill_edges) {
    missing_from <-
      which(!seq_len(max(dat_long$to)) %in% dat_long$from)

    dat_long <-
      rbind.data.frame(dat_long,
                       data.frame(from = missing_from,
                                  to = max(dat_long$to) + 1,
                                  vals = NA,
                                  prob = NA))
  }

  dat_long$vals[is.na(dat_long$vals)] <- 0

  if (fill_probs)
    dat_long <- fill_complementary_probs(dat_long)

  structure(dat_long, class = c("dat_long", class(dat_long)))
}
