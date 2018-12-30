
branch_costs <-
  list(
    "Contact tracing per contact" = 368.9,
    "Mean number of contacts examined per primary case"	= 6.5,
    "Total Contact tracing" = 2397.85,

    "Cost of inpatient episode for acute TB" = 3325.15,
    "Proportion of patients with acute TB who are admitted"	= 0.53,
    "Total Inpatient care" = 1762.3295,

    "Cost of culture test" = 8.06,
    "Culture tests per case" = 4,
    "CXR per case" = 2,
    "LFT per case" = 4,
    "Total Cost of tests" = 104.74,

    "HRZE tablet (60)" = 39.5,
    "_tablets per month"	= 150,
    "HRZE per month" = 98.75,
    "HR tablet 300/150 (56)" = 25.22,
    "tablets per month" = 60,
    "HR per month" = 27.02142857,
    "Duration of initial therapy" = 2,
    "Duration of continious therapy" = 4,
    "Total Cost of chemotherapy" = 305.5857143,

    "Cost of outpatient consultation (first visit)" = 208,
    "Cost of outpatient consultation (follow-up visit)" = 94,
    "Number of outpatient clinical visits per case" = 4,
    "Visits from TB nurse per case" = 6,
    "Total Out patient care" = 755.86,

    "TST" = 18.62,
    "QFT" = 23.65,
    "TB special nurse visit" = 44.31,
    "T-SPOT" = 35.12,

    "Out patient consultation (first visit)" = 208,
    "CXR" = 30.21,
    "LFT" = 3.02,
    "Number of outpatient consultation" = 1,
    "Number of CXR" = 1,
    "Number of LFT" = 1,
    "Total Cost of positive screening" = 241.23,

    "Follow-up via nurses" = 44.31, #22.15, 66.46,
    "HR tablet (300/150) (56)" = 25.22,
    "drug cost per month" = 27.02,
    "Number of TB nurse appointments"	= 2,
    "Duration of HR" = 3,

    "Total (complete)" = 169.68	,
    "Total (incomplete)" = 84.84,

    "Hep_cost" = 732.13
  )


SA_params <-
  list(
    TST_sens = list(
      distn = "pert",
      params = c(min = 0.69, mode = 0.79, max = 0.89)
    ),
    TST_spec = list(
      distn = "pert",
      params = c(min = 0.46, mode = 0.59, max = 0.73)
    ),
    QFT_sens = list(
      distn = "pert",
      params = c(min = 0.8, mode = 0.77, max = 0.84)
    ),
    QFT_spec = list(
      distn = "pert",
      params = c(mode = 0.97, min = 0.94, max = 0.99)
    ),
    TSPOT_sens = list(
      distn = "pert",
      params = c(mode = 0.9, min = 0.87, max = 0.93)
    ),
    TSPOT_spec = list(
      distn = "pert",
      params = c(mode = 0.95, min = 0.92, max = 0.98)
    ),
    pAccept_chemo = list(
      distn = "pert",
      params = c(mode = 0.95, min = 0.5, max = 1)
    ),
    pComp_chemo = list(
      distn = "pert",
      params = c(mode = 0.8, min = 0.5, max =  0.9)
    ),
    pHep = list(
      distn = "pert",
      params = c(mode = 0.002, min = 0.001, max = 0.003)
    ),
    Eff_comp = list(
      distn = "pert",
      params = c(mode = 0.65, min = 0.5, max = 0.8)
    ),
    Eff_incomp = list(
      distn = "pert",
      params = c(mode = 0.21, min = 0.1, max = 0.3)
    ),
    pTB = list(
      distn = "pert",
      params = c(mode = 0.12, min = 0.08,	max = 0.19)
    ),
    TST_cost = list(
      distn = "pert",
      params = c(mode = 18.62, min = 9.31, max = 37.24)
    ),
    QFT_cost = list(
      distn = "pert",
      params = c(mode = 23.65, min = 12.33, max = 45.29)
    ),
    TSPOT_cost = list(
      distn = "pert",
      params = c(mode = 35.12, min = 18.06, max = 68.23)
    ),
    CXR_cost = list(
      distn = "pert",
      params = c(mode = 30.21, min = 23.16, max = 35.25)
    ),
    LFT_cost = list(
      distn = "pert",
      params = c(mode = 3.02, min = 2.01, max = 4.03)
    ),
    Ns_cost	= list(
      distn = "pert",
      params = c(mode = 44.31, min = 22.15, max = 66.46)
    ),
    Hep_cost = list(
      distn = "pert",
      params = c(mode = 732.13, min = 366.06, max = 1464.25)
    ),
    TB_cost	= list(
      distn = "pert",
      params = c(mode = 4925.76, min = 2462.88, max = 9851.52)
    )
  )

branch_probs <-
  list(
    "pAccept_TST" = 0.982,
    "pTSTread" = 0.979,
    "pAccept_IGRA" = 0.992,
    "pAccept_IGRA_TST+" = 0.995,
    "TSTIGRA_pos" = 0.214,
    "Dual_sens" = 0.632,
    "Dual_spec" = 0.988,
    "pLTBI"	= 0.326,
    "TST_pos"	= 0.534,
    "PPV_TST"	= 0.482,
    "NPV_TST"	= 0.853,
    "QFT_pos"	= 0.281,
    "PPV_QFT"	= 0.928,
    "NPV_QFT"	= 0.909,
    "TSPOT_pos" = 0.327,
    "PPV_TSPOT" = 0.897,
    "NPV_TSPOT" = 0.952,
    "QFT_pos_TST+" = 0.401,
    "PPV_QFT_TST+" = 0.961,
    "NPV_QFT_TST+" = 0.839,
    "TSPOT_pos_TST+" = 0.460,
    "PPV_TSPOT_TST+" = 0.944,
    "NPV_TSPOT_TST+" = 0.911,
    "pAccept_chemo" = 0.95,
    "pComp_chemo" = 0.8,
    "pHep" = 0.002,
    "pReact" = 0.001936869,
    "pReact_comp" = 0.000677904,
    "pReact_incomp" = 0.001530127
  )

hsuv <-
  list(
    "loss_chemo" = 0.01,
    "loss_hep" = 0.22,
    "loss_tb" = 0.15
  )


probs_from_to_lookup <-
  rbind.data.frame(
    c("pAccept_TST", 1, 2),
    c("pTSTread", 2, 3),
    c("TST_pos", 3, 4),
    c("PPV_TST", 4, 5),
    c("pAccept_chemo", 5, 6),
    c("pHep", 6, 7),
    c("pComp_chemo", 9, 10),
    c("pAccept_chemo", 14, 15),
    c("pHep", 15, 16),
    c("pComp_chemo", 18, 19),
    c("NPV_TST", 23, 26),
    c("pLTBI", 28, 29),
    c("pLTBI", 31, 32)
  ) %>%
  setNames(c("name", "from", "to"))

cost_from_to_lookup <-
  rbind.data.frame(
    c("TST", 1, 2),
    c("TB special nurse visit", 2, 3),
    c("Total Cost of positive screening", 3, 4),
    c("Hep_cost", 6, 7),
    c("Total (incomplete)", 7, 8),
    c("Total (complete)", 9, 10),
    c("Total (incomplete)", 9, 11),
    c("Hep_cost", 15, 16),
    c("Total (incomplete)", 16, 17),
    c("Total (complete)", 18, 19),
    c("Total (incomplete)", 18, 20)
  ) %>%
  setNames(c("name", "from", "to"))




