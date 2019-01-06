
#' define_model
#'
#' @param transmat
#' @param tree_dat
#' @param dat_long
#'
#' @return
#' @export
#'
#' @examples
#'
#'define_model(transmat =
#'               list(prob = matrix(data=c(NA, 0.5, 0.5), nrow = 1),
#'                    cost = matrix(data=c(NA, 1, 2), nrow = 1)
#'               ))
#'
#'define_model(tree_dat =
#'               list(child = list("1" = c(2, 3),
#'                                 "2" = NULL,
#'                                 "3" = NULL),
#'                    dat = data.frame(node = 1:3,
#'                                     prob = c(NA, 0.5, 0.5),
#'                                     cost = c(NA, 1, 2))
#'               ))
#'
#'define_model(dat_long = data.frame(from = c(NA, 1, 1),
#'                                    to = 1:3,
#'                                    prob = c(NA, 0.5, 0.5),
#'                                    cost = c(NA, 1, 2)))
define_model <- function(transmat,
                         tree_dat,
                         dat_long) {

  if(!missing(transmat)) {

    if (!is.list(transmat)) stop("transmat must be a list")
    if (length(transmat) != 2) stop("transmat must be length 2")

    class(transmat) <- append("transmat", class(transmat))
    return(transmat)
  }
  if(!missing(tree_dat)) {

    if (!is.list(tree_dat)) stop("tree must be a list")
    if (length(tree_dat) != 2) stop("tree must be length 2")
    if (!is.list(tree_dat[[1]])) stop("child must be a list")

    class(tree_dat) <- c("tree_dat", class(tree_dat))
    return(tree_dat)
  }
  if(!missing(dat_long)) {

    if (!is.data.frame(dat_long)) stop("dat_long must be a dataframe")
    if (!("prob" %in% names(dat_long))) stop("Require prob column")

    class(dat_long) <- append("dat_long", class(dat_long))
    return(dat_long)
  }
}
