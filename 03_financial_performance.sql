-- QUESTION 1: Which sports generate the highest
-- total revenue across all institutions?

SELECT 
    Sports,
    COUNT(*) AS total_programs,
    ROUND(SUM(TOTAL_REVENUE_ALL), 2) AS total_revenue,
    ROUND(AVG(TOTAL_REVENUE_ALL), 2) AS avg_revenue_per_program
FROM athletics_clean
GROUP BY Sports
ORDER BY total_revenue DESC
LIMIT 10;



-- QUESTION 2: Which sports have the highest
-- total expenses across all institutions?

SELECT 
    Sports,
    COUNT(*) AS total_programs,
    ROUND(SUM(TOTAL_EXPENSE_ALL), 2) AS total_expense,
    ROUND(AVG(TOTAL_EXPENSE_ALL), 2) AS avg_expense_per_program
FROM athletics_clean
GROUP BY Sports
ORDER BY total_expense DESC
LIMIT 10;



-- QUESTION 3: Which sports have the largest overall
-- financial differences between revenue and expenses?

SELECT 
    Sports,
    COUNT(*) AS total_programs,
    ROUND(SUM(TOTAL_REVENUE_ALL), 2) AS total_revenue,
    ROUND(SUM(TOTAL_EXPENSE_ALL), 2) AS total_expense,
    ROUND(SUM(FINANCIAL_DIFFERENCE), 2) AS total_financial_difference
FROM athletics_clean
GROUP BY Sports
ORDER BY total_financial_difference ASC
LIMIT 10;



-- QUESTION 4: Which individual sports programs have
-- the largest negative financial differences?

SELECT 
    institution_name,
    state_cd,
    classification_name,
    Sports,
    ROUND(TOTAL_REVENUE_ALL, 2) AS total_revenue,
    ROUND(TOTAL_EXPENSE_ALL, 2) AS total_expense,
    ROUND(FINANCIAL_DIFFERENCE, 2) AS financial_difference
FROM athletics_clean
WHERE FINANCIAL_DIFFERENCE < 0
ORDER BY FINANCIAL_DIFFERENCE ASC
LIMIT 10;


-- QUESTION 5: Top D1-FBS Athletic Departments by 
-- Net Profit Margin %

WITH department_totals AS (
    SELECT 
        unitid,
        institution_name,
        state_cd,
        COUNT(Sports) AS total_sports_offered,
        SUM(TOTAL_REVENUE_ALL) AS dept_revenue,
        SUM(TOTAL_EXPENSE_ALL) AS dept_expense,
        SUM(FINANCIAL_DIFFERENCE) AS dept_net_income
    FROM athletics_clean
    WHERE classification_name = 'NCAA Division I-FBS'
    GROUP BY unitid, institution_name, state_cd
)
SELECT 
    institution_name,
    state_cd,
    total_sports_offered,
    ROUND(dept_revenue, 2) AS dept_revenue,
    ROUND(dept_expense, 2) AS dept_expense,
    ROUND(dept_net_income, 2) AS dept_net_income,
    ROUND((dept_net_income * 100.0) / dept_revenue, 2) AS profit_margin_percentage
FROM department_totals
WHERE dept_revenue > 10000000
ORDER BY profit_margin_percentage DESC
LIMIT 10;
