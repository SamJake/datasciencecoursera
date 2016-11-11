library("dplyr")
cran <- tbl_df(cran)
pack <- group_by(cran,package) 
pack_sum <- summarize(pack, 
                      count=n(),
                      unique=n_distinct(ip_id),
                      country=n_distinct(country),
                      avg_size = mean(size)
                      )

