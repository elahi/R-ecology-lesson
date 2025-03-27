## ----setup, include=FALSE-----------------------------
knitr::opts_chunk$set(dpi = 200, out.height = 600, out.width = 600, R.options = list(max.print = 100))


## ----load-tidyverse-package, message=FALSE------------
library(tidyverse)


## ----read-csv-----------------------------------------
surveys <- read_csv("data/cleaned/surveys_complete_77_89.csv")


## ----class-tibble-------------------------------------
class(surveys)


## ----select-------------------------------------------
select(surveys, plot_id, species_id, hindfoot_length)


## ----select-minus-------------------------------------
select(surveys, -record_id, -year)


## ----select-vector------------------------------------
select(surveys, c(3:5, 10))


## ----select-where-------------------------------------
select(surveys, where(is.numeric))


## ----select-anyNA-------------------------------------
select(surveys, where(anyNA))


## ----filter-------------------------------------------
filter(surveys, year == 1985)


## ----filter-in----------------------------------------
filter(surveys, species_id %in% c("RM", "DO"))


## ----filter-multiple----------------------------------
filter(surveys, year <= 1988 & !is.na(hindfoot_length))


## ----filter-challenge-answer--------------------------
surveys_filtered <- filter(surveys, year >= 1980 & year <= 1985)


## ----selectfilter-challenge-answer--------------------
surveys_selected <- select(surveys, year, month, species_id, plot_id)


## ----filter-select-nested-----------------------------
filter(select(surveys, -day), month >= 7)


## ----filter-select-intermediate-----------------------
surveys_noday <- select(surveys, -day)
filter(surveys_noday, month >= 7)


## ----filter-select-pipe-------------------------------
surveys %>% 
  select(-day) %>% 
  filter(month >= 7)


## ----pipeline-assignment------------------------------
surveys_sub <- surveys %>% 
  select(-day) %>% 
  filter(month >= 7)


## ----filter-select-challenge-answer-------------------
surveys_1988 <- surveys %>%
  filter(year == 1988) %>%
  select(record_id, month, species_id)


## ----mutate-------------------------------------------
surveys %>% 
  mutate(weight_kg = weight / 1000)


## ----mutate-multiple----------------------------------
surveys %>% 
  mutate(weight_kg = weight / 1000,
         weight_lbs = weight_kg * 2.2)


## ----paste-date---------------------------------------
surveys %>% 
  mutate(date = paste(year, month, day, sep = "-"))


## ----relocate-----------------------------------------
surveys %>% 
  mutate(date = paste(year, month, day, sep = "-")) %>% 
  relocate(date, .after = year)


## ----lubridate----------------------------------------
library(lubridate)

surveys %>% 
  mutate(date = paste(year, month, day, sep = "-"),
         date = ymd(date)) %>% 
  relocate(date, .after = year)

surveys %>% 
  mutate(date = paste(year, month, day, sep = "-"),
         date = as.Date(date)) %>% 
  relocate(date, .after = year)


## ----making-date--------------------------------------
# using nested functions
surveys %>% 
  mutate(date = ymd(paste(year, month, day, sep = "-"))) %>% 
  relocate(date, .after = year)

# using a pipe *inside* mutate()
surveys %>% 
  mutate(date = paste(year, month, day, 
                      sep = "-") %>% ymd()) %>% 
  relocate(date, .after = year)


## ----date-plot-challenge-answer-----------------------
surveys %>% 
  mutate(date = ymd(paste(year, month, day, sep = "-"))) %>% 
  ggplot(aes(x = date, y = weight)) +
  geom_jitter(alpha = 0.1)


## ----group-by-summarize-------------------------------
surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T))


## ----summarize-multiple-------------------------------
surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T),
            n = n())


## ----group-by-multiple--------------------------------
surveys %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T),
            n = n())


## ----filter-group-by----------------------------------
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight),
            n = n())


## ----arrange------------------------------------------
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight),
            n = n()) %>% 
  arrange(mean_weight)


## ----arrange-desc-------------------------------------
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight),
            n = n()) %>% 
  arrange(desc(mean_weight))


## ----group-by-alone-----------------------------------
surveys %>% 
  group_by(species_id, sex)


## ----ungroup------------------------------------------
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight),
            n = n()) %>% 
  arrange(desc(mean_weight)) %>% 
  ungroup()


## ----group-by-mutate----------------------------------
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(mean_weight = mean(weight),
            weight_diff = weight - mean_weight)


## ----select-contains----------------------------------
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(mean_weight = mean(weight),
            weight_diff = weight - mean_weight) %>% 
  select(species_id, sex, contains("weight"))


## ----sex-counts-challenge-answer----------------------

surveys_daily_counts <- surveys %>% 
  mutate(date = ymd(paste(year, month, day, sep = "-"))) %>% 
  group_by(date, sex) %>% 
  summarize(n = n())

# shorter approach using count()
surveys_daily_counts <- surveys %>% 
  mutate(date = ymd(paste(year, month, day, sep = "-"))) %>% 
  count(date, sex)


## ----time-series-challenge-answer---------------------
surveys_daily_counts %>% 
  ggplot(aes(x = date, y = n, color = sex)) +
  geom_line()


## ----mean-weight-by-plot------------------------------
sp_by_plot <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, plot_id) %>% 
  summarise(mean_weight = mean(weight)) %>% 
  arrange(species_id, plot_id)

sp_by_plot


## ----pivot-wider--------------------------------------
sp_by_plot_wide <- sp_by_plot %>% 
  pivot_wider(names_from = plot_id, 
              values_from = mean_weight)

sp_by_plot_wide


## ----pivot-wider-check--------------------------------
sp_by_plot %>% 
  filter(species_id == "BA" & plot_id == 1)


## ----pivot-longer-------------------------------------
sp_by_plot_wide %>% 
  pivot_longer(cols = -species_id, names_to = "PLOT", values_to = "MEAN_WT")


## ----pivot-longer-filter------------------------------
sp_by_plot_wide %>% 
  pivot_longer(cols = -species_id, names_to = "PLOT", values_to = "MEAN_WT") %>% 
  filter(!is.na(MEAN_WT))


## ----pivot-wider-prefix-------------------------------
sp_by_plot %>% 
  pivot_wider(names_from = plot_id, values_from = mean_weight,
              names_prefix = "plot_")


## ----assign-pivot-wider-------------------------------
surveys_sp <- sp_by_plot %>% 
  pivot_wider(names_from = plot_id, values_from = mean_weight,
              names_prefix = "plot_")

surveys_sp


## ----write-csv----------------------------------------
write_csv(surveys_sp, "data/cleaned/surveys_meanweight_species_plot.csv")

