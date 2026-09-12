Markdown
# NCAA Athletic Department Financial Analytics Dashboard

## Executive Summary
This project delivers an end-to-end financial analytics solution evaluating NCAA athletic department revenues, expenses, and unit economics across sports programs. By transforming raw Equity in Athletics Disclosure Act (EADA) reporting data into an executive Power BI dashboard, the analysis highlights operational surplus/deficit patterns and participant cost allocation across collegiate athletics.

---

## Business Problem & Key Objectives
Collegiate athletic departments manage complex financial structures where high-revenue sports often subsidize non-revenue programs. Key analytical goals include:
1. **Net Operating Performance:** Evaluating net surplus/deficit across major athletic programs (`Net_Result`).
2. **Unit Economics:** Determining capital allocation efficiency per student-athlete (`Cost_Per_Participant`).
3. **Executive Visibility:** Delivering high-level metrics for Total Revenue (**$20.85B**) and Total Expenses (**$19.24B**).

---

## Technical Challenges & Solutions
* **Issue 1: 1M+ Row Volume Glitch**
  * *Problem:* Excess blank formatting in Excel expanded the dataset to over 1,000,000 ghost rows, causing severe performance lagging in Power BI.
  * *Solution:* Re-imported the raw CSV, established clean table boundaries in Excel, and applied Power Query null-value filtering on key IDs (`unitid`) to reduce the dataset to the true ~18,000 valid records.
* **Issue 2: Zero-Value DAX Calculations**
  * *Problem:* Initial calculations for Net Result and Cost per Participant outputted `0` or duplicated dataset totals (~$1.6B) across every row.
  * *Solution:* Resolved underlying data type mismatches (text-to-numeric coercion) and replaced multi-row `SUMX` aggregations with direct row-context DAX formulas.

---

## DAX Data Model & Key Measures

### 1. Net Result (Surplus / Deficit)
```dax
Net_Result = schools_cleaned[TOTAL_REVENUE_ALL] - schools_cleaned[TOTAL_EXPENSE_ALL]
2. Cost per Participant
Code snippet
Cost_Per_Participant = DIVIDE(schools_cleaned[TOTAL_EXPENSE_ALL], schools_cleaned[TOTAL_PARTICIPANTS], 0)
Key Financial Insights
Revenue Concentration: Football and Basketball drive significant net operating surpluses, acting as primary revenue anchors for athletic departments.

Program Subsidization: Sports like Soccer, Baseball, and Track & Field routinely operate at a net loss, relying on cross-subsidization from major revenue programs.

Resource Allocation Efficiency: Evaluating unit economics via Cost_Per_Participant reveals distinct spending tiers per student-athlete across gender and sport classifications.

Dashboard Preview
Repository Structure
Plaintext
├── data/
│   └── schools_cleaned.csv         # Processed EADA Dataset
├── pbix/
│   └── NCAA_Financial_Analytics.pbix  # Power BI Dashboard File
├── assets/
│   └── dashboard_preview.png       # Dashboard Screenshot
└── README.md                       # Project Documentation
