
#' Fill Complementary Probabilities
#'
#' Only one of each pair of branches is assigned a probability
#' and then the other event probability is filled-in afterwards.
#' This is good because specify fewer input values and
#' if sampling probabilities we don't know the complementary
#' probability.
#'
#' Only works for binary trees or when one of n is missing.
#'
#' @template args-dat_long
#'
#' @return Long format tree object
#' @export
#'
#' @examples
#' dat <- tibble::tribble(~from, ~to, ~prob, ~vals,
#'                        1,  2,  NA,    10,
#'                        1,  3,  0.8,    1,
#'                        2,  4,  0.2,   10,
#'                        2,  5,  NA,     1,
#'                        3,  6,  0.2,   10,
#'                        3,  7,  0.8,    1)
#' fill_complementary_probs(dat)
#'
fill_complementary_probs <- function(dat_long) {

  # Check if any from node has more than 1 NA probability branch
  na_counts <- dat_long |>
    group_by(.data$from) |>
    summarise(na_count = sum(is.na(.data$prob)), .groups = "drop")

  if (any(na_counts$na_count > 1)) {
    warning("More than one branch has an NA probability for a given 'from' node. Complementary probabilities cannot be uniquely determined.")
  }

  dat_long |>
    group_by(.data$from) |>
    mutate(prob = ifelse(is.na(.data$prob),
                         1 - sum(.data$prob, na.rm = TRUE),
                         .data$prob)) |>
    ungroup()
}
