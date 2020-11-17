
#' Is object a transition probability matrix?
#'
#' @family assertions
#' @param probs matrix of transition probabilities
#' @param dp Decimal places; Tolerance for equivalence
#'
#' @return logical
#' @export
#'
#' @examples
#' \dontrun{
#' probs <- matrix(c(1,0,0,1), nrow = 2)
#' is_prob_matrix(probs)
#'
#' probs <- matrix(c(2,0,-1,1), nrow = 2)
#' assert_that(is_prob_matrix(probs))
#' }
#'
is_prob_matrix <- function(probs,
                           dp = 5) {

  total_probs <- round(rowSums(probs, na.rm = TRUE),
                       digits = dp)
  sum_to_one <- all(total_probs %in% c(0,1))
  zero_to_one <- all(0 <= probs & probs <= 1 | is.na(probs))
  sum_to_one && zero_to_one
}

assertthat::on_failure(is_prob_matrix) <- function(call, env = parent.env) {
  paste0("probs is not a probability matrix")
}

