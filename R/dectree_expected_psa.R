
#' @export
dectree_expected_psa <- function(tree_dat, n = 1000) {
  tree_dat_sa <- create_psa_inputs(tree_dat, n)
  map_dbl(tree_dat_sa, dectree_expected_values)
}
