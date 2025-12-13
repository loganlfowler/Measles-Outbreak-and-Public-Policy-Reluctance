## Overview

This analysis examines how **measles vaccination coverage**, **reported outbreak cases**, and **COVID-19 vaccination patterns** evolved in **Ontario, Canada** from **2013 to 2025**.  
Using public health data from **Public Health Ontario** and the **Government of Canada**, it visualizes the decline in vaccine coverage during the COVID-19 pandemic and its association with subsequent measles resurgence.

---
## Data Sources

All data are **publicly available** and stored in the `/data` directory of this repository.

| Dataset | Source | Description |
|----------|---------|-------------|
| **`Coverage_by_milestone_2013_24.csv`** | [Public Health Ontario: Immunization Coverage Tool](https://www.publichealthontario.ca/en/data-and-analysis/infectious-disease/immunization-tool) | School-level vaccine coverage for multiple antigens (including measles) by age milestone, from 2013–2024. Used to isolate measles vaccination rates by health unit. |
| **`Immunization coverage for selected antigens and age milestones in Ontario, 2013-14 to 2023-24 school year.csv`** | Public Health Ontario | Province-level measles vaccination coverage data, aggregated by school year. Used to compute mean provincial coverage rates. |
| **`ontario_measles_trend_2013_2025.csv`** | [Public Health Ontario: Measles Ontario Epidemiological Summary (2025)](https://www.publichealthontario.ca/-/media/Documents/M/24/measles-ontario-epi-summary.pdf) | Annual confirmed measles case counts in Ontario from 2013 to 2025. |
| **`vaccination-coverage-map.csv`** | [Government of Canada: COVID-19 Vaccination Coverage Portal](https://health-infobase.canada.ca/covid-19/vaccination-coverage/) | Weekly vaccination coverage by province; aggregated here to compute Ontario’s annual mean of fully vaccinated individuals aged 5+. |

---

## Methodology

The R Markdown file (`ontario_analysis.Rmd`) uses **tidyverse**, **ggplot2**, and related packages for data wrangling and visualization.  
The workflow proceeds in two analytical sections:

### 1. Measles Vaccination vs. Outbreak Cases (2013–2025)
- Filters all antigen data to retain only records where `Antigen == "Measles"`.  
- Converts school-year strings (e.g., “2013–14”) into single-year numeric values.  
- Aggregates coverage rates by year to obtain mean provincial vaccination percentages.  
- Merges coverage data with reported case counts from the Public Health Ontario measles summary.  
- Produces a **dual-axis time-series plot** showing:
  - Blue line: mean measles vaccination coverage (%)
  - Red line: total reported measles cases
  - A shaded region marking **2020–2021**, representing pandemic disruption years.

### 2. COVID-19 Vaccination vs. Measles Coverage
- Imports provincial COVID-19 vaccination data from the Health Infobase dataset.  
- Aggregates weekly observations to annual averages (`prop5plus_fully`).  
- Joins with the measles coverage and case dataset (`merged_all`).  
- Creates a **multi-variable comparison plot**:
  - Blue solid line — Measles coverage (%)
  - Green dashed line — COVID-19 full vaccination coverage (%)
  - Red solid line — Measles cases (scaled secondary axis)
- Adds text annotations for coverage percentages and total case counts.

---

## Key Findings

- **Vaccination coverage** in Ontario remained above 90% through most of the 2010s, but **declined during 2020–2021**, coinciding with the COVID-19 pandemic.  
- **Measles cases increased sharply** in 2024–2025 following these declines, suggesting residual immunity gaps and delayed vaccination catch-up.  
- The **COVID-19 vaccination trend** provides a behavioral benchmark for understanding how public trust and access in immunization evolved post-pandemic.  
- The visual contrast between COVID-19 and measles coverage helps identify potential policy challenges in sustaining routine immunization systems during crises.

---

## Reproducibility
To reproduce this analysis locally:

```r
# Install required R packages
install.packages(c("tidyverse", "ggplot2", "dplyr", "lmtest", 
                   "ggrepel", "sandwich", "ggcorrplot", "ggpubr", "lubridate"))

# Knit the analysis
rmarkdown::render("scripts/ontario_analysis.Rmd")
