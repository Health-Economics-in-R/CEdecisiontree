#
# bcg-calc.R
# N Green


rm(list = ls())

library(readr)
library(dplyr)
library(reshape2)
library(tidyr)

# bcg_probs <- read_csv("data-raw/bcg-probs.csv", col_names = TRUE, col_types = cols('1' = 'd'))
# bcg_cost  <- read_csv("data-raw/bcg-costs.csv", col_names = TRUE, col_types = cols('1' = 'd'))
# bcg_utility  <- read_csv("data-raw/bcg-utility.csv", col_names = TRUE, col_types = cols('1' = 'd'))
# save(bcg_probs, file = "data/bcg_probs.RData")
# save(bcg_cost, file = "data/bcg_cost.RData")
# save(bcg_utility, file = "data/bcg_utility.RData")

data("bcg_cost")
data("bcg_probs")
data("bcg_utility")

probs_long <-
  bcg_probs %>%
  mutate('from' = rownames(.)) %>%
  melt(variable.name = 'to',
       value.name = 'prob',
       id.vars = 'from') %>%
  na.omit()

cost_long <-
  bcg_cost %>%
  mutate('from' = rownames(.)) %>%
  melt(variable.name = 'to',
       value.name = 'cost',
       id.vars = 'from') %>%
  na.omit()

utility_long <-
  bcg_utility %>%
  mutate('from' = rownames(.)) %>%
  melt(variable.name = 'to',
       value.name = 'utility',
       id.vars = 'from') %>%
  na.omit()

dtr_data <-
  merge(probs_long,
        cost_long) %>%
  merge(utility_long)


#########
# model #
#########

dectree_expected_values(vals = bcg_cost,
                        p = bcg_probs)

dectree_expected_values(vals = bcg_utility,
                        p = bcg_probs)



# terminal state total probs
terminal_states <- seq(from = nrow(bcg_probs) + 1,
                       to = ncol(bcg_probs))

bcg_probs %>%
  branch_joint_probs() %>%
  select(terminal_states) %>%
  colSums(na.rm = TRUE)



# # contributing cost as weighted by likelihood
# # trade-off between original size and branch position
# branch_joint_probs(probs) * cost
