# NCAA Athletic Department Financial Analytics

## Project Overview

This project analyzes collegiate athletic department financial data using SQL and Power BI to understand revenue, expenses, financial performance, and resource allocation across sports programs.

The analysis uses Equity in Athletics Disclosure Act (EADA) data reported by U.S. colleges and universities to the U.S. Department of Education. The workflow covers data cleaning and validation, SQL-based analysis, calculated financial metrics, and an interactive Power BI dashboard.

The project focuses on answering practical analytical questions such as:

- Which sports generate the most revenue?
- Which sports have the highest expenses?
- Which sports produce the largest surpluses or deficits?
- How much is spent per participant across sports?
- How does resource allocation differ across NCAA classifications?
- How does spending compare between men's and women's teams?
- Which individual programs have unusually high spending relative to their sport's benchmark?

---

## Business Problem

College athletic departments manage large and complex budgets across multiple sports programs. Revenue generation, operating expenses, participant numbers, and institutional characteristics can vary substantially between sports and NCAA classifications.

The objective of this analysis is to identify financial patterns and resource-allocation differences that can help provide a clearer view of how athletic departments allocate and manage financial resources.

---

## Analytical Approach

The project follows an end-to-end analytics workflow:

1. **Data preparation**
   - Cleaned the source dataset and removed blank records.
   - Addressed unnecessary Excel rows that expanded the dataset beyond the actual records.
   - Prepared the data for analysis in SQLite and Power BI.

2. **Data quality validation**
   - Checked for missing institution IDs, institution names, and sport names.
   - Checked for duplicate institution-sport combinations.
   - Identified programs with missing or zero participant counts.
   - Checked for negative revenue and expense values.

3. **Exploratory analysis**
   - Examined the number of institutions, sports, and records.
   - Analyzed NCAA classifications.
   - Examined geographic distribution by state.

4. **Financial performance analysis**
   - Compared total and average revenue by sport.
   - Compared total and average expenses by sport.
   - Calculated financial differences between revenue and expenses.
   - Identified programs with the largest financial deficits.
   - Evaluated financial performance of Division I-FBS athletic departments.

5. **Resource allocation analysis**
   - Calculated expense per participant.
   - Compared spending intensity across NCAA classifications.
   - Compared men's and women's team spending.
   - Benchmarked individual program spending against the average for their sport.

6. **Dashboard development**
   - Built a Power BI dashboard to present the main financial and resource-allocation findings.
   - Created calculated metrics including total revenue, total expenses, net result, and cost per participant.

---

## Key Metrics

The Power BI dashboard summarizes the dataset using several high-level metrics:

| Metric | Description |
|---|---|
| Total Revenue | Combined reported athletic revenue |
| Total Expenses | Combined reported athletic expenses |
| Net Result | Revenue minus expenses |
| Cost per Participant | Total expenses divided by total participants |

The current dashboard reports approximately **$20.85 billion in total revenue** and **$19.24 billion in total expenses** across the analyzed records.

---

## Dashboard

![Power BI Financial Analytics](images/Power%20BI%20Financial%20Analytics.png)

The Power BI dashboard provides a visual overview of:

- Total athletic revenue
- Total athletic expenses
- Average cost per participant by sport
- Net financial result by sport

The `.pbix` file is included in the repository for further exploration in Power BI Desktop.

---

## Key Findings

### 1. Revenue and expenses are concentrated across major sports

The analysis shows substantial differences in revenue and expenses between sports. Football and basketball account for particularly large financial totals compared with many other programs.

### 2. Spending intensity varies significantly by sport

Cost per participant differs considerably across sports. Looking at spending on a per-participant basis provides a different perspective from simply comparing total expenses.

### 3. Sports can have substantially different financial results

Comparing revenue with expenses reveals meaningful differences in financial performance between sports, including programs with positive financial results and programs operating at a deficit.

### 4. Resource allocation varies across NCAA classifications

Expense per participant differs across NCAA classifications, indicating that the scale and intensity of athletic spending varies across different types of institutions.

### 5. Individual programs can differ substantially from their sport benchmark

The resource-allocation analysis identifies programs whose expense per participant is more than twice the national average for their respective sport.

> These findings describe patterns in the reported data and should not be interpreted as evidence that a sport or institution is inherently more or less efficient without considering institutional context.

---

## SQL Analysis

The SQL analysis is organized into four stages.

### `01_data_exploration.sql`

Explores the structure and coverage of the dataset.

Questions include:

