#
# decision-tree-calc.R
# N Green


library(readr)
library(dplyr)
library(reshape2)
library(tidyr)

setwd("C:/Users/ngreen1/Google Drive/R code/CEdecisiontreeR")

probs <- read_csv("data/decision-tree-probs.csv", col_names = TRUE, col_types = cols('1' = 'd'))
cost  <- read_csv("data/decision-tree-costs.csv", col_names = TRUE, col_types = cols('1' = 'd'))

probs_long <-
  probs %>%
  mutate('from' = rownames(.)) %>% 
  melt(variable.name = 'to',
       value.name = 'prob') %>% 
  na.omit()

cost_long <- 
  cost %>%
  mutate('from' = rownames(.)) %>% 
  melt(variable.name = 'to',
       value.name = 'cost') %>% 
  na.omit()

dtr_data <- merge(probs_long, cost_long)


#########
# model #
#########

# cost[1, 2] <- runif(1, 10, 100)
dectree_expected_values(vals = cost,
                        p = probs)

# contributing cost as weighted by likelihood
# trade-off between original size and branch position
branch_joint_probs(probs) * cost

# terminal state total probs
terminal_states <- (nrow(probs) + 1):ncol(probs)

branch_joint_probs(probs)[ ,terminal_states] %>%
  colSums(na.rm = TRUE)




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







