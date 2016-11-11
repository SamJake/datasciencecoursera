library("dplyr")
cran %>% group_by(package) %>%
  summarize(count = n(),
                   unique = n_distinct(ip_id),
                   country = n_distinct(country),
                   avg_size = mean(size)
                   ) %>% 
  filter(country > 60) %>% 
  arrange(desc(country),desc(avg_size)) %>% 
  View()