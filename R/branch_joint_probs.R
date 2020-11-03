
#' Branch Joint Probabilities
#'
#' Provides a measure of the chances of following
#' particular paths.
#'
#' These probabilities could be used to weight branch costs
#' or QALYs to indicate the relative contribution to the
#' total expected value.
#'
#' @export
branch_joint_probs <- function(model, ...)
  UseMethod("branch_joint_probs", model)


#' branch_joint_probs.transmat
#'
#' @param model Branch conditional probabilities (matrix)
#' @param nodes Which nodes to return; default to all
#'
#' @return Transition matrix with joint probabilities
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
#' branch_joint_probs(model)*model$vals
#'
branch_joint_probs.transmat <- function(model,
                                        nodes = NA) {

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


#' branch_joint_probs.dat_long
#'
#' @param model Long format decision tree from [define_model()]
#' @param nodes Subset of nodes; vector of integers
#'
#' @return
#' @export
#'
#' @examples
#' df <-
#'   data.frame(
#'     from = c(1,2,1),
#'     to = c(2,3,4),
#'     prob = c(0.1,0.5,0.9),
#'     vals = c(1,2,3))
#'
#' branch_joint_probs.dat_long(df, 4)
#' #0.9
#'
#' branch_joint_probs.dat_long(df, 3)
#' #0.1*0.5
#'
#' mod <- define_model(dat_long = df)
#' branch_joint_probs(mod, 3)
#' branch_joint_probs(mod, 3)[[1]] %>% cumprod()
#'
branch_joint_probs.dat_long <- function(model,
                                        nodes) {

  out <- list()

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

    out[[i]] <- p_total
  }

  return(out)
}

#'
branch_joint_probs.default <- function(model,
                                       nodes){
  message("No method for this type.")
}

