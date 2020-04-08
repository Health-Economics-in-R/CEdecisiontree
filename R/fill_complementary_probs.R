
#' Fill complementary probabilities
#'
#' Only one of each pair of branches is assigned a probability
#' and then the other event probability is filled-in afterwards.
#' This is good because specify fewer input values and
#' if sampling probabilities we don't know the complementary
#' probability.
#'
#' @param probs_names long format tree object
#'
#' @return dataframe
#' @export
#'
#' @examples
#'
fill_complementary_probs <- function(probs_names) {

  probs_names %>%
    group_by(from) %>%
    mutate(prob = ifelse(is.na(prob),
                         1 - sum(prob, na.rm = TRUE),
                         prob)) %>%
    ungroup()
}
