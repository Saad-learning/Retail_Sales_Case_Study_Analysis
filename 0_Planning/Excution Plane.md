# 🛒 Retail Sales Case Study – Execution Plan

## 1️⃣ Data Preparation
**Stakeholder Need:**  
“Clean and organize the dataset. Fix missing values, incorrect types, and make sure we can analyze by year and month.”

 

##  Execution Plan  

1. **Load Data**  
   - Import dataset into Python using **Pandas**.  
   - Store a copy of the raw dataset for reference.  

2. **Handle Missing & Invalid Data**  
   - Check for missing values across all columns.  
   - Decide per column whether to **impute**, **replace**, or **remove** records.  
   - Fix incorrect product categories (typos, inconsistent labels).  
   - Replace missing customer names with `"Unknown"`.  

3. **Detect & Handle Outliers**  
   - Use **IQR (Interquartile Range)** or **Z-score** method to detect outliers in:  
     - `Sales`  
     - `Profit`  
     - `Discount`  
   - Decide whether to cap, transform, or flag them.  

4. **Fix Data Types**  
   - Convert `Order Date` and `Ship Date` to `datetime`.  
   - Ensure `Sales`, `Profit`, `Discount`, and `Quantity` are numeric.  
   - Standardize categorical columns (`Region`, `Category`, `Payment Method`, etc.).  

5. **Feature Engineering**  
   - Extract **Year** and **Month** from `Order Date`.  
   - Create **Profit Margin** = `Profit / Sales`.  
   - Recalculate `Total Sales` = `Quantity * Unit Price * (1 - Discount)`.  

6. **Validation**  
   - Confirm there are no duplicates.  
   - Check that cleaned data can be grouped and aggregated reliably.  
   - Ensure output dataset is consistent across **Excel**, **Python**, and **SQL** versions.  


---

## 2️⃣  Sales Performance Insights

##  Stakeholder Need  
“Tell us what’s selling well, what’s not, and how categories are performing.”

---

##  Execution Plan  

###  SQL  
- Aggregate **Total Sales** and **Quantity** by:  
  - Product  
  - Category  
  - Sub-Category  
- Include **average discount** and **return rate** (if available).  
- Identify products with **high sales but low margins** (if Profit exists or can be derived).  

---

###  Python (Pandas + Matplotlib)  
- Sort products by Sales → extract **Top 10 and Bottom 10** products.  
- Calculate **Category contribution %** to total sales.  
- Highlight **products with high sales but frequent returns**.  
- Plot **monthly sales trend** to detect seasonality.  

---

###  Tableau / Power BI  
- **Bar charts:** Sales by Category / Sub-Category.  
- **Ranked bar chart:** Top 10 products.  
- **Stacked bar or heatmap:** Sales by Region & Category.  
- **Line chart:** Sales trend by month.  
- **KPI Cards:**  
  - Total Sales  
  - Best-selling category  
  - Worst-performing category  
  - Return %  

---

##  Extra Insights to Add  
- **Pareto Analysis (80/20 Rule):** Identify if 20% of products contribute 80% of sales.  
- **Discount vs Sales Impact:** Measure if higher discounts are driving more sales or hurting margins.  
- **Returns Analysis:** Spot products/categories with high return rates.  
- **Regional Breakdown:** Find which categories perform better in certain regions.  


---

## 3️⃣  Customer & Segment Analysis

##  Stakeholder Need  
“Which customer segments are driving revenue and profit?”

---

##  Execution Plan  

### SQL  
- Group data by **Customer Segment**.  
- Calculate:  
  - Total Sales  
  - Total Profit (or estimated profit margin if Profit column not available).  
- Rank segments by contribution to total revenue.  
- (Optional) Break down by **Region + Segment** to see geographical differences.  

---

###  Python (Pandas)  
- Use `groupby("Customer Segment")` to calculate:  
  - Sum of Sales  
  - Sum of Profit  
  - Count of unique Customers  
