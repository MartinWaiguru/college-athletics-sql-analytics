-- ============================================================
-- NCAA ATHLETIC DEPARTMENT FINANCIAL ANALYTICS
-- Data Exploration
-- ============================================================
--
-- Objective:
-- Understand the structure, coverage, and composition of the
-- dataset before performing financial analysis.
--
-- Key areas:
-- 1. Dataset size and coverage
-- 2. Institutions and sports
-- 3. NCAA classifications
-- 4. Geographic coverage
-- ============================================================



-- Create the clean table by filtering out blank Excel rows
DROP TABLE IF EXISTS athletics_clean;

CREATE TABLE athletics_clean AS
SELECT *
FROM athletics
WHERE unitid IS NOT NULL;

-- Confirm the clean table row count
SELECT COUNT(*) AS total_records
FROM athletics_clean;

-- Business question:
-- How many sports program records are included in the dataset?

SELECT COUNT(*) AS total_records
FROM athletics_clean;

-- Business question:
-- How many unique institutions are represented in the dataset?

SELECT COUNT(DISTINCT unitid) AS total_institutions
FROM athletics_clean;

-- Business question:
-- How many unique sports are represented in the dataset?

SELECT COUNT(DISTINCT Sports) AS total_sports
FROM athletics_clean;

-- Business question:
-- Which NCAA classifications are represented in the dataset?

SELECT 
    classification_name,
    COUNT(*) AS total_records
FROM athletics_clean
GROUP BY classification_name
ORDER BY total_records DESC;

-- Business question:
-- Which states have the largest number of institutions represented in the dataset?

SELECT 
    state_cd,
    COUNT(DISTINCT unitid) AS total_institutions
FROM athletics_clean
GROUP BY state_cd
ORDER BY total_institutions DESC
LIMIT 10;
