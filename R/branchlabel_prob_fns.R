
#' Match branch to label
#'
#' @param probs_long
#' @param probs_from_to_lookup
#'
#' @return dataframe
#' @export
#'
#' @examples
match_branch_to_label <- function(probs_long,
                                  probs_from_to_lookup) {

  merge(probs_long, probs_from_to_lookup,
        by = c("from", "to"), all.x = TRUE) %>%
    dplyr::select(-prob)
}


#' Match branch label to probabilities
#'
#' @param probs_names
#' @param branch_probs_long
#'
#' @return dataframe
#' @export
#'
#' @examples
match_branchlabel_to_prob <- function(probs_names,
                                      branch_probs_long) {

  merge(probs_names, branch_probs_long,
        by = "name", all.x = TRUE) %>%
    mutate(from = as.numeric(as.character(from)),
           to = as.numeric(as.character(to)))
}


#' Fill complementary probabilities
#'
#' @param probs_names
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
