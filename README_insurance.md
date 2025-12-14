# Texas Health Insurance, Measles Outbreaks, and Labor Market Dynamics (2014–2024)
**Author:** Miriam Zhou  

### Overview

This analysis investigates the relationship between **health insurance coverage**, **measles outbreaks**, and **self-employment trends** in **Texas** from **2014 to 2024**.  
It combines federal insurance and population datasets with county-level disease surveillance to assess how gaps in coverage correlate with outbreak intensity and how employment type affects uninsured rates.

The project integrates **U.S. Census**, **American Community Survey (ACS)**, and **CDC measles case data** to explore structural vulnerabilities in public-health coverage systems.

---

## Data Sources

All data used in this notebook are publicly available and stored in the `/data` directory.

| Dataset | Source | Description |
|----------|---------|-------------|
| **`texas_measles.csv`** | [CDC: Measles Surveillance](https://www.cdc.gov/measles/data-research/index.html) | Annual county-level measles case counts (2014–2024) used to quantify outbreak intensity. |
| **`analytic_data2014.csv` – `analytic_data2024.csv`** | [U.S. Census Bureau: Small Area Health Insurance Estimates (SAHIE)](https://www.census.gov/data/datasets/time-series/demo/sahie.html) | Yearly health-insurance coverage data by county and demographic subgroup (adults, children, all ages). Used to compute uninsured rates. |
| **`texas 2016-2024.csv`** | [U.S. Census Bureau: American Community Survey (ACS) Health Insurance Tables](https://data.census.gov/) | Detailed breakdown of Texas population by insurance type: private, public, and uninsured. Used to build state-level coverage trends. |
| **`ACSCP1Y2019.CP03-Data.csv`, `ACSCP1Y2024.CP03-Data.csv`** | [ACS: Class of Worker (Table CP03)](https://data.census.gov/) | Annual labor market composition, used to compute state-level self-employment rates and merge with insurance shares. |
| **`texas_clean_ready.csv`, `texas_clean_headers_fixed.csv`** | Generated in this notebook | Cleaned and standardized outputs from `texas 2016-2024.csv` for reproducible use. |

All data are open-source and restricted to public, non-commercial educational use.

---

## Methodology

The notebook is organized into four main analysis sections:

### 1. Measles Incidence vs. Insurance Coverage (2014–2024)
- Imports annual county-level measles cases and uninsured rates.  
- Cleans and harmonizes county names (`str_to_lower`, `str_trim`, `str_remove(" county")`).  
- Combines all years (2014–2024) into a **panel dataset** (`panel`) with variables:
  - `Uninsured_All`, `Uninsured_Adults`, `Uninsured_Children`, `Population`, and `Measles_Cases`.  
- Produces **scatter and facet plots** showing the association between measles outbreaks and uninsured rates by year.

### 2. Cleaning and Structuring State-Level Insurance Data
- Reads raw ACS table (`texas 2016–2024.csv`) and applies custom headers for 50+ insurance-type columns.  
- Cleans hierarchical rows (removes redundant header rows, fills missing year labels downward).  
- Outputs a fully flattened dataset (`texas_clean_ready.csv`) with consistent numeric columns.

### 3. Health Insurance Coverage Trends (2016–2024)
- Computes population shares for **private**, **public**, and **uninsured** coverage.  
- Visualizes long-run trends and highlights **2019** (the pandemic onset reference year).  
- Fits simple **OLS models**:
  - `lm(public_share ~ private_share + texas_year)` → substitution between coverage types  
  - `lm(uninsured_share ~ private_share + public_share + texas_year)` → determinants of uninsured rates  
- Results show declining private coverage and partial substitution by public insurance, but a persistent uninsured gap.

### 4. Self-Employment and Insurance Gaps
- Imports ACS “Class of Worker” tables (2019, 2024) and extracts **self-employment rates**.  
- Reshapes to long format and merges with coverage data (`merged_texas`).  
- Plots dual-axis trendlines showing how **self-employment rates track uninsured rates** over time.  
- Runs:
  ```r
  lm(uninsured_share ~ SelfEmpRate + texas_year)

## Reproducibility

To reproduce this analysis:
```r
# Install dependencies
install.packages(c("tidyverse", "ggplot2", "dplyr", "stringr",
                   "janitor", "broom", "scales", "ggrepel", "lmtest", "sandwich"))

# Render the notebook
rmarkdown::render("scripts/measles_insurance_analysis.Rmd")
