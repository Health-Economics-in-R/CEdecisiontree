
#' create_ce_tree_df
#'
#' Using look up table, rather than separate lists,
#' of values and labels.
#' Can prepare these external to R and read them in.
#'
#' @param label_branch_tab Look up table
#' @param label_val_tab Look up table
#' @param tree_struc List of parent child branches
#'
#' @return tibble in long format
#' @export
#'
create_ce_tree_df <- function(label_branch_tab,
                              label_val_tab,
                              tree_struc) {

  # data frame version of tree structure list
  tree_struc_long <-
    melt(tree_struc) |>
    setNames(c("to", "from")) |>
    relocate(from)

  merge(label_branch_tab, label_val_tab,
        by = c("unit", "label")) |>
    dcast(from + to ~ unit, value.var = "val") |>
    merge(tree_struc_long, all = TRUE) |>
    arrange(from, to) |>
    fill_complementary_probs()
}
