
#' Create Cost-Effectiveness Tree For Long Dataframe
#'
#' Completely specifying cost-effectiveness decision tree.
#' Matches labels on branches to the corresponding
#' probabilities and cost/utility values.
#'
#' @param tree_list Parent-child ids format
#' @param tree_mat Matrix format
#' @param label_probs List
#' @param label_costs List
#' @param pname_from_to Dataframe name, from, to
#' @param cname_from_to Dataframe name, from, to
#' @param label_health Health labels
#' @param hname_from_to Health names for from-to edges
#'
#' @return Long format dataframe for input to `define_model()`
#'         or `dectree()`. Note this is for a single edge value
#'         type (e.g. cost or QALY). Use `run_cedectree()` for
#'         cost and health.
#' @import dplyr reshape2
#' @export
#' @seealso [CEdecisiontree::define_model()]
#'          [CEdecisiontree::dectree()]
#'          [CEdecisiontree::run_cedectree()]
#' @examples
#'
create_ce_tree_long_df <- function(tree_list = NA,
                                   tree_mat = NA,
                                   label_probs,
                                   label_costs,
                                   label_health,
                                   pname_from_to,
                                   cname_from_to,
                                   hname_from_to) {

  if (!all(is.na(tree_list))) {
    probs <- child_list_to_transmat(tree_list)
  }
  else if (!all(is.na(tree_mat))) {
    probs <- tree_mat
  } else {
    stop("Require a tree structure object.")
  }

  if (inherits(label_probs, "list")) {

    label_probs <-
      as_tibble(label_probs) %>%
      melt(value.name = "prob",
           variable.name = "name")
  }

  if (inherits(label_costs, "list")) {

    label_costs <-
      as_tibble(label_costs) %>%
      melt(value.name = "cost",
           variable.name = "name")
  }

  if (inherits(label_health, "list")) {

    label_health <-
      as_tibble(label_health) %>%
      melt(value.name = "health",
           variable.name = "name")
  }

  probs_names <-
    probs %>%
    transmat_to_long() %>%
    match_branch_to_label(pname_from_to) %>%
    match_branchlabel_to_prob(label_probs) %>%
    fill_complementary_probs()

  costs_names <-
    merge(cname_from_to, label_costs,
          by = "name",
          all.x = TRUE) %>%
    mutate(from = as.numeric(as.character(from)),
           to = as.numeric(as.character(to)))

  health_names <-
    merge(hname_from_to, label_health,
          by = "name",
          all.x = TRUE) %>%
    mutate(from = as.numeric(as.character(from)),
           to = as.numeric(as.character(to)))

  all_long <-
    merge(costs_names, probs_names,
          all.y = TRUE,
          by = c("from", "to"),
          suffixes = c(".cost", ".prob")) %>%
    merge(health_names,
          all = TRUE,
          by = c("from", "to")) %>%
    rename(name.health = name)

  return(all_long)
}

