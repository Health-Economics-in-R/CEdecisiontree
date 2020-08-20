context("branch_joint_probs")

library(readr)
library(dplyr)
library(reshape2)
library(tidyr)
library(assertthat)

data("bcg_probs", package = 'CEdecisiontree')

test_that("folding back vs terminal probabilities only", {

  # this works because we place a combined cost at each terminal node
  # rather than individual costs at each branch

  # bcg_joint_probs <-
  #   bcg_probs %>%
  #   branch_joint_probs() %>%
  #   select(terminal_states) %>%
  #   colSums(na.rm = TRUE)

  # terminal_states <- (nrow(probs) + 1):ncol(probs)

  # bcg_joint_probs %*% dtr_data$cost[terminal_states - 1]
  # #38.525
  #
  # bcg_joint_probs %*% dtr_data$utility[terminal_states - 1]
  # #1.055
  #
  # dectree_expected_values(vals = bcg_cost,
  #                         p = bcg_probs)[[1]]
  #
  # dectree_expected_values(vals = bcg_utility,
  #                         p = bcg_probs)[[1]]

})

test_that("basic", {

  df <-
    data.frame(
      from = c(1,2,1),
      to = c(2,3,4),
      prob = c(0.1,0.5,0.9),
      vals = c(1,2,3))

  expect_equal(
    unlist(branch_joint_probs.dat_long(df, 4)),
    c(1, 0.9))

  expect_equal(
    unlist(branch_joint_probs.dat_long(df, 3)),
    c(1, 0.5, 0.1))

  expect_equal(branch_joint_probs.dat_long(df, c(3,4)),
               list(c(1, 0.5, 0.1),
                    c(1, 0.9)))

  df <-
    data.frame(
      from = c(1,2,1,2),
      to = c(2,3,4,5),
      prob = c(0.1,0.5,0.9,NA),
      vals = c(1,2,3,0))

  expect_equal(
    unlist(branch_joint_probs.dat_long(df, 5)),
    c(1, NA, 0.1))
})
