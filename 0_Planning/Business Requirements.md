# 🛒 Retail Sales Case Study – Business Requirements & Tasks

##  Stakeholder Conversation Summary
During a meeting with the Sales Manager, they highlighted several concerns about company performance.  
They want a clear analysis of sales and profitability to support decision-making.  
Below is a list of requirements gathered from that discussion, along with the technical tasks to fulfill them.

---

## 1️⃣ Data Preparation Needs
**Stakeholder Need:**  
- Clean and organize the dataset.  
- Check for **missing values** or incorrect data types.  
- Ensure **dates** are in the correct format.  
- Create extra fields like **Order Year**, **Order Month**, and **Profit Margin**.  

**Execution Tasks:**  
- **SQL:** Convert date columns to `DATE`, extract Year/Month, handle NULLs.  
- **Python (Pandas):** Check `.isnull()`, fix data types, derive new features.  
- **Excel:** Use filters, data validation, and calculated columns.  

---

## 2️⃣ Sales Performance Insights
**Stakeholder Need:**  
- Identify **Top 10 best-selling products**.  
- Highlight **unprofitable products**.  
- Break down sales and profit by **Category** and **Sub-Category**.  

**Execution Tasks:**  
- **SQL:** `GROUP BY Product, Category, Sub-Category` → SUM(Sales), SUM(Profit).  
- **Python:** `groupby()` + sort values → Top 10 & Bottom 10 products.  
- **Tableau/Power BI:** Bar charts for Category/Sub-Category, ranked charts for Top 10.  

---

## 3️⃣ Customer & Segment Analysis
**Stakeholder Need:**  
- Compare **sales & profit across Customer Segments**.  
- Find which **segment is most valuable**.  

**Execution Tasks:**  
- **SQL:** `GROUP BY Customer Segment` → SUM(Sales), SUM(Profit).  
- **Python:** `groupby("Customer Segment")` → calculate Sales, Profit, Avg Order Value.  
- **Tableau/Power BI:** Comparison bar chart + pie chart of segment contribution.  

---

## 4️⃣ Regional & Market Insights
**Stakeholder Need:**  
- Identify **best and worst performing regions/states**.  
- Show results on a **map/heatmap**.  

**Execution Tasks:**  
- **SQL:** `GROUP BY Region, State` → SUM(Sales), SUM(Profit).  
- **Python:** Summary tables, Top 5 & Bottom 5 states, bar charts.  
- **Tableau/Power BI:** Map visualization (Profit by State), heatmap by Region.  

---

## 5️⃣ Trend & Seasonality Analysis
**Stakeholder Need:**  
- Show **monthly/quarterly sales trends**.  
- Identify **seasonal spikes**.  

**Execution Tasks:**  
- **SQL:** Extract `YEAR(Order Date)`, `MONTH(Order Date)` → aggregate monthly sales.  
- **Python:** Line plots & boxplots for sales over time.  
- **Tableau/Power BI:** Time series charts, calendar heatmaps, YoY growth.  

---

## 6️⃣ Discount & Profitability Concerns
**Stakeholder Need:**  
- Analyze how **discounts impact profit margins**.  
- Show if higher discounts drive sales or reduce profitability.  

**Execution Tasks:**  
- **SQL:** Aggregate by discount brackets → Avg Profit, Profit Margin.  
- **Python:** Scatter plot (Discount vs Profit Margin), correlation coefficient.  
- **Tableau/Power BI:** Scatter + boxplots showing relationship.  

---

## 7️⃣ Final Deliverables
**Stakeholder Need:**  
- Provide a **dashboard** and a **summary report**.  

**Execution Tasks:**  
- **Dashboard (Power BI/Tableau/Excel):**  
  - Sales & Profit by Category/Sub-Category  
  - Profit by Region (Map/Heatmap)  
  - Monthly Sales Trend (Line Chart)  
  - Top 10 Products (Bar Chart)  
  - Discount vs Profit Margin (Scatter Plot)  

- **Summary Report (Markdown/PDF):**  
  - Business problems identified  
  - Cleaning & preparation steps  
  - Analysis methods & tools used  
  - Key insights discovered  
  - Actionable recommendations for management  
  - Appendix: SQL queries, Python notebook snippets, dashboard screenshots/links  
