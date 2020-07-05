
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
# possible unit tests
# input column with multiple lines
# input column with single line
# non-existent input column (useful error message)


count_lines <- function(string) {
  str_count(string, "\n") +1
}
# possible unit tests
# input string with multiple newlines
# input string with single line
# non-existent input string (useful error message)

