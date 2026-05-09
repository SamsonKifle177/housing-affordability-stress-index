# Data Dictionary

## Project

Global Housing Affordability Stress Index

## Main Dataset

`housing_macro_with_stress_score.csv`

This dataset contains country-year housing affordability, macroeconomic, population, and derived stress score indicators.

## Grain

Each row represents one country in one year.

Example:

```text
Canada - 2024
United States - 2024
Portugal - 2024
```

## Columns

| Column | Description |
|---|---|
| country_id | Three-letter country code |
| country_name | Country name |
| year | Observation year |
| rent_price_index | OECD rent price index |
| nominal_house_price_index | OECD nominal house price index |
| real_house_price_index | OECD real house price index |
| price_to_income_ratio | OECD price-to-income ratio |
| price_to_rent_ratio | OECD price-to-rent ratio |
| population_total | Total population from World Bank |
| urban_population_pct | Urban population as percentage of total population |
| urban_population_growth_pct | Annual urban population growth percentage |
| gdp_per_capita_current_usd | GDP per capita in current US dollars |
| gdp_per_capita_constant_usd | GDP per capita in constant US dollars |
| inflation_pct | Inflation percentage |
| unemployment_pct | Unemployment percentage |
| real_house_price_yoy_growth_pct | Year-over-year growth in real house price index |
| price_to_income_yoy_growth_pct | Year-over-year growth in price-to-income ratio |
| rent_price_yoy_growth_pct | Year-over-year growth in rent price index |
| gdp_per_capita_yoy_growth_pct | Year-over-year growth in GDP per capita |
| house_price_income_gap | Difference between real house price growth and GDP per capita growth |
| price_to_income_ratio_scaled | Normalized price-to-income ratio used in stress score |
| real_house_price_index_scaled | Normalized real house price index used in stress score |
| price_to_rent_ratio_scaled | Normalized price-to-rent ratio used in stress score |
| urban_population_growth_pct_scaled | Normalized urban population growth used in stress score |
| house_price_income_gap_scaled | Normalized house-price-income gap used in stress score |
| housing_affordability_stress_score | Custom 0–100 housing affordability stress score |
| housing_stress_category | Stress category based on score: Low, Moderate, High, or Severe |

## Stress Category Logic

| Score Range | Category |
|---|---|
| 0 to less than 40 | Low |
| 40 to less than 60 | Moderate |
| 60 to less than 75 | High |
| 75 and above | Severe |

## Housing Affordability Stress Score Formula

```text
Housing Stress Score =
0.35 * price_to_income_ratio_scaled
+ 0.25 * real_house_price_index_scaled
+ 0.20 * price_to_rent_ratio_scaled
+ 0.10 * urban_population_growth_pct_scaled
+ 0.10 * house_price_income_gap_scaled
```

## Notes

- The stress score is a custom analytical index, not an official affordability measure.
- OECD housing indicators are index-based.
- Country-level results may hide city-level housing affordability differences.
- Some countries have missing housing indicators in earlier years, so the cleaned dataset keeps records with the core required indicators.
