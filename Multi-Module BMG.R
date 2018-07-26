library(readr)
library(tidyverse)
library(readxl)

OEM <- read_excel("OEM.xlsx")

isMultiBMG <- OEM %>% group_by( Company, `Basic Model Group Id`) %>% 
  summarize(hasMulti = n() - (is.na(`Module Model Number 2`) %>% sum())) %>% as.data.frame() # how many exists

OEM <- OEM %>% left_join(isMultiBMG, by = c("Company", "Basic Model Group Id"))

OEM$isMultiBMG <- !is.na(OEM$`Module Model Number 2`)

list_lookup <- setNames(object = isMultiBMG$hasMulti,nm = isMultiBMG$`Basic Model Group Id`) 
OEM$isMultiBMG <- (list_lookup[OEM$`Basic Model Group Id` %>% as.character()] %>% unname() %>% unlist()) > 0

OEM %>% as.data.frame() %>% filter(isMultiBMG == TRUE, Company == "Carrier Corporation") %>% 
  select(Company, `Basic Model Group Id`) %>% 
  arrange(`Basic Model Group Id`) %>% select(`Basic Model Group Id`) %>% unique()

isMultiBMG %>% filter(Company == "Carrier Corporation")

OEM %>% filter(Company == "Carrier Corporation", `Basic Model Group Id` %in% c(1,2,3,4,5,6,7)) %>%
  select(`Basic Model Group Id`, `Module Model Number 2`) %>%  arrange(`Basic Model Group Id`)

