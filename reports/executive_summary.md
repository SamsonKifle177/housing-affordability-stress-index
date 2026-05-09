# Executive Summary

## Project

Global Housing Affordability Stress Index

## Objective

This project analyzes housing affordability pressure across countries using public housing, macroeconomic, and population data.

The goal is to identify which countries are experiencing elevated housing affordability stress, how stress has changed over time, and which indicators are most associated with high stress.

## Business Context

Housing affordability is a major issue for households, policymakers, lenders, urban planners, and real estate decision-makers.

Affordability pressure is not caused by one factor alone. It can be influenced by:

- House price growth
- Income growth
- Rent pressure
- Urban population growth
- Inflation
- Labor market conditions
- Housing supply constraints
- Mortgage and credit conditions

This project focuses on country-level indicators to create a high-level screening framework for housing affordability stress.

## Data Sources

The analysis uses public data from:

- OECD Analytical House Price Indicators
- World Bank World Development Indicators

The final dataset combines OECD housing indicators with World Bank macroeconomic and population indicators at the country-year level.

## Methodology Summary

The project followed an end-to-end analytics workflow:

1. Collected World Bank indicators using the World Bank API.
2. Collected OECD housing indicators from the OECD data service.
3. Filtered OECD data to annual observations.
4. Cleaned and reshaped both datasets into country-year format.
5. Joined the datasets using country code and year.
6. Created year-over-year growth features.
7. Built a custom Housing Affordability Stress Score.
8. Performed exploratory analysis in Python.
9. Loaded the cleaned data into SQLite.
10. Wrote SQL queries for rankings, trends, and high-stress countries.
11. Built a Power BI dashboard for business analysis.

## Housing Affordability Stress Score

The custom score ranges from 0 to 100.

It combines:

- Price-to-income ratio
- Real house price index
- Price-to-rent ratio
- Urban population growth
- House-price-income gap

The score is designed as an early-warning framework, not an official affordability measure.

## Key Findings

### 1. Housing stress is strongly linked to price and valuation pressure.

The strongest relationships with the Housing Affordability Stress Score were found in:

- Real house price index
- Price-to-rent ratio
- Price-to-income ratio

This suggests that affordability stress in the dataset is primarily associated with housing market valuation and price pressure.

### 2. Urban population growth provides useful context but does not explain stress alone.

Urban population growth had a weaker relationship with the stress score. This does not mean urbanization is irrelevant. Instead, it suggests that country-level urban population growth does not fully capture local housing market constraints such as zoning, supply shortages, mortgage conditions, or city-level demand pressure.

### 3. Current high-stress countries and deteriorating countries are not always the same.

Some countries rank highly because they currently have elevated stress scores. Other countries are important because their stress score increased significantly over time.

This distinction is useful for stakeholders because it separates:

- Current affordability pressure
- Long-term deterioration
- Early-warning signals

### 4. A composite score helps simplify a complex housing problem.

Housing affordability is multidimensional. The custom stress score makes it easier to compare countries across several indicators while still allowing users to drill into individual drivers.

## Dashboard Pages

The Power BI dashboard includes four pages:

### Executive Overview

Shows latest-year stress rankings, average stress score, country coverage, and stress category distribution.

### Country Deep Dive

Allows users to select a country and explore housing stress, price-to-income pressure, and real house prices over time.

### Drivers of Stress

Compares stress score with key indicators such as price-to-income, price-to-rent, urban population growth, and house-price-income gap.

### Recommendations

Identifies high-stress countries and translates the analysis into monitoring and policy recommendations.

## Business Recommendations

1. Monitor countries where price-to-income and price-to-rent ratios are both elevated.
2. Prioritize deeper country-level or city-level research in High and Severe stress markets.
3. Track whether real house prices continue rising faster than income growth.
4. Use stress categories as an early-warning framework rather than a final policy conclusion.
5. Combine country-level analysis with local housing supply, mortgage, rental, zoning, and construction data before making decisions.

## Limitations

This project has several limitations:

- OECD housing data has stronger coverage for advanced economies.
- Country-level results can hide major city-level differences.
- Price-to-income and price-to-rent ratios are index-based.
- The stress score is a custom analytical framework and depends on selected weights.
- The project does not include mortgage rates, housing supply, zoning restrictions, construction permits, or household-level affordability data.

## Future Improvements

Future versions could include:

- City-level affordability data
- Mortgage interest rates
- Construction permit data
- Housing supply indicators
- Forecasting future stress scores
- Country clustering
- Streamlit app for interactive scenario analysis

## Conclusion

This project demonstrates a full data analytics workflow using a real-world housing affordability problem.

It includes public data collection, data cleaning, feature engineering, SQL analysis, Python exploratory analysis, custom index creation, dashboard design, storytelling, and business recommendations.

The final result is a recruiter-ready portfolio project that shows practical data analyst and junior data scientist skills.
