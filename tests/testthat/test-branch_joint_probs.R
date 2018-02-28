context("branch_joint_probs")

test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})


# this works because we place a combined cost at each terminal node
# rather than individual costs at each branch

bcg_joint_probs <-
  bcg_probs %>%
  branch_joint_probs() %>%
  select(terminal_states) %>%
  colSums(na.rm = TRUE)

bcg_joint_probs %*% dtr_data$cost[terminal_states - 1]
#38.525

bcg_joint_probs %*% dtr_data$utility[terminal_states - 1]
#1.055

dectree_expected_values(vals = bcg_cost,
                        p = bcg_probs)[[1]]

dectree_expected_values(vals = bcg_utility,
                        p = bcg_probs)[[1]]
