# install.packages("tidyverse")  # if needed
library(readr)
library(dplyr)
library(ggplot2)

# 1) Read the CSV you saved from pandas
df <- read_csv("bluesky_keyword_matches_with_week.csv")

# 2) Count posts per week_start (already Sunday-start strings "YYYY-MM-DD")
df_week <- df %>%
  filter(!is.na(week_start)) %>%
  mutate(week_start = as.Date(week_start)) %>%
  count(week_start, name = "n_posts") %>%
  arrange(week_start)

# 3) Plot bars by week (dates on x, counts on y)
ggplot(df_week, aes(x = week_start, y = n_posts)) +
  geom_col() +
  scale_x_date(date_breaks = "1 week", date_labels = "%m/%d") +
  labs(x = "Week starting (Sun)", y = "Number of posts",
       title = "Posts per week") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
