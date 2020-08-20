context("test-define_model")

test_that("dat_long", {

  define_model(dat_long = data.frame(from = c(NA, 1, 1),
                                     to = 1:3,
                                     prob = c(NA, 0.5, 0.5),
                                     vals = c(0, 1, 2)))

  define_model(dat_long = data.frame(from = c(NA, 1, 1),
                                     to = 1:3,
                                     prob = c(NA, 0.5, 0.5),
                                     vals = c(0, 1, 2)), fill_prob = TRUE)

  define_model(dat_long = data.frame(from = c(NA, 1, 1),
                                     to = 1:3,
                                     prob = c(NA, 0.5, 0.5),
                                     vals = c(0, 1, 2)), fill_prob = TRUE, fill_edges = FALSE)

  define_model(dat_long = data.frame(from = c(NA, 1, 1),
                                     to = 1:3,
                                     prob = c(NA, NA, 0.5),
                                     vals = c(0, 1, 2)), fill_prob = TRUE, fill_edges = FALSE)

  define_model(dat_long = data.frame(from = c(NA, 1, 1),
                                     to = 1:3,
                                     prob = c(NA, NA, 0.5),
                                     vals = c(0, 1, 2)), fill_prob = TRUE, fill_edges = TRUE)
})
