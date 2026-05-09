# Methodology

## Project

Global Housing Affordability Stress Index

## Objective

The objective of this project is to analyze housing affordability pressure across countries using public housing, macroeconomic, and population datasets.

The project combines OECD housing indicators with World Bank indicators to create a country-year dataset and a custom Housing Affordability Stress Score.

## Analytical Question

The main question is:

Which countries are experiencing the highest housing affordability stress, how has that stress changed over time, and what indicators are most associated with it?

## Data Sources

### OECD Analytical House Price Indicators

Used for housing market indicators:

- Rent price index
- Nominal house price index
- Real house price index
- Price-to-income ratio
- Price-to-rent ratio

### World Bank World Development Indicators

Used for country-level macroeconomic and population indicators:

- Total population
- Urban population percentage
- Urban population growth
- GDP per capita
- Inflation
- Unemployment

## Data Collection Process

The data collection process was completed in Python.

### World Bank Data

World Bank indicators were collected using the World Bank API. The API returned long-format country-year data for each indicator. These individual indicator tables were combined and pivoted into a wide country-year table.

### OECD Housing Data

OECD housing data was collected from the OECD data service. The dataset included both quarterly and annual observations. Since the World Bank data is annual, only annual OECD records were kept.

The OECD data was filtered to the following measures:

- Rent prices
- Nominal house price indices
- Real house price indices
- Price-to-income ratio
- Price-to-rent ratio

## Data Cleaning Process

The cleaning process included:

1. Filtering OECD data to annual observations.
2. Keeping only relevant housing indicators.
3. Reshaping OECD housing data from long format to country-year wide format.
4. Reshaping World Bank data from long format to country-year wide format.
5. Joining OECD and World Bank data using country code and year.
6. Removing OECD aggregate entities such as OECD, EA, and EA17.
7. Keeping records with the core required indicators:
   - Real house price index
   - Price-to-income ratio
8. Checking duplicate country-year records.
9. Checking country and year coverage.
10. Saving a processed analysis-ready dataset.

## Final Dataset Grain

Each row represents one country in one year.

Example:

```text
Canada - 2024
Portugal - 2024
United States - 2024
```

## Feature Engineering

Several derived fields were created to support affordability analysis.

### Year-over-Year Growth Metrics

The following year-over-year growth metrics were calculated by country:

- Real house price growth
- Price-to-income ratio growth
- Rent price growth
- GDP per capita growth

### House-Price-Income Gap

The house-price-income gap compares real house price growth with GDP per capita growth.

```text
house_price_income_gap =
real_house_price_yoy_growth_pct - gdp_per_capita_yoy_growth_pct
```

A positive value suggests that real house prices are growing faster than income.

## Housing Affordability Stress Score

A custom Housing Affordability Stress Score was created to compare countries across multiple dimensions of housing pressure.

The score combines:

- Price-to-income ratio
- Real house price index
- Price-to-rent ratio
- Urban population growth
- House-price-income gap

Each metric was normalized using min-max scaling.

The final score ranges from 0 to 100.

## Stress Score Formula

```text
Housing Stress Score =
0.35 * price_to_income_ratio_scaled
+ 0.25 * real_house_price_index_scaled
+ 0.20 * price_to_rent_ratio_scaled
+ 0.10 * urban_population_growth_pct_scaled
+ 0.10 * house_price_income_gap_scaled
```

## Weighting Rationale

The weights were selected to prioritize affordability and valuation pressure.

| Component | Weight | Rationale |
|---|---:|---|
| Price-to-income ratio | 35% | Core affordability pressure indicator |
| Real house price index | 25% | Captures inflation-adjusted housing price pressure |
| Price-to-rent ratio | 20% | Captures valuation pressure relative to rents |
| Urban population growth | 10% | Captures demand-side demographic pressure |
| House-price-income gap | 10% | Captures whether housing prices are outpacing income growth |

## Stress Categories

The score was converted into categories for dashboard interpretation.

| Score Range | Category |
|---|---|
| 0 to less than 40 | Low |
| 40 to less than 60 | Moderate |
| 60 to less than 75 | High |
| 75 and above | Severe |

## SQL Analysis

After creating the processed dataset, the data was loaded into a local SQLite database.

SQL was used to answer business questions such as:

1. Which countries have the highest stress score in the latest year?
2. Which countries have the lowest stress score in the latest year?
3. How has average stress changed over time?
4. Which countries experienced the largest increase in stress?
5. Which countries are currently categorized as High or Severe stress?

The SQL phase demonstrates:

- Filtering
- Aggregation
- Sorting
- Common table expressions
- Subqueries
- Dashboard-ready table creation

## Dashboard Design

The dashboard was built in Power BI.

It includes four pages:

### 1. Executive Overview

Shows the latest-year ranking, average stress score, country coverage, and stress category distribution.

### 2. Country Deep Dive

Allows users to select a country and explore trends over time.

### 3. Drivers of Stress

Compares the stress score with underlying indicators such as price-to-income, price-to-rent, and urban population growth.

### 4. Recommendations

Summarizes high-stress countries and provides business or policy recommendations.

## Key Analytical Assumptions

1. Country-level indicators can provide a useful high-level view of affordability pressure.
2. Price-to-income and price-to-rent ratios are useful indicators of affordability and valuation pressure.
3. A composite score can help summarize multiple housing pressure indicators.
4. The stress score should be interpreted as a screening tool, not a final policy diagnosis.
5. City-level housing dynamics may differ significantly from country-level results.

## Limitations

- OECD housing data has stronger coverage for advanced economies.
- Country-level data may hide city-level affordability differences.
- Price-to-income and price-to-rent ratios are index-based.
- The custom stress score depends on selected indicators and weights.
- The project does not include mortgage interest rates, local housing supply, zoning, construction permits, or household-level income distributions.

## Future Improvements

Future versions of this project could include:

- City-level housing affordability data
- Mortgage interest rates
- Construction permit and housing supply data
- Local rental market indicators
- Forecasting future stress scores
- Clustering countries into affordability profiles
- A Streamlit app for interactive scenario analysis

## Summary

This methodology creates a reproducible analytics workflow that moves from public data collection to cleaned datasets, SQL analysis, Python EDA, a custom stress score, and an interactive Power BI dashboard.

The project is designed to demonstrate practical data analyst and junior data scientist skills using a real-world housing affordability problem.