- Compute **Average Order Value (AOV)** per segment.  
- Visualize with **bar charts** comparing Sales and Profit by Segment.  
- (Optional) Add **Year/Month breakdown** to check if segment performance is changing over time.  

---

###  Tableau / Power BI  
- **Bar Chart:** Sales & Profit by Customer Segment.  
- **Pie/Donut Chart:** Segment contribution to overall revenue.  
- **Stacked Bar Chart:** Sales by Region & Segment.  
- **KPI Cards:**  
  - Top Segment by Sales  
  - Top Segment by Profit  
  - Average Order Value (AOV) per Segment  

---

##  Extra Insights to Add  
- **Customer Lifetime Value (CLV) Proxy:** Estimate revenue per customer over time.  
- **Segment Growth Trend:** Which segment is growing fastest year-over-year?  
- **Profitability vs Sales Trade-Off:** Some segments may generate high sales but low margins.  
- **Churn Risk Indicator:** Segments with declining sales over time may signal retention issues.  
  

---

## 4️⃣  Regional & Market Insights

##  Stakeholder Need  
“Show us which regions and states are performing best and worst.”

---

##  Execution Plan  

###  SQL  
- Aggregate **Total Sales** and **Total Profit** by:  
  - Region  
  - State  
- Rank Regions and States by performance (highest → lowest).  
- Identify **loss-making states** (negative profit).  
- (Optional) Add Year/Month filter to analyze seasonal/regional trends.  

---

###  Python (Pandas)  
- Use `groupby(["Region"])` and `groupby(["State"])` to calculate:  
  - Sum of Sales  
  - Sum of Profit  
- Sort States by Profit → extract **Top 5 and Bottom 5 performers**.  
- Create **summary tables** for Region vs Sales & Profit.  
- Visualize using:  
  - Bar charts (Region vs Sales/Profit)  
  - Highlight loss-making states in red.  

---

###  Tableau / Power BI  
- **Map Visualization:** Profit by State (color-coded, e.g., green = profit, red = loss).  
- **Heatmap:** Sales & Profit by Region.  
- **Bar Chart:** Top 10 States by Sales.  
- **KPI Cards:**  
  - Best-performing Region  
  - Worst-performing Region  
  - Top State by Sales  
  - Bottom State by Profit  

---

##  Extra Insights to Add  
- **Regional Contribution %:** How much each region contributes to total sales.  
- **Profit Margin by Region:** Compare efficiency, not just revenue.  
- **Trend Analysis:** Detect if certain states/regions are improving or declining over time.  
- **Market Opportunity:** Identify underperforming but high-population states (potential growth markets).  


---

## 5️⃣  Trend & Seasonality Analysis

##  Stakeholder Need  
“Are sales growing? Do we have seasonal spikes?”

---

## Execution Plan  

###  SQL  
- Extract **YEAR(Order Date)** and **MONTH(Order Date)** from the dataset.  
- Group Sales by **Year-Month**.  
- Calculate:  
  - Total Sales per Month  
  - Average Monthly Growth Rate  
- (Optional) Compare **Year-over-Year (YoY)** performance.  

---

###  Python (Pandas + Matplotlib/Seaborn)  
- Convert `Order Date` to datetime if not already.  
- Create new columns:  
  - `Order_Year`  
  - `Order_Month`  
- Use `groupby(["Order_Year", "Order_Month"])` to summarize Sales.  
- Plot:  
  - **Line Chart** → Monthly Sales trend.  
  - **Boxplot** → Seasonal spikes by Month across years.  
- (Optional) Apply a **rolling average (3M/6M)** to smooth trends.  

---

###  Tableau / Power BI  
- **Time Series Line Chart:** Sales over time (Monthly / Quarterly).  
- **Seasonality Decomposition (Tableau):** Show recurring spikes by month.  
- **Heatmap Calendar:** Sales intensity by Month & Year.  
- **KPI Cards:**  
  - Highest Sales Month  
  - Lowest Sales Month  
  - Year-over-Year Growth %  