- How many athletic program records are included?
- How many unique institutions are represented?
- How many sports are represented?
- Which NCAA classifications are included?
- Which states contain the most institutions?

### `02_data_quality_checks.sql`

Validates the quality of the cleaned dataset.

Checks include:

- Missing identifiers
- Missing institution or sport names
- Duplicate institution-sport combinations
- Missing or zero participant counts
- Negative revenue or expense values

### `03_financial_performance.sql`

Analyzes financial performance across sports and institutions.

Analysis includes:

- Revenue by sport
- Expenses by sport
- Financial difference by sport
- Programs with the largest deficits
- Division I-FBS department financial performance

### `04_resource_allocation.sql`

Analyzes how financial resources are allocated.

Analysis includes:

- Expense per participant by sport
- Expense per participant by NCAA classification
- Men's versus women's team spending
- Programs spending more than twice their sport-level benchmark

---

## SQL Techniques Demonstrated

The project demonstrates the following SQL concepts in SQLite:

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `LIMIT`
- `COUNT`
- `COUNT(DISTINCT)`
- `SUM`
- `AVG`
- `ROUND`
- `CASE`
- `NULLIF`
- `UNION ALL`
- Common Table Expressions (CTEs)
- Subqueries
- `JOIN`
- Conditional filtering
- Aggregation
- Ratio calculations
- Margin calculations
- Data-quality checks
- Defensive calculations to avoid division-by-zero errors

---

## Power BI

The Power BI dashboard uses calculated fields to support the visual analysis.

### Net Result

```DAX
Net_Result =
schools_cleaned[TOTAL_REVENUE_ALL]
    - schools_cleaned[TOTAL_EXPENSE_ALL]

Cost per Participant
Cost_Per_Participant =
DIVIDE(
    schools_cleaned[TOTAL_EXPENSE_ALL],
    schools_cleaned[TOTAL_PARTICIPANTS],
    0
)
```

These calculations support the financial-performance and resource-allocation analysis presented in the dashboard.

### Data Quality and Preparation

The original data required preparation before analysis.

One issue encountered during preparation was unnecessary blank Excel rows that caused the working dataset to expand to more than one million rows. The dataset was cleaned by removing records without a valid institution ID before further analysis.

The SQL workflow then created a cleaned analysis table using:

```CREATE TABLE athletics_clean AS
SELECT *
FROM athletics
WHERE unitid IS NOT NULL;
```
Additional SQL checks were performed to identify missing identifiers, duplicate institution-sport combinations, invalid participant counts, and negative financial values.

Data Source

The project uses data from the Equity in Athletics Disclosure Act (EADA) reporting system administered by the U.S. Department of Education.

EADA requires participating institutions to report information about their intercollegiate athletic programs, including financial and participation data.

Source:

U.S. Department of Education — EADA

Repository Structure

```college-athletics-sql-analytics/
│
├── 01_data_exploration.sql
├── 02_data_quality_checks.sql
├── 03_financial_performance.sql
├── 04_resource_allocation.sql
├── NCAA_Financial_Analytics.pbix
├── Power BI NCAA_Financial_Analytics.png
└── README.md
```
Tools Used
Excel — Initial data preparation and cleaning
SQLite / DB Browser for SQLite — Data exploration, validation, and SQL analysis
Power BI — Data visualization and dashboard development
GitHub — Version control and project documentation
Limitations
The analysis is based on reported EADA data and therefore depends on the accuracy and completeness of institutional reporting.
The analysis represents a specific reporting period rather than a multi-year trend.
A positive financial difference should not automatically be interpreted as commercial profit.
Expense per participant is a spending metric and does not measure program quality, athletic performance, or institutional efficiency by itself.
Differences between institutions should be interpreted with consideration for NCAA classification, institution size, sport mix, and other institutional factors.
Financial results for individual sports should not be interpreted as standalone measures of overall athletic-department performance.
Future Improvements

Potential future improvements include:

Adding multi-year EADA data to analyze financial trends over time.
Expanding the Power BI dashboard with NCAA classification and institution-level filters.
Adding additional financial efficiency metrics.
Investigating relationships between athletic spending, participation, and institutional characteristics.
Adding more advanced statistical analysis to identify factors associated with financial performance.
Project Files
File	Purpose
01_data_exploration.sql	Dataset exploration and profiling
02_data_quality_checks.sql	Data-quality validation
03_financial_performance.sql	Financial performance analysis
04_resource_allocation.sql	Resource allocation analysis
NCAA_Financial_Analytics.pbix	Power BI dashboard
Power BI NCAA_Financial_Analytics.png	Dashboard preview
