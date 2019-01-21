
#' Long format to transition matrix
#'
#' @param dat array of from, to, prob, vals
#'
#' @return transition matrix
#' @export
#'
#' @examples
#'
long_to_transmat <- function(dat){

  reshape2::dcast(formula = from ~ to,
                  data = dat)[ ,-1] %>%
    data.frame("1" = NA, .,
               check.names = FALSE)
}


#' Transition matrix to long format
#'
#' @param probs probability transition matrix
#'
#' @return array of from, to, prob
#' @export
#'
#' @examples
#'
transmat_to_long <- function(probs) {

  probs %>%
    mutate('from' = rownames(.)) %>%
    reshape2::melt(id.vars = "from",
                   variable.name = 'to',
                   value.name = 'prob') %>%
    na.omit()
}
