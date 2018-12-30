
library(readr)
library(dplyr)
library(tibble)
library(reshape2)
library(treeSimR)


#########
# probs #
#########

probs <- read_csv("data-raw/TB_decision-tree-probs.csv")

probs_long <-
  probs %>%
  mutate('from' = rownames(.)) %>%
  reshape2::melt(id.vars = "from",
       variable.name = 'to',
       value.name = 'prob') %>%
  na.omit()


# node numbers to probs
probs_names <-
  merge(probs_long, probs_from_to_lookup,
        by = c("from", "to"), all.x = TRUE) %>%
  dplyr::select(-prob)

branch_probs_long <-
  as_tibble(branch_probs) %>%
  melt(value.name = "prob",
       variable.name = "name")

probs_names <-
  merge(probs_names, branch_probs_long,
        by = "name", all.x = TRUE) %>%
  mutate(from = as.numeric(as.character(from)),
         to = as.numeric(as.character(to)))

probs_names <-
  probs_names %>%
  group_by(from) %>%
  mutate(prob = ifelse(is.na(prob),
                       1 - sum(prob, na.rm = TRUE),
                       prob)) %>%
  ungroup()

# fill in transition prob matrix

for (r in seq_len(nrow(probs_names))) {

  i <- probs_names$from[r]
  j <- probs_names$to[r]

    probs[i, j] <-
      probs_names %>%
      filter(from == i,
             to == j) %>%
      select(prob)
}


########
# cost #
########

branch_cost_long <-
  as_tibble(branch_costs) %>%
  melt(value.name = "cost",
       variable.name = "name")

costs_names <-
  merge(cost_from_to_lookup, branch_cost_long,
        by = "name", all.x = TRUE) %>%
  mutate(from = as.numeric(as.character(from)),
         to = as.numeric(as.character(to)))

costs <- as.tibble(matrix(NA_real_,
                          nrow = nrow(probs), ncol = ncol(probs)))

for (r in seq_len(nrow(costs_names))) {

  i <- costs_names$from[r]
  j <- costs_names$to[r]

  costs[i, j] <-
    costs_names %>%
    filter(from == i,
           to == j) %>%
    select(cost)
}

dectree_expected_values(vals = costs,
                        p = probs)


# list of deterministic scenarios

# wrapper for sampling in SA



