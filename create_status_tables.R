# build study status tables
library(tidyverse)
# need 2 arm study
# build status2 table for 2-arm Indomethacin PEP
# NEJM 2012; 366:1414-1422
# Elmunzer, Higgins, et al.
## build status2 ----
status2 <- tibble(randomized = c(rep("Yes", 602),
                                 rep("No", 197)),
                  excluded_reason = c(rep(NA, 602), #must match randomized = Yes
                                      rep("Did not meet inclusion criteria", 169),
                                      rep("Met Exclusion Criteria", 11),
                                      rep("Did not Undergo ERCP", 17)),
                  arm = c(rep("Placebo", 307),
                          rep("Indomethacin", 295),
                  rep(NA, 197) # must match randomized = No
                          ),
                  recieved_med = c(rep("Yes", 307),
                                   rep("Yes", 295),
                                   rep(NA, 197) ),
                  completed = c(rep("Yes", 307),
                                   rep(NA, 1),
                                   rep("Yes", 294),
                                rep(NA, 197) ),
                  discont_reason = c(rep(NA, 307),
                    rep("Could not hold Suppository", 1),
                                rep(NA, 294),
                                     rep(NA, 197) ),
                  analyzed = c(rep("Yes", 602),
                               rep(NA, 197) ),
                  not_an_reason = rep(NA, 799) )
# now shuffle rows
set.seed(42)
rows <- sample(nrow(status2))
status2 <- status2[rows, ]
# now add study_id, formatted as "000X"
study_id <- str_pad(1L:799L, width = 5,
                    side = "left", pad = "0")
status2 <- cbind(study_id, status5)
status2

## build status3 ----
# need 3 arm study
# build status3 table for 3-arm SONIC trial
# NEJM 2010; 362:1383-1395
status3 <- tibble(randomized = c(rep("Yes", 508),
                                 rep("No", 309)),
 excluded_reason = c(rep(NA, 508), #must match randomized = Yes
         rep("Were not eligible", 266),
         rep("Withdrew consent", 29),
         rep("Lost to follow up", 8),
        rep("Had other reasons", 3),
          rep("Adverse Event", 2),
          rep("Died", 1)),
    arm = c(rep("Azathioprine + Placebo Infusions", 170),
              rep("Infliximab + Placebo Tablets", 169),
              rep("Infliximab + Azathioprine", 169),
              rep(NA, 309) # must match randomized = No
                  ),
    completed = c(rep("Completed", 86),
                 rep("Were not eligible", 3),
                 rep("Withdrew consent", 18),
                rep("Had an adverse event", 38),
                 rep("Were lost to follow up", 5),
                 rep("Had other reasons", 19),
                 rep("Died", 1),
                 rep("Completed", 111),
                  rep("Were not eligible", 8),
                  rep("Withdrew consent", 9),
                  rep("Had an adverse event", 20),
                  rep("Were lost to follow up", 5),
                rep("Had other reasons", 16),
                rep("Completed", 121),
               rep("Were not eligible", 2),
                 rep("Withdrew consent", 7),
                 rep("Had an adverse event", 28),
                 rep("Were lost to follow up", 2),
                rep("Had other reasons", 9),
                rep(NA, 309))) # must match randomized = No
# now shuffle rows
set.seed(42)
rows <- sample(nrow(status3))
status3 <- status3[rows, ]
# now add study_id, formatted as "000X"
study_id <- str_pad(1L:817L, width = 5,
                    side = "left", pad = "0")
status3 <- cbind(study_id, status3)
status3

## build status4 ----
# need 4 arm study
# build status4 table for 4-arm Tofa for UC
# Gut 2017;66:1049–1059.
# Panes, Higgins, et al.
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5532457/pdf/gutjnl-2016-312735.pdf
status4 <- tibble(randomized = c(rep("Yes", 280),
                                 rep("No", 287)),
                  excluded_reason = c(rep(NA, 280),
                                      rep("Did not meet criteria", 287)),
                  arm = c(rep("Placebo", 92),
                          rep("Tofacitinib 5 mg BID", 86),
                          rep("Tofacitinib 10 mg BID", 86),
                          rep("Tofacitinib 15 mg BID", 16),
                          rep(NA, 287)),
                  completed = c(rep("Lost to follow up", 1),
                                rep("Adverse Event", 2),
                                rep("Insufficient Clinical Response", 6),
                                rep("No longer willing to participate", 6),
                                rep("Protocol violation", 1),
                                rep("Did not meet entry criteria", 2),
                                rep("Other reasons", 1),
                                rep("Completed", 73), # Placebo
                                rep("Lost to follow up", 1),
                                rep("Adverse Event", 1),
                                rep("Insufficient Clinical Response", 6),
                                rep("No longer willing to participate", 4),
                                rep("Completed", 74), # 5 bid
                                rep("Lost to follow up", 1),
                                rep("Adverse Event", 5),
                                rep("Insufficient Clinical Response", 4),
                                rep("Protocol Violation", 2),
                                rep("Completed", 74), # 10 bid
                                rep("Insufficient Clinical Response", 1),
                                rep("Completed", 15), #15 bid
                                rep(NA, 287)))
