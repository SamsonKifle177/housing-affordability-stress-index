-- ============================================================
-- Global Housing Affordability Stress Index
-- SQL Analysis Queries
-- ============================================================

-- Table:
-- housing_macro_country_year
--
-- Purpose:
-- Analyze country-year housing affordability stress using
-- OECD housing indicators and World Bank macroeconomic indicators.


-- ============================================================
-- 1. Latest available year
-- ============================================================

SELECT
    MAX(year) AS latest_year
FROM housing_macro_country_year;


-- ============================================================
-- 2. Top 10 countries by housing affordability stress
-- ============================================================

SELECT
    country_id,
    country_name,
    year,
    ROUND(housing_affordability_stress_score, 2) AS stress_score,
    housing_stress_category,
    ROUND(price_to_income_ratio, 2) AS price_to_income_ratio,
    ROUND(real_house_price_index, 2) AS real_house_price_index,
    ROUND(price_to_rent_ratio, 2) AS price_to_rent_ratio
FROM housing_macro_country_year
WHERE year = (
    SELECT MAX(year)
    FROM housing_macro_country_year
)
ORDER BY housing_affordability_stress_score DESC
LIMIT 10;


-- ============================================================
-- 3. Bottom 10 countries by housing affordability stress
-- ============================================================

SELECT
    country_id,
    country_name,
    year,
    ROUND(housing_affordability_stress_score, 2) AS stress_score,
    housing_stress_category,
    ROUND(price_to_income_ratio, 2) AS price_to_income_ratio,
    ROUND(real_house_price_index, 2) AS real_house_price_index,
    ROUND(price_to_rent_ratio, 2) AS price_to_rent_ratio
FROM housing_macro_country_year
WHERE year = (
    SELECT MAX(year)
    FROM housing_macro_country_year
)
ORDER BY housing_affordability_stress_score ASC
LIMIT 10;


-- ============================================================
-- 4. Average housing stress by year
-- ============================================================

SELECT
    year,
    ROUND(AVG(housing_affordability_stress_score), 2) AS avg_stress_score,
    ROUND(MIN(housing_affordability_stress_score), 2) AS min_stress_score,
    ROUND(MAX(housing_affordability_stress_score), 2) AS max_stress_score,
    COUNT(DISTINCT country_id) AS countries_count
FROM housing_macro_country_year
GROUP BY year
ORDER BY year;


-- ============================================================
-- 5. Count of countries by stress category in latest year
-- ============================================================

SELECT
    housing_stress_category,
    COUNT(DISTINCT country_id) AS country_count
FROM housing_macro_country_year
WHERE year = (
    SELECT MAX(year)
    FROM housing_macro_country_year
)
GROUP BY housing_stress_category
ORDER BY country_count DESC;


-- ============================================================
-- 6. Countries with the largest stress score increase
-- ============================================================

WITH country_first_latest AS (
    SELECT
        country_id,
        country_name,
        MIN(year) AS first_year,
        MAX(year) AS latest_year
    FROM housing_macro_country_year
    GROUP BY country_id, country_name
),

country_scores AS (
    SELECT
        c.country_id,
        c.country_name,
        c.first_year,
        c.latest_year,
        f.housing_affordability_stress_score AS first_stress_score,
        l.housing_affordability_stress_score AS latest_stress_score,
        l.housing_affordability_stress_score - f.housing_affordability_stress_score AS stress_score_change
    FROM country_first_latest c
    JOIN housing_macro_country_year f
        ON c.country_id = f.country_id
       AND c.first_year = f.year
    JOIN housing_macro_country_year l
        ON c.country_id = l.country_id
       AND c.latest_year = l.year
)

SELECT
    country_id,
    country_name,
    first_year,
    latest_year,
    ROUND(first_stress_score, 2) AS first_stress_score,
    ROUND(latest_stress_score, 2) AS latest_stress_score,
    ROUND(stress_score_change, 2) AS stress_score_change
FROM country_scores
ORDER BY stress_score_change DESC
LIMIT 10;


-- ============================================================
-- 7. Countries where house prices grew faster than income
-- ============================================================

SELECT
    country_id,
    country_name,
    year,
    ROUND(real_house_price_yoy_growth_pct, 2) AS real_house_price_growth_pct,
    ROUND(gdp_per_capita_yoy_growth_pct, 2) AS gdp_per_capita_growth_pct,
    ROUND(house_price_income_gap, 2) AS house_price_income_gap
FROM housing_macro_country_year
WHERE house_price_income_gap > 0
ORDER BY house_price_income_gap DESC
LIMIT 25;


-- ============================================================
-- 8. Latest year high-stress countries
-- ============================================================

SELECT
    country_id,
    country_name,
    year,
    ROUND(housing_affordability_stress_score, 2) AS stress_score,
    housing_stress_category
FROM housing_macro_country_year
WHERE year = (
    SELECT MAX(year)
    FROM housing_macro_country_year
)
AND housing_stress_category IN ('High', 'Severe')
ORDER BY housing_affordability_stress_score DESC;


-- ============================================================
-- 9. Average stress by country over full period
-- ============================================================

SELECT
    country_id,
    country_name,
    ROUND(AVG(housing_affordability_stress_score), 2) AS avg_stress_score,
    ROUND(MIN(housing_affordability_stress_score), 2) AS min_stress_score,
    ROUND(MAX(housing_affordability_stress_score), 2) AS max_stress_score,
    COUNT(DISTINCT year) AS years_available
FROM housing_macro_country_year
GROUP BY country_id, country_name
ORDER BY avg_stress_score DESC;


-- ============================================================
-- 10. Latest year dashboard table
-- ============================================================

SELECT
    country_id,
    country_name,
    year,
    ROUND(housing_affordability_stress_score, 2) AS stress_score,
    housing_stress_category,
    ROUND(price_to_income_ratio, 2) AS price_to_income_ratio,
    ROUND(price_to_rent_ratio, 2) AS price_to_rent_ratio,
    ROUND(real_house_price_index, 2) AS real_house_price_index,
    ROUND(rent_price_index, 2) AS rent_price_index,
    ROUND(urban_population_pct, 2) AS urban_population_pct,
    ROUND(urban_population_growth_pct, 2) AS urban_population_growth_pct,
    ROUND(gdp_per_capita_current_usd, 2) AS gdp_per_capita_current_usd,
    ROUND(inflation_pct, 2) AS inflation_pct,
    ROUND(unemployment_pct, 2) AS unemployment_pct
FROM housing_macro_country_year
WHERE year = (
    SELECT MAX(year)
    FROM housing_macro_country_year
)
ORDER BY housing_affordability_stress_score DESC;