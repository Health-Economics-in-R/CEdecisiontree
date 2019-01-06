
#' long_to_transmat
#'
#' @param dat
#'
#' @return
#' @export
#'
#' @examples
long_to_transmat <- function(dat){

  reshape2::dcast(formula = from ~ to,
                  data = dat)[ ,-1] %>%
    data.frame("1" = NA, .,
               check.names = FALSE)
}

