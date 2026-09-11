# U.S. College Athletics Financial Analytics

An end-to-end financial analysis evaluating operating margins, unit economics, and resource allocation across 18,000+ varsity athletic programs using **Excel**, **SQL**, and **Power BI**.

---

## Executive Summary
College athletic departments operate under non-profit educational frameworks where high-revenue sports (Football and Men's Basketball) cross-subsidize non-revenue Olympic varsity programs. This project analyzes U.S. Department of Education EADA data to evaluate program net surpluses, per-participant unit economics, and gender resource allocation.

---

## Technical Stack & Analytics Pipeline
$$\text{Excel (Data Cleaning)} \longrightarrow \text{SQLite (SQL Queries)} \longrightarrow \text{Power BI (Visualizations)}$$

* **Data Cleaning & Prep (Excel):** Missing value audit, schema header mapping, and integer type casting.
* **Database Querying (SQLite):** Aggregations, Window Functions, CTEs, and conditional logic.
* **Business Intelligence (Power BI):** Interactive visualizations highlighting revenue engines and gender spending gaps.

---

## Data Preparation & Methodology

### Dataset Scope
* **Source:** U.S. Department of Education Equity in Athletics Disclosure Act (EADA).
* **Granularity:** Institution and sport-level financial records.
* **Scale:** 18,045 records across 2,037 higher education institutions.

### Data Validation & Cleaning Steps
1. **Duplicate Checks:** Audited `unitid` primary keys to ensure zero double-counting of institutions.
2. **Null Value Handling:** Filtered out records missing division classifications (`WHERE classification_name IS NOT NULL`).
3. **Zero-Division Safeguards:** Applied `NULLIF(TOTAL_PARTICIPANTS, 0)` across all unit-cost calculations to prevent runtime math errors.
4. **Integer Truncation Fixes:** Forced floating-point division using `* 1.0` in SQLite to ensure accurate decimal precision for average costs and surplus percentages.

---

## Core Analytical Questions
1. **Financial Performance:** Which sports drive the net operating surplus of college athletics nationwide?
2. **Unit Economics:** Which sports cost the most on a per-participant basis?
3. **Gender Resource Allocation:** How does per-athlete spending compare across Men's and Women's sports programs?
4. **Outlier Benchmarking:** Which individual programs spend >2x the national benchmark average per participant?

---

## Key Findings & Data Outputs

### 1. Macro Revenue Engines (Aggregate Surplus vs. Deficit)
Football and Basketball drive virtually all net surplus nationwide, subsidizing non-revenue sports operating at baseline deficits.

| Sport | Total Revenue | Total Expenses | Net Operating Result |
| :--- | :--- | :--- | :--- |
| **Football** | $7,992,308,214 | $5,842,109,332 | **+$2,150,198,882 (Surplus)** |
| **Basketball** | $2,410,851,102 | $1,983,412,091 | **+$427,439,011 (Surplus)** |
| **Baseball** | $398,201,110 | $412,804,115 | **-$14,603,005 (Deficit)** |
| **Track & Field** | $285,102,400 | $310,402,110 | **-$25,299,710 (Deficit)** |
| **Soccer** | $260,110,890 | $288,901,450 | **-$28,790,560 (Deficit)** |

### 2. Unit Economics (Expense per Participant)
While Football spends the most overall, Basketball and Ice Hockey exhibit higher per-athlete unit costs due to smaller roster sizes coupled with high travel and facility overhead.

| Sport | Total Participants | Total Expenses | Expense per Participant |
| :--- | :--- | :--- | :--- |
| **Football** | 89,410 | $5,842,109,332 | **$65,339.55** |
| **Basketball** | 31,358 | $1,983,412,091 | **$63,252.02** |
| **Ice Hockey** | 4,120 | $185,400,210 | **$45,000.05** |

### 3. Gender Spending Disparities
Across all higher education institutions, Men's programs receive **36.0% more funding per participant** than Women's programs, heavily influenced by Division I Football investments.

| Gender Category | Total Participants | Total Expense | Expense per Participant |
| :--- | :--- | :--- | :--- |
| **Men's Teams** | 443,453 | $12,535,046,571 | **$28,266.91** |
| **Women's Teams** | 322,383 | $6,700,441,103 | **$20,784.10** |

### 4. Outlier Program Benchmarking
St. John's University (NY) Basketball spends **$1,432,730.04 per participant**—22.65x the national sport benchmark ($63,252.02)—reflecting a concentrated financial strategy to maintain high-major national competitiveness.

---

## Grounded Business Recommendations

1. **Establish Tiered Peer Benchmarking:** Athletic directors should benchmark program expenses against specific peer groups (e.g., D1 Non-Football High-Major) rather than broad national averages to monitor recruiting and travel overhead.
2. **Stress-Test Non-Revenue Sports Budgets:** Because non-revenue sports depend on cross-subsidization, institutional planners must model how potential football revenue fluctuations could impact overall athletic department stability.
3. **Audit Non-Football Gender Equity:** Financial analysts should evaluate gender funding equity on a non-football basis to ensure compliant operational support for women's Olympic sports under Title IX frameworks.

---

## How to Reproduce This Project
1. Clone this repository: `git clone https://github.com/MartinWaiguru/college-athletics-sql-analytics.git`
2. Open `DB Browser for SQLite` and import `EADA_Cleaned.csv`.
3. Execute SQL scripts `01_data_exploration.sql` through `04_resource_allocation.sql`.
4. Open `Athletics_Financial_Report.pbix` in Power BI to view the dashboard visuals.
