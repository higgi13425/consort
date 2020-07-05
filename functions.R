
max_char_width <- function(string) { # depends on tidyverse
  str_split(string, "\n") %>%
    unlist() %>%
    str_length() %>%
    max()
}

collapse_to_string <- function(column) { # depends on glue
  glue_collapse(column) %>% #collapses to single string
    str_trim() #trims off final newline
}

count_lines <- function(string) {
  str_count(string, "\n") +1
}

