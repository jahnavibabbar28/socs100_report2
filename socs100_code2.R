# SOCS100 REPORT 2 CODE

# Load Pacman
library(pacman)

# Use pacman to load needed libraries
p_load(
  tidyverse,
  tidycensus, 
  dplyr,
  ggplot2,
  tidyr,
  lubridate, 
  sf, 
  RColorBrewer)

# Set your API key as an environment variable
census_api_key("84f23216a449777b2273e788a681349b41b5371b", install = TRUE)

# 1. Get state-level health insurance data
state_insurance <- get_acs(
  geography = "state",
  variables = c(
    "B27010_001", # Total population
    "B27010_002", # Uninsured population
    "B27010_003", # Privately insured
    "B27010_004"  # Publicly insured
  ),
  year = 2019,
  survey = "acs5",
  output = "wide",
  geometry = TRUE
) %>%
  rename(
    state = NAME,
    total_population = B27010_001E,
    uninsured = B27010_002E,
    privately_insured = B27010_003E,
    publicly_insured = B27010_004E
  ) %>%
  mutate(
    uninsured_rate = uninsured / total_population * 100,
    private_insurance_rate = privately_insured / total_population * 100,
    public_insurance_rate = publicly_insured / total_population * 100
  )

# 2. Get age group data for health insurance coverage
age_insurance <- get_acs(
  geography = "state",
  variables = c(
    "B27010_005", # Privately insured (Under 18)
    "B27010_006", # Privately insured (18-64)
    "B27010_007", # Privately insured (65+)
    "B27010_008", # Publicly insured (Under 18)
    "B27010_009", # Publicly insured (18-64)
    "B27010_010", # Publicly insured (65+)
    "B27010_011", # Uninsured (Under 18)
    "B27010_012", # Uninsured (18-64)
    "B27010_013"  # Uninsured (65+)
  ),
  year = 2019,
  survey = "acs5",
  output = "wide"
) %>%
  rename(
    state = NAME,
    private_under_18 = B27010_005E,
    private_18_64 = B27010_006E,
    private_65_plus = B27010_007E,
    public_under_18 = B27010_008E,
    public_18_64 = B27010_009E,
    public_65_plus = B27010_010E,
    uninsured_under_18 = B27010_011E,
    uninsured_18_64 = B27010_012E,
    uninsured_65_plus = B27010_013E
  ) %>%
  pivot_longer(
    cols = starts_with("private_") | starts_with("public_") | starts_with("uninsured_"),
    names_to = c("insurance_type", "age_group"),
    names_sep = "_",
    values_to = "population"
  )

# 3. Prepare regional insurance data for line chart (aggregated for simplicity)
insurance_data_over_time <- map_dfr(2015:2019, function(year) {
  get_acs(
    geography = "state",
    variables = c(
      "B27010_001", # Total population
      "B27010_002", # Uninsured population
      "B27010_003", # Privately insured
      "B27010_004"  # Publicly insured
    ),
    year = year,
    survey = "acs5",
    output = "wide",
    geometry = FALSE
  ) %>%
    rename(
      state = NAME,
      total_population = B27010_001E,
      uninsured = B27010_002E,
      privately_insured = B27010_003E,
      publicly_insured = B27010_004E
    ) %>%
    mutate(
      year = year, # Add the year column
      uninsured_rate = uninsured / total_population * 100,
      private_insurance_rate = privately_insured / total_population * 100,
      public_insurance_rate = publicly_insured / total_population * 100
    )
})

# Save Data files in Repo
# Save state_insurance dataset as CSV
write.csv(state_insurance, "state_insurance.csv", row.names = FALSE)

# Save age_insurance dataset as CSV
write.csv(age_insurance, "age_insurance.csv", row.names = FALSE)

# Save insurance_data_over_time dataset as CSV
write.csv(insurance_data_over_time, "insurance_data_over_time.csv", row.names = FALSE)

