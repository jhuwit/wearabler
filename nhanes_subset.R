library(tidyverse)
library(hms)

# data from https://physionet.org/content/minute-level-step-count-nhanes/1.0.1/csv/#files-panel
n_keep = 100
df = read_csv(here::here("data/nhanes_1440_AC.csv.xz"), n_max = 1000)
ids = unique(df$SEQN)[1:n_keep]
df = df |>
  filter(SEQN %in% ids)
df = df |>
  mutate(across(starts_with("min_"), round))
readr::write_rds(df, here::here("data/ac_subset_wide.rds"))
df = df |>
  pivot_longer(starts_with("min_"), names_prefix = "min_", names_to = "minute")
df = df |>
  group_by(SEQN, minute) |>
  summarise(value = mean(value, na.rm = TRUE)) |>
  ungroup() |>
  mutate(minute = as.numeric(minute) - 1,
         minute = hms::hms(minutes = minute),
         time = ymd_hms(paste0("2000-01-01", " ", as.character(minute)),
                        tz = "UTC"))

df = df |>
  select(SEQN, minute, time, value)
df = df |>
  arrange(SEQN, time)
readr::write_rds(df, here::here("data/ac_subset.rds"))

