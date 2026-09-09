-- Create the clean table by filtering out blank Excel rows
DROP TABLE IF EXISTS athletics_clean;

CREATE TABLE athletics_clean AS
SELECT *
FROM athletics
WHERE unitid IS NOT NULL;

-- Confirm the clean table row count
SELECT COUNT(*) AS total_records
FROM athletics_clean;


-- QUESTION 1: How many sports program records are included in the dataset?

SELECT COUNT(*) AS total_records
FROM athletics_clean;


-- QUESTION 2: How many unique institutions are represented in the dataset?

SELECT COUNT(DISTINCT unitid) AS total_institutions
FROM athletics_clean;


-- QUESTION 3: How many unique sports are represented in the dataset?

SELECT COUNT(DISTINCT Sports) AS total_sports
FROM athletics_clean;


-- QUESTION 4: Which NCAA classifications are represented in the dataset?

SELECT 
    classification_name,
    COUNT(*) AS total_records
FROM athletics_clean
GROUP BY classification_name
ORDER BY total_records DESC;


-- QUESTION 5: Which states have the largest number of institutions
-- represented in the dataset?

SELECT 
    state_cd,
    COUNT(DISTINCT unitid) AS total_institutions
FROM athletics_clean
GROUP BY state_cd
ORDER BY total_institutions DESC
LIMIT 10;
