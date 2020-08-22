
library(tidyverse)
library(glue)
library(janitor)
source('functions.R')

# The status table example:

## build status2 ----
status2 <- tibble(randomized = c(rep("Yes", 602),
                                 rep(NA, 197)),
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
# now add study_id, formatted as "00X"
status2$study_id <- str_pad(1L:799L, width = 5,
                            side = "left", pad = "0")
status2 <- status2 %>% relocate(study_id)
status2

# set plotting constants -----
v_space_const = 8 # set adjustment between vertical boxes
h_const = 6 # set adjustment for box height by # of lines
w_const = 1.2 # set adjustment for box width by # of characters

# detect number of arms
n_arms <- status2 %>%
          filter(!is.na(arm)) %>%
          distinct(arm) %>%
          nrow()

# set up top_table ----
box <- c("assessment_box", "exclusion_box", "randomization_box")
box_num <- c(10,20,30)
label <- rep("",3)
lines <- rep(0,3)
char_wide <- rep(0,3)
top_tbl <- tibble(box, box_num, label, lines, char_wide)


# set up for exclusion box row ----
# build text for exclusion box label
status2 %>%
  filter(is.na(randomized)) %>%
  tabyl(excluded_reason) %>%
  adorn_totals("row") %>%
  select(n, excluded_reason) %>%
  arrange(desc(n)) ->
  exclusion_table

exclusion_table[1,2] <- "Patients excluded"

exclusion_table2 <- mutate(exclusion_table,
                           col_new = paste0(n, " ",excluded_reason, "\n")) %>%
  select(col_new)

# measure max_length of string in col_new
ex_char_wide <- max(nchar(exclusion_table2$col_new)) - 2
# later will put this width into top_boxes_tbl row 2

# glue into single string with line breaks
label_ex <- glue_collapse(exclusion_table2$col_new) %>% #collapses to single string
  str_trim() #removes the last \n
# later will put into top_boxes_tbl$label[2]

# fill in text labels for boxes 10-30 ---
# assessment label
top_tbl$label[1] <- glue(status2 %>% tally() %>% pull(), " Patients Assessed for Eligibility")
# excluded label
top_tbl$label[2] <- label_ex # created above
# randomized label
top_tbl$label[3] <- glue(status2 %>% filter(randomized == "Yes") %>% tally() %>% pull(), " Patients randomly assigned\nand included in the intention-to-treat analysis")

# calculate true # of lines for all 3 ----
top_tbl$lines <- count_lines(top_tbl$label)

# add width in characters to each
top_tbl$char_wide[1] <- str_split(top_tbl$label[1], "\n") %>% unlist() %>% str_length() %>% max()
top_tbl$char_wide[2] <- ex_char_wide
top_tbl$char_wide[3] <- str_split(top_tbl$label[3], "\n") %>% unlist() %>% str_length() %>% max()

# add box x,y (roughly)
top_tbl %>%
  mutate(xmin = -char_wide * w_const,
         xmax = char_wide * w_const,
         ymin = 0,
         ymax = 0) ->
  top_tbl2

# offset exclusion box to the right
# by width of box 2 plus
# half width of box 3 plus 2 v_spaces
r_offset =  top_tbl2$char_wide[2]*w_const +
  top_tbl2$char_wide[3]*w_const/2 +
  v_space_const*2

# right adjust xmin and xmax for exclusion box by offset
top_tbl2$xmin[2] <- top_tbl2$xmin[2]+ r_offset
top_tbl2$xmax[2] <- top_tbl2$xmax[2]+ r_offset

# set ymins for each box
top_tbl2$ymin[1] <- 6*v_space_const +
  top_tbl$lines[3]* h_const +
  top_tbl$lines[2]* h_const

top_tbl2$ymin[2] <- 4*v_space_const +
  top_tbl$lines[3]* h_const

top_tbl2$ymin[3] <- 2*v_space_const

top_tbl2 %>%
  mutate(ymax = ymin + lines*h_const) %>%
  mutate(ycenter = ymin + (ymax-ymin)/2) %>%
  mutate(xcenter = xmin + (xmax-xmin)/2) %>%
  mutate(xstart = xcenter,
         xend = xcenter,
         ystart = ymin,
         yend = 0) ->
  top_tbl3

# line adjustments
top_tbl3$xstart[2] <- top_tbl3$xcenter[1]
top_tbl3$xend[2] <- top_tbl3$xmin[2]
top_tbl3$ystart[2] <- mean(c(top_tbl3$ymin[1],
                             top_tbl3$ymax[3]))
top_tbl3$ystart[3] <- top_tbl3$ymin[3]
top_tbl3$yend[1] <- top_tbl3$ymax[3]
top_tbl3$yend[2] <- mean(c(top_tbl3$ymin[1],
                           top_tbl3$ymax[3]))

# TEST draw top boxes with geom_rect ----

ggplot(top_tbl3) +
  geom_rect(aes(xmin=xmin, xmax = xmax,
                ymin = ymin, ymax = ymax),
            fill = "white", color = "black") +
  geom_text(aes(x=xcenter, y = ycenter, label = label),
            size =3, hjust = "center") +
  geom_segment(aes(x=xstart, y=ystart,
                   xend=xend, yend=yend),
               lineend = "round", linejoin = "round",
               arrow = arrow(length = unit(0.2, "cm"),
                             ends = "last", type = "closed"),
               arrow.fill = "black") +
  geom_segment(aes( x = - n_arms * v_space_const*4,
                    xend = n_arms * v_space_const*4,
                    y = 0, yend = 0)) +
  theme_void()
