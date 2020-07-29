
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
