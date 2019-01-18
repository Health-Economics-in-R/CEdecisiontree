


#' match_branch_to_label
#'
#' @param probs_long
#' @param probs_from_to_lookup
#'
#' @return
#' @export
#'
#' @examples
match_branch_to_label <- function(probs_long,
                                  probs_from_to_lookup) {

  merge(probs_long, probs_from_to_lookup,
        by = c("from", "to"), all.x = TRUE) %>%
    dplyr::select(-prob)
}


#' match_branchlabel_to_prob
#'
#' @param probs_names
#' @param branch_probs_long
#'
#' @return
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

#' fill_complementary_branch_probs
#'
#' @param probs_names
#'
#' @return
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
