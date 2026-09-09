U.S. College Athletics Financial Analytics & Resource Allocation (2024–2025)
Executive Summary
This project analyzes financial structures, profitability profiles, and unit spending across U.S. higher education athletic departments using nationwide EADA (Equity in Athletics Disclosure Act) financial records.

By modeling 18,045 sports programs across 2,037 institutions, this project evaluates macro revenue engines, operational efficiency ratios, and gender-based resource allocations to deliver actionable benchmarks for athletic administrators and financial analysts.

Key Business Insights
Revenue Dominance: Football accounts for $7.99B in revenue and $5.84B in expenses across college athletics, outstripping all other varsity sports combined.

Profitability Dynamics: Division I-FBS athletic departments display dramatic operational variances. Boise State University achieved the highest overall net profit margin (37.99%), generating $29.16M in net income on $76.74M in total department revenue.

Unit Economics & Line-Item Deficits: While basketball is the most expensive sport per athlete nationally ($63,252.02/participant), elite non-football D1 programs re-invest aggressively. St. John's University (NY) recorded a unit spending outlier of $1,432,730.04 per participant in basketball—22.65x higher than the national average benchmark.

Gender Resource Allocation: Across all reporting institutions, Men’s programs average $28,266.91 per participant versus $20,784.10 per participant for Women’s programs—a 36.0% spending differential driven primarily by high-capital D1 football investments.

Technical Stack & Database Environment
Database Engine: SQLite 3

Interface: DB Browser for SQLite

SQL Techniques Used: Common Table Expressions (CTEs), Subqueries, Aggregate Window Functions, UNION ALL, CASE Logic, Type Casting (* 1.0), Dynamic Column Discovery (PRAGMA), Data Cleaning (NULLIF, ROUND).

Project Structure
Plaintext
├── 01_data_exploration.sql        # Initial schema inspection, row counts, & sport distributions
├── 02_data_quality_checks.sql     # Duplicate validation, NULL handling, & numeric integrity
├── 03_financial_performance.sql   # Top-line revenue, expenses, deficit tracking, & profit margins
├── 04_resource_allocation.sql     # Expense per participant, division comparisons, & gender analysis
└── README.md                      # Executive summary, methodology, & technical documentation
Technical Challenges & Problem Solving
During script development, several database-specific syntax constraints and schema mismatches were identified and resolved to ensure query execution standards.

1. Integer Division Truncation (SQLite Math Engine)
Challenge: In SQLite, dividing two INTEGER values truncates the decimal portion. Initial profit margin calculations (dept_net_income / dept_revenue) yielded 0.0 or 0 across all records.

Resolution: Forced floating-point arithmetic by multiplying numerators by 100.0 or 1.0 prior to division:

SQL
-- Prevents integer division truncation:
ROUND((dept_net_income * 100.0) / dept_revenue, 2) AS profit_margin_pct
2. Schema Column Mismatches & Dynamic Discovery
Challenge: Standard aggregation queries on gender categories failed due to non-standardized source field headers (no such column: gender_category / EXPENSE_MEN).

Resolution: Executed SQLite database metadata diagnostics (PRAGMA table_info(athletics_clean);) to uncover actual schema headers (SUM_PARTIC_MEN, SUM_PARTIC_WOMEN, EXPENSE_MENALL, EXPENSE_WOMENALL). Wrote UNION ALL queries to isolate gender-specific unit costs cleanly:

SQL
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
3. Preventing Division-by-Zero Errors
Challenge: Intermittent programs reporting zero participants caused calculation crashes on unit metrics.

Resolution: Implemented defensive SQL patterns using NULLIF(column, 0) combined with HAVING total_participants > 0 clauses across all ratio queries.

Analytical Query Highlights
Benchmark Multiplier Analysis (CTEs & Outlier Detection)
Identifies institutions spending > 2x the national average for a specific sport:

SQL
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
    p.program_cost_per_part,
    ROUND(b.national_avg_per_part, 2) AS national_sport_avg,
    ROUND(p.program_cost_per_part / b.national_avg_per_part, 2) AS multiplier_vs_avg
FROM program_costs p
JOIN sport_benchmarks b ON p.Sports = b.Sports
WHERE p.program_cost_per_part > (2.0 * b.national_avg_per_part)
ORDER BY multiplier_vs_avg DESC
LIMIT 10;
