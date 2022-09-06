
#' Branch Joint Probabilities
#'
#' Provides a measure of the chances of following
#' particular paths through the decision tree.
#'
#' These probabilities could be used to weight branch costs
#' or QALYs to indicate the relative contribution to the
#' total expected value.
#'
#' @param model Branch conditional probabilities (matrix)
#' @param nodes Which nodes to return; default to all
#' @param ... Additional parameters
#'
#' @return Transition matrix with joint probabilities
#'
#' @export
#'
#' @examples
#'
#' model <-
#'   define_model(
#'     transmat =
#'       list(prob =
#'              matrix(data = c(NA, 0.5, 0.5, NA,  NA,  NA,  NA,
#'                              NA, NA, NA,   0.1, 0.9, NA,  NA,
#'                              NA, NA, NA,   NA,  NA,  0.9, 0.1),
#'                     nrow = 3,
#'                     byrow = TRUE),
#'            vals =
#'              matrix(data = c(NA, 1,  5,  NA, NA, NA, NA,
#'                              NA, NA, NA, 1,  9,  NA, NA,
#'                              NA, NA, NA, NA, NA, 9,  1),
#'                     nrow = 3,
#'                     byrow = TRUE)))
#' model
#'
#' branch_joint_probs(model)
#'
#' # weighted vals
#' branch_joint_probs(model)*model$vals
#'
#' # long data format
#' df <-
#'   data.frame(
#'     from = c(1,2,1),
#'     to = c(2,3,4),
#'     prob = c(0.1,0.5,0.9),
#'     vals = c(1,2,3))
#'
#' mod <- define_model(dat_long = df)
#'
#' branch_joint_probs(mod, nodes = 4)
#' #0.9
#'
#' branch_joint_probs(mod, nodes = 3)
#' #0.1*0.5
#'
#' branch_joint_probs(mod, nodes = 3)[[1]] |> cumprod()
#'
branch_joint_probs <- function(model, nodes = NA, ...)
  UseMethod("branch_joint_probs", model)


#' @rdname branch_joint_probs
#'
#' @export
#'
branch_joint_probs.transmat <- function(model,
                                        nodes = NA, ...) {
  if (is.na(nodes)) {
    nodes <- model$from[is.na(model$prob)]
  }

  probs <- as.matrix(model$prob)
  assert_that(is_prob_matrix(probs))

  keep_rows <- apply(probs, 1, function(x) !all(is.na(x)))
  probs <- probs[keep_rows, , drop = FALSE]

  num_from_nodes <- NROW(probs)
  num_to_nodes <- NCOL(probs)

  for (i in 1:num_from_nodes) {
    for (j in 1:num_from_nodes) {

      if (!is.na(probs[i, j])) {

        probs[j, ] <- probs[j, ] * as.numeric(probs[i, j])
      }
    }
  }
  return(probs)
}


#' @rdname branch_joint_probs
#'
#' @export
#'
branch_joint_probs.dat_long <- function(model,
                                        nodes = NA,
                                        cumul = FALSE, ...) {

  out <- list()

  terminal_node <- model$from[is.na(model$prob)]

  if (is.na(nodes)) {
    nodes <- terminal_node
  }

  if (!all(nodes %in% model$to))
    stop("Node not present in model", call. = FALSE)

  # remove NULL terminal nodes
  model <- model[!is.null(model$to), ]

  for (i in seq_along(nodes)) {

    to_node <- nodes[i]
    p_total <- 1

    while (to_node %in% model$to) {

      p_total <- c(p_total, model$prob[model$to == to_node])
      to_node <- model$from[model$to == to_node]
    }

    out[[i]] <-
      if (cumul) {cumprod(p_total)
    } else {p_total}
  }

  return(setNames(out, terminal_node))
}


#' @rdname branch_joint_probs
#' @export
#'
branch_joint_probs.default <- function(model,
                                       nodes, ...){
  message("No method for this type.")
}