# now shuffle rows
set.seed(42)
rows <- sample(nrow(status4))
status4 <- status4[rows, ]
# now add study_id, formatted as "000X"
study_id <- str_pad(1L:567L, width = 5,
                    side = "left", pad = "0")
status4 <- cbind(study_id, status4)
status4

## build status5 ----
# need 5-arm study
# build status5 table for 5-arm Upa for UC
# Gastroenterology 2020;
# Sandborn, Higgins, et al.
# https://www.gastrojournal.org/article/S0016-5085(20)30241-9/fulltext
#
status5 <- tibble(randomized = c(rep("Yes", 250),
                                rep("No", 196)),
                 excluded_reason = c(rep(NA, 250),
                                     rep("Did not meet inclusion criteria", 172),
                                     rep("Withdrew consent", 17),
                                     rep("Lost to follow up", 2),
                                     rep("Other reasons", 5)),
                 arm = c(rep("Placebo", 46),
                         rep("Upa 7.5 mg QD", 47),
                         rep("Upa 15 mg QD", 49),
                         rep("Upa 30 mg QD", 52),
                         rep("Upa 45 mg QD", 56),
                         rep(NA, 196)),
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
                               rep(NA, 196)))
# now shuffle rows
set.seed(42)
rows <- sample(nrow(status5))
status5 <- status5[rows, ]
# now add study_id, formatted as "000X"
study_id <- str_pad(1L:446L, width = 4,
                    side = "left", pad = "0")
status5 <- cbind(study_id, status5)
status5

## build status8 ----
# Now an 8-arm RCT to enhance influenza vaccination uptake
# published in Social Science & Medicine 2017
# https://www.sciencedirect.com/science/article/pii/S0277953617301922
#
# build status8 table for 8-arm influenze uptke
status8 <- tibble(randomized = rep("Yes", 13806),
                  excluded_reason = rep(NA, 13806),
          arm = c(rep("Control Group 1\n(no contact)", 1727),
            rep("Control Group 2\n(demographics)", 1699),
            rep("Intention,\nAttitude", 1790),
            rep("Intention,\nAttitude +\nSticky Note", 1655),
            rep("Anticipated\nRegret,\nIntention,\nAttitude", 1763),
  rep("Anticipated\nRegret,\nIntention,\nAttitude +\nSticky Note", 1751),
  rep("Benificence,\nIntention,\nAttitude", 1743),
  rep("Benificence,\nIntention,\nAttitude +\nSticky Note", 1678)),
  received_med  = c(rep("Yes", 1727),
                       rep("Yes", 1699),
                       rep("Yes", 1790),
                       rep("Yes",, 1655),
                       rep("Yes", 1763),
                       rep("Yes", 1751),
                       rep("Yes", 1743),
                       rep("Yes", 1678)),
        completed = c(rep(NA, 1727),
                                rep(NA, 999),
                                rep("Yes", 699),
                                rep(NA, 1080),
                                rep("Yes", 711),
                                rep(NA, 904),
                                rep("Yes", 751),
                                rep(NA, 1014),
                                rep("Yes", 748),
                                rep(NA, 991),
                                rep("Yes", 761),
                                rep(NA, 1054),
                                rep("Yes", 688),
                                rep(NA, 942),
                                rep("Yes", 737)),
      discont_reason = c(rep("Lost To Follow Up", 1727),
                         rep("Lost To Follow Up", 999),
                         rep(NA, 699),
                         rep("Lost To Follow Up", 1080),
                         rep(NA, 711),
                         rep("Lost To Follow Up", 904),
                         rep(NA, 751),
                         rep("Lost To Follow Up", 1014),
                         rep(NA, 748),
                         rep("Lost To Follow Up", 991),
                         rep(NA, 761),
                         rep("Lost To Follow Up", 1054),
                         rep(NA, 688),
                         rep("Lost To Follow Up", 942),
                         rep(NA, 737)),
      analyzed = c(rep("Yes", 1727),
                   rep("Yes", 999),
                   rep("Yes", 699),
                   rep("Yes", 1080),
                   rep("Yes", 711),
                   rep("Yes", 904),
                   rep("Yes", 751),
                   rep("Yes", 1014),
                   rep("Yes", 748),
                   rep("Yes", 991),
                   rep("Yes", 761),
                   rep("Yes", 1054),
                   rep("Yes", 688),
                   rep("Yes", 942),
                   rep("Yes", 737)),
    not_an_reason = c(rep(NA, 1727),
                      rep(NA, 999),
                      rep(NA, 699),
                      rep(NA, 1080),
                      rep(NA, 711),
                      rep(NA, 904),
                      rep(NA, 751),
                      rep(NA, 1014),
                      rep(NA, 748),
                      rep(NA, 991),
                      rep(NA, 761),
                      rep(NA, 1054),
                      rep(NA, 688),
                      rep(NA, 942),
                      rep(NA, 737))
  )

# now shuffle rows
set.seed(42)
rows <- sample(nrow(status8))
status8 <- status8[rows, ]
# now add study_id, formatted as "000X"
# range up to full number randomized
# pick a width to offer at least one leading zero
study_id <- str_pad(1L:13806L, width = 8,
                    side = "left", pad = "0")
status8 <- cbind(study_id, status8)
status8
