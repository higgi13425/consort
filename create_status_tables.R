# build study status tables

# need 2 arm study


# need 3 arm study

# need 4 arm study


# now 5-arm Upa UC
# published in Gastroenterology, 2020
# https://www.gastrojournal.org/article/S0016-5085(20)30241-9/fulltext
#
# build status5 table for 5-arm Upa UC
status5 <- tibble(randomized = c(rep("Yes", 250),
                                rep("No", 196)),
                 excluded_reason = c(rep("None", 250),
                                     rep("Did not meet inclusion criteria", 172),
                                     rep("Withdrew consent", 17),
                                     rep("Lost to follow up", 2),
                                     rep("Other reasons", 5)),
                 arm = c(rep("Placebo", 46),
                         rep("Upa 7.5 mg QD", 47),
                         rep("Upa 15 mg QD", 49),
                         rep("Upa 30 mg QD", 52),
                         rep("Upa 45 mg QD", 56),
                         rep("None", 196)),
                 completed = c(rep("Adverse Event", 3),
                               rep("Loss of Effect", 2),
                               rep("Completed", 41),
                               rep("Adverse Event", 1),
                               rep("Loss of Effect", 1),
                               rep("Completed", 45),
                               rep("Adverse Event", 2),
                               rep("Loss of Effect", 1),
                               rep("Other", 1),
                               rep("Completed", 45),
                               rep("Adverse Event", 4),
                               rep("Loss of Effect", 1),
                               rep("Other", 1),
                               rep("Completed", 46),
                               rep("Adverse Event", 4),
                               rep("Loss of Effect", 2),
                               rep("Completed", 50),
                               rep("None", 196)))
# now shuffle rows
set.seed(42)
rows <- sample(nrow(status5))
status5 <- status5[rows, ]
# now add study_id, formatted as "000X"
study_id <- str_pad(1L:446L, width = 4,
                    side = "left", pad = "0")
status5 <- cbind(study_id, status5)
status5

# Now an 8-arm RCT to enhance influenze vaccination uptake
# published in Social Science & Medicine 2017
# https://www.sciencedirect.com/science/article/pii/S0277953617301922
#
# build status8 table for 8-arm influenze uptke
status8 <- tibble(randomized = rep("Yes", 13806),
                  excluded_reason = rep("None", 13806),
          arm = c(rep("Control Group 1\n(no contact)", 1727),
            rep("Control Group 2\n(demographics)", 1699),
            rep("Intention,\nAttitude", 1790),
            rep("Intention,\nAttitude +\nSticky Note", 1655),
            rep("Anticipated\nRegret,\nIntention,\nAttitude", 1763),
  rep("Anticipated\nRegret,\nIntention,\nAttitude +\nSticky Note", 1751),
  rep("Benificence,\nIntention,\nAttitude", 1743),
  rep("Benificence,\nIntention,\nAttitude +\nSticky Note", 1678)),
        completed = c(rep("Did Not Complete", 1727),
                                rep("Did Not Complete", 999),
                                rep("Completed", 699),
                      "Missing",
                                rep("Did Not Complete", 1079),
                                rep("Completed", 711),
                                rep("Did Not Complete", 904),
                                rep("Completed", 751),
                                rep("Did Not Complete", 1014),
                                rep("Completed", 748),
                      "Missing",
                                rep("Did Not Complete", 990),
                                rep("Completed", 761),
                                rep("Did Not Complete", 1054),
                                rep("Completed", 688),
                      "Missing",
                                rep("Did Not Complete", 941),
                                rep("Completed", 737)))

# now shuffle rows
set.seed(42)
rows <- sample(nrow(status8))
status8 <- status8[rows, ]
# now add study_id, formatted as "000X"
study_id <- str_pad(1L:13806L, width = 8,
                    side = "left", pad = "0")
status8 <- cbind(study_id, status8)
status8
