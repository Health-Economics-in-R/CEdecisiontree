
context("basic")

library(readr)
library(dplyr)
library(reshape2)
library(tidyr)
library(assertthat)


data(cost, package = 'CEdecisiontree')
data(probs, package = 'CEdecisiontree')

res <- dectree_expected_values(vals = cost,
                               p = probs)

test_that("dectree_expected_values structure", {


  expect_type(res, 'list')
  expect_type(res[[1]], 'double')
  expect_length(res, 7)
  expect_equivalent(res[[1]], 5.6)
})

test_that("solutions by hand", {

  expect_equivalent(res[[1]],
                    0.8*((0.2*10 + 0.8*1) + 1) + 0.2*((0.2*10 + 0.8*1) + 10))

})


test_that("probability matrices", {

  dat <- data.frame(from = c(1,1,2,2,3,3),
                    to = c(2,3,4,5,6,7),
                    prob = c(0.5,0.5,0.1,0.9,0.3,0.7))

  expect_true(is_prob_matrix(long_to_transmat(dat)))

  dat$prob[1] <- 1
  expect_error(assert_that(is_prob_matrix(long_to_transmat(dat))),
               "probs is not a probability matrix")

})
