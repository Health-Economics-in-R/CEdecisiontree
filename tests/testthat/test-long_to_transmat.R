context("test-long_to_transmat")

library(readr)
library(dplyr)
library(reshape2)
library(tidyr)
library(assertthat)


test_that("probability matrices", {

  dat <- data.frame(from = c(1,1,2,2,3,3),
                    to = c(2,3,4,5,6,7),
                    prob = c(0.5,0.5,0.1,0.9,0.3,0.7))

  expect_type(long_to_transmat(dat), "list")
  expect_is(long_to_transmat(dat), "data.frame")
  expect_true(is_prob_matrix(long_to_transmat(dat)))

  expect_true(all(is.na(diag(as.matrix(long_to_transmat(dat))))), NA)

  dat$prob[1] <- 1
  expect_error(assert_that(is_prob_matrix(long_to_transmat(dat))),
               "probs is not a probability matrix")
})