---

##  Extra Insights to Add  
- **Seasonality Patterns:** Identify peak sales months (e.g., holiday season).  
- **Growth Trend:** Is sales revenue consistently growing year-over-year?  
- **Forecasting Opportunity:** Use past seasonal trends to forecast future demand.  
- **Category-Level Seasonality:** Which product categories show the strongest seasonal spikes?  

---

## 6️⃣ # Discount & Profitability Concerns

##  Stakeholder Need  
“Are discounts hurting profit margins?”

---

##  Execution Plan  

###  SQL  
- Aggregate data by Discount levels (e.g., 0–10%, 10–20%, 20–30%, etc.).  
- Calculate:  
  - Average Profit  
  - Average Profit Margin = (Profit / Sales).  
- Correlate **Discount** with **Profit/Profit Margin** using window functions or grouped stats.  
- Identify ranges of discounts that lead to negative margins.  

---

###  Python (Pandas + Matplotlib/Seaborn)  
- Compute **Profit Margin = Profit / Sales**.  
- Create:  
  - **Scatter Plot** → Discount (X-axis) vs Profit Margin (Y-axis).  
  - **Trend Line / Regression Line** to see overall relationship.  
- Calculate **Correlation Coefficient** (`df["Discount"].corr(df["Profit_Margin"])`).  
- (Optional) Use **boxplots** to show how Profit Margin varies across discount brackets.  

---

###  Tableau / Power BI  
- **Scatter Plot:**  
  - X-axis → Discount  
  - Y-axis → Profit Margin  
  - Size → Sales  
- **Boxplot or Histogram:** Distribution of Profit Margin by Discount level.  
- **KPI Cards:**  
  - Optimal Discount Range (highest profitability)  
  - Discount Range with Losses  
  - Overall Correlation between Discount & Profit Margin  

---

##  Extra Insights to Add  
- **Threshold Detection:** At what discount % does profit turn negative?  
- **Category-Level Impact:** Are some categories more sensitive to discounting than others?  
- **Customer Behavior:** Do higher discounts drive more sales volume but lower profitability?  
- **Strategic Recommendation:** Suggest discount ranges that maximize both sales and profit.  


---

## 7️⃣ # Final Deliverables

##  Stakeholder Need  
“Give us a dashboard and a summary report with insights and recommendations.”

---

##  Execution Plan  

###  Dashboard (Tableau / Power BI / Excel)  
Include the following visual components:  
- **Sales & Profit by Category/Sub-Category** → Bar Chart.  
- **Profit by Region (Map)** → Geographic visualization to spot best/worst states.  
- **Monthly Sales Trend** → Line Chart showing growth and seasonality.  
- **Top 10 Products** → Ranked Bar Chart.  
- **Discount vs Profit Margin** → Scatter Plot to visualize discount impact.  

---

###  Report (Markdown / PDF)  
The report should contain:  
1. **Executive Summary** → Key findings in plain business language.  
2. **Business Problems & Stakeholder Needs** → What questions we aimed to answer.  
3. **Data Preparation** → Cleaning, transformations, and feature engineering.  
4. **Analysis & Methods** → SQL, Python, and BI approaches used.  
5. **Key Insights** →  
   - Best/Worst performing products & categories  
   - Regional breakdown  
   - Seasonal patterns  
   - Discount impact on profitability  
   - Customer segment contributions  
6. **Recommendations** → Data-driven actions for management.  
7. **Appendix** →  
   - SQL queries  
   - Python notebook snippets  
   - Dashboard screenshots or links  

---

##  Extra Suggestions  
- Provide an **interactive dashboard link** (Tableau Public / Power BI Service).  
- Highlight **3–5 key takeaways** in the executive summary for decision-makers.  
- Add a **next steps** section (e.g., forecasting, deeper customer analysis).  

