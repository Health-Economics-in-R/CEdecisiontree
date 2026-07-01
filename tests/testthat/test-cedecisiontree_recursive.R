context("test-dectree_expectedrecursive")

test_that("dectree_expected_values.tree_dat returns expected values for all nodes", {
  tree <-
    list("1" = c(2,3),
         "2" =  c(4,5),
         "3" =  c(6,7),
         "4" =  c(),
         "5" =  c(),
         "6" =  c(),
         "7" =  c())
  dat <-
    data.frame(node = 1:7,
               prob = c(NA, rep(0.5, 6)),
               vals = c(10,2,3,16,5,6,7))

  model_tree <- define_model(tree_dat = list(child = tree, dat = dat))
  res <- dectree_expected_values(model_tree)

  expect_type(res, "double")
  expect_length(res, 7)
  expect_named(res, as.character(1:7))

  # Verify values match expectations by hand
  expect_equivalent(res["1"], 21)
  expect_equivalent(res["2"], 12.5)
  expect_equivalent(res["3"], 9.5)
  expect_equivalent(res["4"], 16)
  expect_equivalent(res["5"], 5)
  expect_equivalent(res["6"], 6)
  expect_equivalent(res["7"], 7)
})

test_that("dectree_expected_psa works with new output format", {
  tree <-
    list("1" = c(2,3),
         "2" =  c(4,5),
         "3" =  c(6,7),
         "4" =  c(),
         "5" =  c(),
         "6" =  c(),
         "7" =  c())
  dat <-
    data.frame(node = 1:7,
               prob = c(NA, rep(0.5, 6)),
               vals = c(10,2,3,16,5,6,7))

  model_tree <- define_model(tree_dat = list(child = tree, dat = dat))
  psa_res <- dectree_expected_psa(model_tree, n = 5)

  expect_type(psa_res, "double")
  expect_length(psa_res, 5)
  # Since probs/vals are not distributions, all PSA runs should return 21
  expect_equivalent(psa_res, rep(21, 5))
})
