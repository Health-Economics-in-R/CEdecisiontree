
context("basic")

library(readr)
library(dplyr)
library(reshape2)
library(tidyr)

data(cost, package = 'CEdecisiontree')
data(probs, package = 'CEdecisiontree')

test_that("basic", {

  res <- dectree_expected_values(vals = cost,
                                 p = probs)

  expect_type(res, 'list')
  expect_type(res[[1]], 'double')
  expect_length(res, 7)
  expect_equivalent(res[[1]], 5.6)


  expect_equivalent(res[[1]],
                    0.8*((0.2*10 + 0.8*1) + 1) + 0.2*((0.2*10 + 0.8*1) + 10))

})
