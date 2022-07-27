
#' Match branch label to probabilities
#'
#' We have a look-up table of labels and values.
#' We can join the values to nodes/edges via their labels.
#'
#' @param probs_names label-probability look-up
#' @param branch_probs_long long format tree object with labels
#'
#' @return dataframe
#' @export
#' @seealso \link{match_branch_to_label}
#'
#' @examples
#' probs_long <-
#'   tibble::tribble(~from, ~to, ~name,
#'                   1, 2, "pos",
#'                   1, 3, "neg")
#' probs_names <-
#'   tibble::tribble(~prob, ~name,
#'                   0.4, "pos",
#'                   0.6, "neg")
#'
#' match_branchlabel_to_prob(probs_names, probs_long)
#'
match_branchlabel_to_prob <- function(probs_names,
                                      branch_probs_long) {

  dplyr::left_join(probs_names, branch_probs_long,
                   by = "name") %>%
    mutate(from = as.numeric(as.character(from)),
           to = as.numeric(as.character(to)))
}
