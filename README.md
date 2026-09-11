\# 🏦 Bank Lending \& Loan Outcome Intelligence



An end-to-end data analytics project analyzing 2024 mortgage lending patterns and loan outcomes in Texas using public HMDA data.



!\[Dashboard](Images/dashboard.png)



\---



\## 📌 Project Overview



\### Major Problem



Banks need to understand lending patterns and differences in loan outcomes across borrowers, loan types, lenders, and regions.



\### Business Question



\*\*Which borrower, loan, and lender characteristics are associated with different loan outcomes?\*\*



This project provides a descriptive analysis of mortgage applications and identifies patterns across loan products, loan characteristics, property characteristics, occupancy types, and geographic areas.



\---



\## 📊 Dataset



\*\*Dataset:\*\* 2024 Home Mortgage Disclosure Act (HMDA) public loan-level mortgage application data



\*\*Source:\*\* Consumer Financial Protection Bureau (CFPB) / Federal Financial Institutions Examination Council (FFIEC)



\*\*Geography:\*\* Texas



\*\*Loan Outcomes Analyzed:\*\*



\- Originated

\- Approved but Not Accepted

\- Denied



\### Dataset Size



| Dataset | Rows | Columns |

|---|---:|---:|

| Raw Dataset | 710,206 | 99 |

| Final Analytical Dataset | 709,119 | 47 |



The raw dataset is not included in this repository because of its large file size.



Dataset information and source instructions are available in:



`data/README.md`



\---



\## 🛠️ Tools \& Technologies



\- \*\*Excel\*\* — Initial data inspection

\- \*\*Python\*\* — Data cleaning, transformation and exploratory analysis

\- \*\*Pandas\*\* — Data manipulation and data-quality analysis

\- \*\*NumPy\*\* — Numerical operations

\- \*\*MySQL\*\* — Structured data analysis and advanced SQL

\- \*\*Power BI\*\* — Interactive dashboard and visualization

\- \*\*Jupyter Notebook\*\* — Python development and documentation

\- \*\*Git/GitHub\*\* — Version control and project portfolio



\---



\## 🔄 Project Workflow



```text

Official HMDA Data

&#x20;       ↓

Excel Initial Inspection

&#x20;       ↓

Python / Pandas / NumPy

&#x20;       ↓

Data Cleaning \& Quality Checks

&#x20;       ↓

MySQL Analysis

&#x20;       ↓

Power BI Dashboard

&#x20;       ↓

Business Insights

&#x20;       ↓

Recommendations

```



\---



\## 🧹 Data Cleaning \& Preparation



Python with Pandas and NumPy was used to perform data-quality analysis and prepare the analytical dataset.



The process included:



\- Data type validation

\- Missing-value analysis

\- Duplicate detection and removal

\- Special-value handling

\- Invalid-value checks

\- Outlier investigation

\- Analytical helper fields

\- Data-quality flags

\- Loan outcome mapping



\### Data Quality



The raw dataset contained \*\*1,087 exact duplicate rows\*\*, which were removed after investigation.



Potential anomalies were investigated rather than blindly deleted.



Legitimate unusual observations were retained, while clearly defined project-level anomalies were excluded from specific analytical values where appropriate.



The final cleaned dataset contained:



\*\*709,119 records and 204 columns\*\*



The final analytical dataset contained:



\*\*709,119 records and 47 columns\*\*



\---



\## 🗄️ SQL Analysis



The cleaned analytical dataset was loaded into MySQL.



SQL analysis included:



\- Overall loan outcome distribution

\- Loan product analysis

\- Loan purpose analysis

\- DTI analysis

\- LTV analysis

\- Loan amount analysis

\- Income analysis

\- Occupancy analysis

\- Race-based descriptive analysis

\- County-level analysis

\- Interest-rate analysis

\- Data-quality validation



\### Advanced SQL Techniques



The project also used:



\- `GROUP BY`

\- `CASE`

\- Aggregate functions

\- Common Table Expressions (CTEs)

\- Window functions

\- `RANK()`

\- Conditional aggregation



\---



\## 📈 Power BI Dashboard



