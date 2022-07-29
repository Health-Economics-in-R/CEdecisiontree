
#' Create PSA inputs
#'
#' @param tree_dat parent-child and data format but with distributions
#' @param n Number of samples
#'
#' @return tree_dat realisations
#' @export
#'
create_psa_inputs <- function(tree_dat, n = 1000) {

  tree_dat_sa <- list()
  dat <- tree_dat$dat

  for (i in 1:1000) {

    tree_dat_sa[[i]] <-
      define_model(
        tree_dat =
          list(child = tree_dat$child,
               dat = data.frame(
                 node = dat$node,
                 prob = map_dbl(dat$prob, ~unlist(sample_distributions(.x))),
                 vals = map_dbl(dat$vals, ~unlist(sample_distributions(.x)))
               )))
  }

  tree_dat_sa
}
