
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
#' probs_long <-
#'   tibble::tribble(~from, ~to, ~prob,
#'                   1, 2, 0.5,
#'                   1, 3, 0.5)
#' pname_from_to <-
#'   tibble::tribble(~from, ~to, ~name,
#'                   1, 2, "pos",
#'                   1, 3, "neg")
#'
#' match_branch_to_label(probs_long, pname_from_to)
#'
match_branch_to_label <- function(probs_long,
                                  probs_from_to_lookup) {

  merge(probs_long, probs_from_to_lookup,
        by = c("from", "to"), all.x = TRUE) %>%
    dplyr::select(-prob)
}

