-- ============================================================
-- BANK LENDING & LOAN OUTCOME INTELLIGENCE
-- Dataset: 2024 HMDA | Texas
-- Database: bank_lending
-- Table: loan_applications
-- ============================================================


-- ============================================================
-- 1. DATABASE / TABLE VALIDATION
-- ============================================================

USE bank_lending;

SELECT COUNT(*) AS total_applications
FROM loan_applications;


-- Check loan outcomes
SELECT
    loan_outcome,
    COUNT(*) AS applications
FROM loan_applications
GROUP BY loan_outcome
ORDER BY applications DESC;


-- ============================================================
-- 2. OVERALL LOAN OUTCOME DISTRIBUTION
-- ============================================================

SELECT
    loan_outcome,
    COUNT(*) AS applications,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM loan_applications),
        2
    ) AS percentage
FROM loan_applications
GROUP BY loan_outcome
ORDER BY applications DESC;


-- ============================================================
-- 3. LOAN PRODUCT VS OUTCOME
-- ============================================================

SELECT
    derived_loan_product_type,
    loan_outcome,
    COUNT(*) AS applications
FROM loan_applications
GROUP BY
    derived_loan_product_type,
    loan_outcome
ORDER BY
    derived_loan_product_type,
    applications DESC;


-- ============================================================
-- 4. ORIGINATION RATE BY LOAN PRODUCT
-- ============================================================

SELECT
    derived_loan_product_type,
    COUNT(*) AS total_applications,
    SUM(loan_outcome = 'Originated') AS originated,
    SUM(loan_outcome = 'Denied') AS denied,
    ROUND(
        SUM(loan_outcome = 'Originated') * 100.0 / COUNT(*),
        2
    ) AS origination_rate
FROM loan_applications
GROUP BY derived_loan_product_type
ORDER BY origination_rate DESC;


-- ============================================================
-- 5. LOAN PURPOSE VS OUTCOME
-- ============================================================

SELECT
    loan_purpose,
    loan_outcome,
    COUNT(*) AS applications
FROM loan_applications
GROUP BY loan_purpose, loan_outcome
ORDER BY loan_purpose, applications DESC;


-- ============================================================
-- 6. DTI RANGE VS OUTCOME
-- ============================================================

SELECT
    CASE
        WHEN debt_to_income_ratio_numeric BETWEEN 36 AND 39
            THEN '36%-39%'
        WHEN debt_to_income_ratio_numeric BETWEEN 40 AND 44
            THEN '40%-44%'
        WHEN debt_to_income_ratio_numeric BETWEEN 45 AND 49
            THEN '45%-49%'
        ELSE 'Missing / Other'
    END AS dti_range,
    loan_outcome,
    COUNT(*) AS applications
FROM loan_applications
GROUP BY
    dti_range,
    loan_outcome
ORDER BY
    dti_range,
    applications DESC;


-- ============================================================
-- 7. LTV RANGE VS OUTCOME
-- ============================================================

SELECT
    CASE
        WHEN loan_to_value_ratio_analysis_value < 60
            THEN '<60%'
        WHEN loan_to_value_ratio_analysis_value < 80
            THEN '60%-<80%'
        WHEN loan_to_value_ratio_analysis_value < 90
            THEN '80%-<90%'
        WHEN loan_to_value_ratio_analysis_value <= 100
            THEN '90%-100%'
        ELSE '>100%'
    END AS ltv_range,
    loan_outcome,
    COUNT(*) AS applications
FROM loan_applications
GROUP BY
    ltv_range,
    loan_outcome
ORDER BY
    ltv_range,
    applications DESC;


-- ============================================================
-- 8. LOAN AMOUNT RANGE VS OUTCOME
-- ============================================================

SELECT
    CASE
        WHEN loan_amount_analysis_value < 100000
            THEN '<$100K'
        WHEN loan_amount_analysis_value < 250000
            THEN '$100K-$250K'
        WHEN loan_amount_analysis_value < 500000
            THEN '$250K-$500K'
        WHEN loan_amount_analysis_value <= 1000000
            THEN '$500K-$1M'
        ELSE '>$1M'
    END AS loan_amount_range,
    loan_outcome,
    COUNT(*) AS applications
FROM loan_applications
GROUP BY
    loan_amount_range,
    loan_outcome
ORDER BY
    loan_amount_range,
    applications DESC;


-- ============================================================
-- 9. INCOME RANGE VS OUTCOME
-- HMDA income is reported in thousands of dollars.
-- ============================================================

SELECT
    CASE
        WHEN income_analysis_value < 50
            THEN '<50K'
        WHEN income_analysis_value < 100
            THEN '50K-<100K'
        WHEN income_analysis_value < 200
            THEN '100K-<200K'
        WHEN income_analysis_value < 500
            THEN '200K-<500K'
        ELSE '500K+'
    END AS income_range,
    loan_outcome,
    COUNT(*) AS applications
