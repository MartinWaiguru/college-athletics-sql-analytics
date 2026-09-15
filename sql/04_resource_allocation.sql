-- QUESTION 1: Which sports have the highest
-- expense per participant across all programs?

SELECT 
    Sports,
    SUM(TOTAL_PARTICIPANTS) AS total_participants,
    ROUND(SUM(TOTAL_EXPENSE_ALL), 2) AS total_expenses,
    ROUND(SUM(TOTAL_EXPENSE_ALL) * 1.0 / SUM(TOTAL_PARTICIPANTS), 2) AS expense_per_participant
FROM athletics_clean
GROUP BY Sports
HAVING total_participants > 0
ORDER BY expense_per_participant DESC
LIMIT 10;



-- QUESTION 2: How does expense per participant 
-- compare across NCAA classifications?

SELECT 
    classification_name,
    COUNT(*) AS total_programs,
    SUM(TOTAL_PARTICIPANTS) AS total_participants,
    ROUND(SUM(TOTAL_EXPENSE_ALL), 2) AS total_expenses,
    ROUND(SUM(TOTAL_EXPENSE_ALL) * 1.0 / SUM(TOTAL_PARTICIPANTS), 2) AS avg_expense_per_participant
FROM athletics_clean
WHERE classification_name IS NOT NULL
GROUP BY classification_name
HAVING total_participants > 0
ORDER BY avg_expense_per_participant DESC;



-- QUESTION 3: How are financial resources allocated
-- across Men's and Women's sports teams?

SELECT 
    'Men''s Teams' AS gender_category,
    SUM(SUM_PARTIC_MEN) AS total_participants,
    ROUND(SUM(EXPENSE_MENALL), 2) AS total_expense,
    ROUND(SUM(EXPENSE_MENALL) * 1.0 / NULLIF(SUM(SUM_PARTIC_MEN), 0), 2) AS expense_per_participant
FROM athletics_clean

UNION ALL

SELECT 
    'Women''s Teams' AS gender_category,
    SUM(SUM_PARTIC_WOMEN) AS total_participants,
    ROUND(SUM(EXPENSE_WOMENALL), 2) AS total_expense,
    ROUND(SUM(EXPENSE_WOMENALL) * 1.0 / NULLIF(SUM(SUM_PARTIC_WOMEN), 0), 2) AS expense_per_participant
FROM athletics_clean;



-- QUESTION 4: Programs spending that are 2x greater the national
-- sport benchmark per participant

WITH sport_benchmarks AS (
    SELECT 
        Sports,
        SUM(TOTAL_EXPENSE_ALL) * 1.0 / NULLIF(SUM(TOTAL_PARTICIPANTS), 0) AS national_avg_per_part
    FROM athletics_clean
    GROUP BY Sports
),
program_costs AS (
    SELECT 
        institution_name,
        state_cd,
        classification_name,
        Sports,
        TOTAL_PARTICIPANTS,
        TOTAL_EXPENSE_ALL,
        ROUND(TOTAL_EXPENSE_ALL * 1.0 / NULLIF(TOTAL_PARTICIPANTS, 0), 2) AS program_cost_per_part
    FROM athletics_clean
    WHERE TOTAL_PARTICIPANTS > 0
)
SELECT 
    p.institution_name,
    p.classification_name,
    p.Sports,
    p.TOTAL_PARTICIPANTS,
    p.program_cost_per_part,
    ROUND(b.national_avg_per_part, 2) AS national_sport_avg,
    ROUND(p.program_cost_per_part / b.national_avg_per_part, 2) AS multiplier_vs_avg
FROM program_costs p
JOIN sport_benchmarks b ON p.Sports = b.Sports
WHERE p.program_cost_per_part > (2.0 * b.national_avg_per_part)
ORDER BY multiplier_vs_avg DESC
LIMIT 10;
