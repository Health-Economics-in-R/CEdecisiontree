
context("dectree_expected_values")

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


  expect_type(res, 'double')
  expect_length(res, 7)
  expect_equivalent(res[1], 5.6)
})

test_that("solutions by hand", {

  expect_equivalent(res[1],
                    0.8*((0.2*10 + 0.8*1) + 1) + 0.2*((0.2*10 + 0.8*1) + 10))

})

