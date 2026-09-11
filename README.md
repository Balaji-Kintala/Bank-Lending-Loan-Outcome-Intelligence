\# Dataset Information



\## Source



The dataset used in this project is the 2024 Home Mortgage Disclosure Act (HMDA) public loan-level mortgage application dataset.



Source: Consumer Financial Protection Bureau (CFPB) / Federal Financial Institutions Examination Council (FFIEC)



Official Data Browser:

https://ffiec.cfpb.gov/data-browser/data/



\## Dataset Selection



\- Data Year: 2024

\- Geography: Texas

\- Data Type: Public loan-level mortgage application data

\- Selected Loan Outcomes:

&#x20; - Loan Originated

&#x20; - Application Approved but Not Accepted

&#x20; - Application Denied



\## Dataset Size



Raw dataset:

\- 710,206 rows

\- 99 columns



Final analytical dataset:

\- 709,119 rows

\- 47 columns



\## Data Preparation



The raw dataset was processed using Python with Pandas and NumPy.



The cleaning process included:

\- Data type validation

\- Missing-value analysis

\- Duplicate detection and removal

\- Special-value handling

\- Outlier investigation

\- Data-quality flags

\- Analytical field creation



The cleaned analytical dataset was then loaded into MySQL for SQL analysis and used in Power BI for dashboard development.



\## Note



The raw CSV dataset is not included in this GitHub repository because of its large file size.



Users can obtain the source data from the official HMDA Data Browser using the selection criteria described above.

