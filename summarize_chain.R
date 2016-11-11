library("dplyr")
result <- arrange(
  filter(
    summarize(
      group_by(cran,package),
              count = n(),
              unique = n_distinct(ip_id),
              country = n_distinct(country),
              avg_size = mean(size)
    )
  ,country > 60),
desc(country),desc(avg_size))
View(result)