FROM loan_applications
GROUP BY
    income_range,
    loan_outcome
ORDER BY
    income_range,
    applications DESC;


-- ============================================================
-- 10. OCCUPANCY TYPE VS OUTCOME
-- ============================================================

SELECT
    occupancy_type,
    loan_outcome,
    COUNT(*) AS applications
FROM loan_applications
GROUP BY occupancy_type, loan_outcome
ORDER BY occupancy_type, applications DESC;


-- ============================================================
-- 11. RACE VS OUTCOME
-- Descriptive analysis only.
-- Does NOT establish causation or discrimination.
-- ============================================================

SELECT
    derived_race,
    loan_outcome,
    COUNT(*) AS applications
FROM loan_applications
GROUP BY derived_race, loan_outcome
ORDER BY derived_race, applications DESC;


-- ============================================================
-- 12. COUNTY-LEVEL OUTCOME ANALYSIS
-- Only counties with at least 1,000 applications.
-- ============================================================

SELECT
    county_code,
    COUNT(*) AS total_applications,
    SUM(loan_outcome = 'Originated') AS originated,
    SUM(loan_outcome = 'Denied') AS denied,
    ROUND(
        SUM(loan_outcome = 'Originated') * 100.0 / COUNT(*),
        2
    ) AS origination_rate
FROM loan_applications
GROUP BY county_code
HAVING COUNT(*) >= 1000
ORDER BY origination_rate DESC;


-- ============================================================
-- 13. INTEREST RATE VS OUTCOME
-- ============================================================

SELECT
    CASE
        WHEN interest_rate_analysis_value < 5
            THEN '<5%'
        WHEN interest_rate_analysis_value < 7
            THEN '5%-<7%'
        WHEN interest_rate_analysis_value < 10
            THEN '7%-<10%'
        ELSE '10%+'
    END AS interest_rate_range,
    loan_outcome,
    COUNT(*) AS applications
FROM loan_applications
GROUP BY
    interest_rate_range,
    loan_outcome
ORDER BY
    interest_rate_range,
    applications DESC;


-- ============================================================
-- 14. ADVANCED SQL — PRODUCT RANKING BY DENIAL RATE
-- Uses CTE + Window Function.
-- ============================================================

WITH product_summary AS
(
    SELECT
        derived_loan_product_type,
        COUNT(*) AS total_applications,
        SUM(loan_outcome = 'Denied') AS denied_applications,
        ROUND(
            SUM(loan_outcome = 'Denied') * 100.0 / COUNT(*),
            2
        ) AS denial_rate
    FROM loan_applications
    GROUP BY derived_loan_product_type
)

SELECT
    derived_loan_product_type,
    total_applications,
    denied_applications,
    denial_rate,
    RANK() OVER (
        ORDER BY denial_rate DESC
    ) AS denial_rate_rank
FROM product_summary
ORDER BY denial_rate_rank;


-- ============================================================
-- 15. DATA QUALITY CHECKS
-- ============================================================

-- Negative income
SELECT COUNT(*) AS negative_income_records
FROM loan_applications
WHERE income_analysis_value < 0;


-- Zero income
SELECT COUNT(*) AS zero_income_records
FROM loan_applications
WHERE income_analysis_value = 0;


-- Property value anomalies
SELECT COUNT(*) AS property_value_anomalies
FROM loan_applications
WHERE property_value_quality_flag = TRUE;


-- Extreme LTV
SELECT COUNT(*) AS extreme_ltv_records
FROM loan_applications
WHERE extreme_ltv_flag = TRUE;


-- LTV consistency anomalies
SELECT COUNT(*) AS ltv_consistency_anomalies
FROM loan_applications
WHERE ltv_consistency_flag = TRUE;


-- High interest rate
SELECT COUNT(*) AS high_interest_records
FROM loan_applications
WHERE high_interest_flag = TRUE;


-- Extreme rate spread
SELECT COUNT(*) AS extreme_rate_spread_records
FROM loan_applications
WHERE extreme_rate_spread_flag = TRUE;


-- Extreme loan amount
SELECT COUNT(*) AS extreme_loan_amount_records
FROM loan_applications
WHERE extreme_loan_amount_flag = TRUE;


-- ============================================================
-- 16. FINAL DATA QUALITY SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_records,
    SUM(income_analysis_value < 0) AS negative_income,
    SUM(income_analysis_value = 0) AS zero_income,
    SUM(property_value_quality_flag = TRUE) AS property_anomalies,
    SUM(extreme_ltv_flag = TRUE) AS extreme_ltv,
    SUM(ltv_consistency_flag = TRUE) AS ltv_consistency_anomalies,
    SUM(high_interest_flag = TRUE) AS high_interest,
    SUM(extreme_rate_spread_flag = TRUE) AS extreme_rate_spread,
    SUM(extreme_loan_amount_flag = TRUE) AS extreme_loan_amount
FROM loan_applications;


-- ============================================================
-- END OF ANALYSIS
-- ============================================================
