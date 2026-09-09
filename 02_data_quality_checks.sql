-- DATA QUALITY CHECK 1: Are there any missing
-- institution IDs, institution names, or sports?

SELECT COUNT(*) AS missing_identifier_count
FROM athletics_clean
WHERE unitid IS NULL
   OR institution_name IS NULL
   OR Sports IS NULL;
   


-- DATA QUALITY CHECK 2: Are there duplicate
-- institution and sport combinations?

WITH duplicate_check AS (
    SELECT 
        unitid,
        Sports,
        COUNT(*) AS record_count
    FROM athletics_clean
    GROUP BY unitid, Sports
    HAVING COUNT(*) > 1
)
SELECT COUNT(*) AS total_duplicates
FROM duplicate_check;


-- DATA QUALITY CHECK 3: Are there programs with
-- zero or missing participants?

SELECT COUNT(*) AS null_participant_count
FROM athletics_clean
WHERE TOTAL_PARTICIPANTS IS NULL 
   OR TOTAL_PARTICIPANTS = 0;


-- DATA QUALITY CHECK 4: Are there negative values
-- in revenue or expenses that require investigation?

WITH negative_financials AS (
    SELECT 
        unitid,
        institution_name,
        Sports,
        TOTAL_REVENUE_ALL,
        TOTAL_EXPENSE_ALL
    FROM athletics_clean
    WHERE TOTAL_REVENUE_ALL < 0 
       OR TOTAL_EXPENSE_ALL < 0
)
SELECT COUNT(*) AS negative_financial_count
FROM negative_financials;
