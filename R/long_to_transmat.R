
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

