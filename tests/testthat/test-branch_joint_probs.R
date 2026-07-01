
library(readr)
library(dplyr)
library(reshape2)
library(tidyr)
library(assertthat)

data(bcg_probs, package = 'CEdecisiontree')

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

  # the first element is always 1

  expect_equivalent(
    unlist(branch_joint_probs.dat_long(df, nodes = 4)),
    c(1, 0.9))

  expect_equivalent(
    unlist(branch_joint_probs.dat_long(df, 3)),
    c(1, 0.5, 0.1))

  expect_equivalent(branch_joint_probs.dat_long(df, c(3,4)),
               list(c(1, 0.5, 0.1),
                    c(1, 0.9)))

  df <-
    data.frame(
      from = c(1,2,1,2),
      to = c(2,3,4,5),
      prob = c(0.1,0.5,0.9,NA),
      vals = c(1,2,3,0))

  expect_equivalent(
    unlist(branch_joint_probs.dat_long(df, 5)),
    c(1, NA, 0.1))
})

test_that("custom nodes and terminal_pop don't crash", {
  df <-
    data.frame(
      from = c(1,2,1),
      to = c(2,3,4),
      prob = c(0.1,0.5,0.9),
      vals = c(1,2,3))
  mod <- define_model(dat_long = df)

  # Check custom nodes
  res <- branch_joint_probs(mod, nodes = 4)
  expect_length(res, 1)
  expect_named(res, "4")
  expect_equivalent(res[[1]], c(1, 0.9))

  # Check terminal_pop
  term <- terminal_pop(mod, state_list = c(3, 4))
  expect_length(term, 2)
  expect_equivalent(term[[1]], 0.05)
  expect_equivalent(term[[2]], 0.9)
})

test_that("sample_distributions for beta and gamma works", {
  # Test beta distribution
  res_beta <- sample_distributions(param.distns = list(distn = "beta", params = c(a = 2, b = 5)))
  expect_type(res_beta, "double")
  expect_length(res_beta, 1)
  expect_true(res_beta >= 0 && res_beta <= 1)

  # Test gamma distribution
  res_gamma <- sample_distributions(param.distns = list(distn = "gamma", params = c(shape = 2, scale = 2)))
  expect_type(res_gamma, "double")
  expect_length(res_gamma, 1)
  expect_true(res_gamma >= 0)
})

