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

xx <-
  define_model(dat_long =
                 data.frame(from = c(NA, 1, 1),
                            to = 1:3,
                            prob = c(NA, NA, 0.5),
                            vals = c(0, 1, 2)),
               fill_prob = TRUE,
               fill_edges = TRUE)
# from    to  prob  vals
# * <dbl> <int> <dbl> <dbl>
#   1    NA     1   1       0
# 2     1     2   0.5     1
# 3     1     3   0.5     2
# 4     2     3   1       0
# 5     3     3   1       0

long_to_transmat(xx)
# 1   2   3
# 1 NA 0.5 0.5
# 2 NA  NA 1.0
# 3 NA  NA 1.0

long_to_transmat(xx, val_col = "vals")
# 1  2 3
# 1 NA  1 2
# 2 NA NA 0

xx <-
  define_model(dat_long =
                 data.frame(from = c(NA, 1, 1),
                            to = 1:3,
                            prob = c(NA, NA, 0.5),
                            vals = c(0, 1, 2)),
               fill_prob = TRUE,
               fill_edges = FALSE)

long_to_transmat(xx)
# 1   2   3
# 1 NA 0.5 0.5