The Power BI dashboard provides an interactive view of Texas mortgage lending patterns.



\### KPI Cards



\- \*\*Total Applications:\*\* 709.1K

\- \*\*Originated Applications:\*\* 494.1K

\- \*\*Denied Applications:\*\* 184.0K

\- \*\*Origination Rate:\*\* 69.67%



\### Interactive Filters



\- Loan Purpose

\- Occupancy Type

\- Loan Product



\### Visualizations



1\. Average Loan Amount by Loan Product

2\. Loan Outcome Mix by Product

3\. Application Mix by Occupancy Type

4\. Loan Amount vs Property Value

5\. Loan Application Volume by Purpose

6\. Denial Rate by DTI Range



\---



\## 🔎 Key Findings



\### Overall Outcomes



Out of \*\*709,119 applications\*\*:



\- \*\*69.67%\*\* were originated

\- \*\*25.95%\*\* were denied

\- \*\*4.37%\*\* were approved but not accepted



\### Loan Product



VA First Lien applications had an \*\*84.01% origination rate\*\*, followed by FHA First Lien at \*\*83.06%\*\*.



Conventional First Lien had a \*\*68.90% origination rate\*\*.



Conventional Subordinate Lien showed a more balanced outcome, with approximately \*\*48.20% originated\*\* and \*\*48.32% denied\*\*.



\### Loan Characteristics



The analysis identified differences in loan outcomes across:



\- Loan-to-value ranges

\- Loan amount ranges

\- Debt-to-income ranges

\- Interest-rate ranges

\- Occupancy types

\- Geographic areas



For example, applications with LTV below 60% had a \*\*63.23% origination rate\*\*, while the 90–100% range had an \*\*81.89% origination rate\*\* in this dataset.



\---



\## 💡 Business Recommendations



Based on the descriptive analysis:



\### 1. Segment lending performance by loan product



Different products show substantially different outcome patterns and should be monitored separately.



\### 2. Investigate unusual product-level patterns



Products with relatively high denial rates can be examined further to understand the underlying application mix.



\### 3. Monitor key loan characteristics



LTV, DTI, loan amount, income, and interest rate can be used as monitoring dimensions for portfolio analysis.



\### 4. Use geographic analysis for planning



County-level differences can help identify areas requiring deeper investigation or additional lending analysis.



\### 5. Strengthen data-quality monitoring



Automated checks for missing, special, and anomalous values can improve the reliability of future lending analytics.



\---



\## ⚠️ Analytical Limitations



This project is a \*\*descriptive analysis\*\* of public HMDA mortgage application data.



\- Associations identified in the analysis do not establish causal relationships.

\- HMDA data should not be interpreted as an individual credit-decision model.

\- Unusual observations may represent legitimate lending activity and therefore were investigated before exclusion.

\- The analysis is based on the 2024 Texas dataset and does not represent all years or all geographic areas.

\- Findings should be interpreted within the scope and definitions of the HMDA dataset.



\---



\## 📁 Repository Structure



```text

Bank-Lending-Loan-Outcome-Intelligence/

│

├── Bank\_Lending\_Analysis.ipynb

│

├── SQL/

│   └── bank\_lending\_analysis.sql

│

├── PowerBI/

│   └── Bank\_Lending\_Dashboard.pbix

│

├── Images/

│   └── dashboard.png

│

├── data/

│   └── README.md

│

└── README.md

```



\---



\## 🎯 Project Outcome



This project demonstrates an end-to-end data analyst workflow:



\*\*Data Collection → Data Quality → Cleaning → Transformation → SQL Analysis → Visualization → Insights → Business Recommendations\*\*



It combines Python, SQL, Excel, and Power BI to transform a large public dataset into an interactive business intelligence solution.



\---



\## 📚 Data Source



\*\*Consumer Financial Protection Bureau (CFPB) / Federal Financial Institutions Examination Council (FFIEC)\*\*



Official HMDA Data Browser:



https://ffiec.cfpb.gov/data-browser/data/



\---



\## 👤 Author



\*\*Balaji Kintala\*\*



Data Analyst | Python | SQL | Power BI | Excel
