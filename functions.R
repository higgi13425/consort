library(tidyverse)
library(glue)

max_char_width <- function(string) { # depends on tidyverse
  str_split(string, "\n") %>%
    unlist() %>%
    str_length() %>%
    max()
}
# possible unit tests
# input string with multiple lines
# input string with single line
# non-existent input string (useful error message)


collapse_to_string <- function(column) { # depends on glue
  glue_collapse(column) %>% #collapses to single string
    str_trim() #trims off final newline
}
# note might be easier as paste() with option collapse = "\n"
# possible unit tests
# input column with multiple lines
# input column with single line
# non-existent input column (useful error message)


count_lines <- function(string) {
  str_count(string, "\n") + 1
}
# possible unit tests
# input string with multiple newlines
# input string with single line
# non-existent input string (useful error message)


make_nbox_tibble <- function(n_arms) {
  # detect <1
  n_arms <- as.integer(n_arms)
  if (n_arms<1) {
    print("the number of arms must be an integer greater than zero")
  } else if((n_arms %% 2) == 0){
    # even case
    box_num <- -(n_arms/2):(n_arms/2)
    box_num <- box_num[box_num != 0]
    box_num
  } else{
    # odd case
    box_num <- -(trunc(n_arms/2)):(trunc(n_arms/2))
    box_num
  }
  box_list <- tibble(box_num)
  return(box_list)
}

list_arms <- function(status_table) {
  status_table %>%
    filter(!is.na(arm)) %>%
    distinct(arm) %>%
    pull()
}

build_discont_text <- function(discontinued_table, selected_arm) {
  discontinued_table %>%
    filter(arm == !!!enquos(selected_arm)) %>%
    tabyl(discont_reason) %>%
    adorn_totals("row") %>%
    arrange(desc(n)) ->
    discontinued_group
  discontinued_group[1,1] <- "Discontinued"

  mutate(discontinued_group,
         discont_label = paste(n, discont_reason))%>%
    select(discont_label) %>%
    glue_data("{discont_label}") -> output
  return(output)
}
