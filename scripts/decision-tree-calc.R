#
# decision-tree-calc.R
# N Green


rm(list = ls())

library(readr)
library(dplyr)
library(reshape2)
library(tidyr)

# setwd("C:/Users/ngreen1/Google Drive/R code/CEdecisiontree")
# probs <- read_csv("data/decision-tree-probs.csv", col_names = TRUE, col_types = cols('1' = 'd'))
# cost  <- read_csv("data/decision-tree-costs.csv", col_names = TRUE, col_types = cols('1' = 'd'))
# save(probs, file = "data/probs.RData")
# save(cost, file = "data/cost.RData")

data("cost")
data("probs")

probs_long <-
  probs %>%
  mutate('from' = rownames(.)) %>%
  melt(id.vars = "from",
       variable.name = 'to',
       value.name = 'prob') %>%
  na.omit()

cost_long <-
  cost %>%
  mutate('from' = rownames(.)) %>%
  melt(id.vars = "from",
       variable.name = 'to',
       value.name = 'cost') %>%
  na.omit()

dtr_data <- merge(probs_long,
                  cost_long)


#########
# model #
#########

# cost[1, 2] <- runif(1, 10, 100)
dectree_expected_values(vals = cost,
                        p = probs)


Cdectree_expected_values(vals = as.matrix(cost),
                         p = as.matrix(probs))



# branch probs ------------------------------------------------------------

# contributing cost as weighted by chance
# trade-off between original size and branch position
wcost <- branch_joint_probs(probs) * cost
wcost

sum(wcost, na.rm = TRUE)

# terminal state total probs
terminal_states <- (nrow(probs) + 1):ncol(probs)

p_terminal_state <-
  branch_joint_probs(probs)[ ,terminal_states] %>%
  colSums(na.rm = TRUE)

sum(p_terminal_state)


# prevalence <- 0.4
# sens <- 0.9
# spec <- 0.9
# data.frame('1' = c(NA, NA, NA),
#            '2' = c(prevalence, NA, NA),
#            '3' = c(1 - prevalence, NA, NA),
#            '4' = c(NA, sens, NA),
#            '5' = c(NA, 1 - sens, NA),
#            '6' = c(NA, NA, 1 - spec),
#            '7' = c(NA, NA, spec))







