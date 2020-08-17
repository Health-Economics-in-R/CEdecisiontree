# new model constructors --------------------------------------------------

#
new_transmat <- function(transmat) {

  if (length(transmat) != 2 & all(c("prob", "vals") %in% names(transmat))) {
    transmat[c("prob", "vals")]
  }

  validate_transmat(transmat)

  class(transmat) <- append("transmat", class(transmat))

  transmat
}

#
new_tree_dat <- function(tree_dat) {

  if (length(tree_dat) != 2 & all(c("child", "dat") %in% names(tree_dat))) {
    tree_dat[c("child", "dat")]
  }
  # include root node
  if (all(tree_dat$dat$node != 1)) {
    tree_dat$dat$node <- rbind(c(1, NA_real_, 0),
                               tree_dat$dat)
  }

  validate_tree_dat(tree_dat)

  class(tree_dat) <- c("tree_dat", class(tree_dat))
}

##TODO...
#
new_dat_long <- function(dat_long) {

  dat_long$vals[is.na(dat_long$vals)] <- 0
  missing_from <- which(!seq_len(max(dat_long$to)) %in% dat_long$from)
  dat_long <- rbind.data.frame(dat_long,
                               data.frame(from = missing_from,
                                          to = max(dat_long$to),
                                          vals = NA,
                                          prob = NA))

  validate_dat_long(dat_long)

  class(dat_long) <- append("dat_long", class(dat_long))
}
