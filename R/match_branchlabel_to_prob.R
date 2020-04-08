
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
#'
match_branchlabel_to_prob <- function(probs_names,
                                      branch_probs_long) {

  dplyr::left_join(probs_names, branch_probs_long,
                   by = "name") %>%
    mutate(from = as.numeric(as.character(from)),
           to = as.numeric(as.character(to)))
}
