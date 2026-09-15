# NCAA Athletic Department Financial Analytics

**SQL | Excel | SQLite | Power BI**

An end-to-end analysis of 2024–25 U.S. collegiate athletics financial data, focused on **financial performance, spending intensity, and resource allocation across sports and institutions**.

![Power BI Dashboard](images/Power%20BI%20Financial%20Analytics.png)

## Business Problem

College athletic departments manage substantial financial resources across multiple sports, institutions, and NCAA classifications. The objective of this project was to identify where revenue and expenses are concentrated, how spending varies across programs, and which programs have unusually high spending relative to their sport-level benchmark.

### Key Questions

* Which sports generate the most revenue and incur the highest expenses?
* Which sports have the largest net financial results?
* How does spending per participant vary across sports and NCAA classifications?
* How does spending differ between men's and women's programs?
* Which programs have unusually high spending relative to their sport-level benchmark?

## Key Findings

* **Financial concentration:** Football and basketball represented the largest reported financial categories across the dataset.
* **Spending intensity:** Expense per participant varied substantially across sports, revealing differences that are not visible from total spending alone.
* **Financial performance:** Revenue and expense comparisons identified substantial differences in net financial results across sports and institutions.
* **Resource allocation:** Spending intensity varied across NCAA classifications and between men's and women's programs.
* **Benchmark outliers:** The analysis identified individual programs whose expense per participant exceeded **2× their sport-level benchmark**, highlighting areas for further investigation.

> Replace the statements above with the exact percentages/dollar values from the final SQL results before publishing.

## Analytical Workflow

**1. Data Preparation**
Cleaned the source dataset in Excel, removed unnecessary blank records, and prepared the data for SQLite and Power BI.

**2. Data Quality**
Validated missing identifiers, duplicate institution-sport combinations, participant counts, and financial values.

**3. SQL Analysis**
Used SQLite to perform exploratory analysis, financial aggregation, comparative analysis, benchmark calculations, and resource-allocation analysis.

**4. Power BI**
Built an interactive dashboard presenting revenue, expenses, net financial results, and spending per participant.

## SQL Analysis

| File                           | Purpose                                    |
| ------------------------------ | ------------------------------------------ |
| `01_data_exploration.sql`      | Dataset profiling and exploratory analysis |
| `02_data_quality_checks.sql`   | Data validation and quality checks         |
| `03_financial_performance.sql` | Revenue, expenses and financial results    |
| `04_resource_allocation.sql`   | Spending intensity and benchmark analysis  |

### SQL Techniques

`GROUP BY` · `JOIN` · `CASE` · `CTE` · subqueries · `UNION ALL` · aggregations · `COUNT(DISTINCT)` · `NULLIF` · ratio calculations · conditional filtering

## Dashboard

The Power BI dashboard summarizes:

* Total revenue
* Total expenses
* Net financial result
* Expense per participant
* Financial results by sport
* Spending intensity by sport

The `.pbix` file is included for further exploration in Power BI Desktop.

## Data Source

**Equity in Athletics Disclosure Act (EADA), U.S. Department of Education — 2024–25 reporting year.**

The dataset contains institutional athletics financial, participation, and program information reported by participating U.S. colleges and universities.

## Tools

**Excel** — data preparation
**SQLite / DB Browser for SQLite** — data validation and analysis
**Power BI** — visualization and dashboard development
**GitHub** — version control and documentation

## Limitations

* The analysis covers a single 2024–25 reporting period and does not measure multi-year trends.
* Results depend on the completeness and accuracy of institutional reporting.
* Expense per participant measures spending intensity, not program quality or efficiency.
* Comparisons should be interpreted in the context of institutional size, NCAA classification, and sport mix.

## Repository Structure

```text
college-athletics-sql-analytics/
│
├── sql/
│   ├── 01_data_exploration.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_financial_performance.sql
│   └── 04_resource_allocation.sql
│
├── powerbi/
│   └── NCAA_Financial_Analytics.pbix
│
├── images/
│   └── Power BI Financial Analytics.png
│
├── data_dictionary.md
└── README.md
```

## Outcome

This project demonstrates an end-to-end analytical workflow: **data preparation → validation → SQL analysis → financial metrics → Power BI visualization**, with an emphasis on turning raw financial data into decision-relevant insights.

