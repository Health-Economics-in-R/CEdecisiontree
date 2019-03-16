
#' Match branch to label
#'
#' Assume that there are node labels and these may be non-unique.
#' We assign these labels by joining a lookup table of labels and edges
#' with the tree object, in this case the long array format.
#'
#' Separating the tree structure and labelling means that we can
#' reuse the same tree with different labels
#' e.g. another test or treatment
#'
#' @param probs_long Long format array tree object
#' @param probs_from_to_lookup edge-label look-up table
#'
#' @return dataframe
#' @export
#' @seealso \link{match_branchlabel_to_prob}
#'
#' @examples
#'
match_branch_to_label <- function(probs_long,
                                  probs_from_to_lookup) {

  merge(probs_long, probs_from_to_lookup,
        by = c("from", "to"), all.x = TRUE) %>%
    dplyr::select(-prob)
}


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


#' Fill complementary probabilities
#'
#' Only one of each pair of branches is assigned a probability
#' and then the other event probability is filled-in afterwards.
#' This is good because specify fewer input vallues and
#' if sampling probabilities we don't know the complementary
#' probability.
#'
#' @param probs_names long format tree object
#'
#' @return dataframe
#' @export
#'
#' @examples
fill_complementary_probs <- function(probs_names) {

  probs_names %>%
    group_by(from) %>%
    mutate(prob = ifelse(is.na(prob),
                         1 - sum(prob, na.rm = TRUE),
                         prob)) %>%
    ungroup()
}
