context("dectree_expected_values")

library(readr)
library(dplyr)
library(reshape2)
library(tidyr)
library(assertthat)

data(cost, package = 'CEdecisiontree')
data(probs, package = 'CEdecisiontree')

mod <- define_model(transmat =
                      list(prob = probs,
                           vals = cost))

res <- dectree_expected_values(mod)

test_that("dectree_expected_values structure", {
  expect_type(res, 'double')
  expect_length(res, 7)
  expect_equivalent(res[1], 5.6)
})

test_that("solutions by hand", {
  expect_equivalent(res[1],
                    0.8*((0.2*10 + 0.8*1) + 1) + 0.2*((0.2*10 + 0.8*1) + 10))
})

test_that("dectree_expected_values.dat_long works", {
  df <-
    data.frame(
      from = c(1, 2, 1, 2, 3, 3),
      to = c(2, 4, 3, 5, 6, 7),
      prob = c(0.2, 0.2, 0.8, 0.8, 0.2, 0.8),
      vals = c(10, 10, 1, 1, 10, 1)
    )

  mod_long <- define_model(dat_long = df)
  ev <- dectree_expected_values(mod_long)

  expect_type(ev, "double")
  expect_length(ev, 8)
  expect_equivalent(ev[1], 5.6)
})

test_that("C and C++ versions give identical results", {
  res_r <- dectree_expected_values(mod)
  res_c <- dectree_expected_values_C(as.matrix(cost), as.matrix(probs))
  res_cpp <- Cdectree_expected_values(as.matrix(cost), as.matrix(probs))

  expect_equal(as.numeric(res_r), as.numeric(res_c))
  expect_equal(as.numeric(res_r), as.numeric(res_cpp))
})

