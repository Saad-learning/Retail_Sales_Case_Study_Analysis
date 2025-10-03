# 🛒 Retail Sales Case Study – Report

---

## 1. Executive Summary  
We analyzed retail sales data to identify performance drivers, customer behavior, and profitability concerns.  
Key findings include:  
- **Technology** is the most profitable category, while **Furniture** underperformed.  
- **West Region** leads in sales, while **South** struggles with profitability.  
- **Seasonality:** Sales peak in **November–December**, showing strong holiday demand.  
- **Discounts:** Higher discounts are negatively correlated with profit margin.  
- **Customer Segments:** Technology-driven customer groups yield higher profitability.  

---

## 2. Business Problems & Stakeholder Needs  
The Sales Manager requested insights to guide strategy:  
- Which **products/categories** drive or reduce profitability?  
- How do **regions/markets** differ in performance?  
- Which **customer segments** contribute most to sales and profit?  
- What **seasonality trends** affect demand?  
- How do **discount strategies** impact profitability?  

---

## 3. Data Preparation  
- **Source:** Retail Orders dataset  
- **Cleaning & Transformation:**  
  - Removed duplicates and null values.  
  - Standardized dates → created `Order_Year` & `Order_Month`.  
  - Engineered metrics:  
    - `Total_Profit = SUM(Sales - Cost)`  
    - `Profit_Margin = Total_Profit / Total_Sales`  
  - Created **Year-Month** field for time-series trend analysis.  

---

## 4. Analysis & Methods  
- **SQL:** Used to group by Category, Region, Segment, and Time.  
- **Python:** Calculated correlations, profit margin, and trends.  
- **BI Tools (Power BI / Tableau):** Built dashboards for visual insights.  

Key queries and calculations included:  
- Sales & Profit by Category/Sub-Category  
- Segment contribution to Sales & Profit  
- Regional breakdown  
- Time-series trend analysis  
- Discount vs Profitability correlation  

---

## 5. Key Insights  

- **Products & Categories**  
  - Technology → Highest profitability.  
  - Furniture → Lower profitability despite sales volume.  
  - Top 10 products → Contribute disproportionately to total revenue.  

- **Regional Breakdown**  
  - West & East regions → Strongest performers.  
  - South region → Weakest margins, requires strategy change.  

- **Seasonal Patterns**  
  - Clear Q4 spike (Nov–Dec) → Holiday-driven demand.  

- **Discounts & Profitability**  
  - Strong **negative correlation**: higher discounts reduce profit margins.  

- **Customer Segments**  
  - Technology segment → Most profitable.  
  - Consumer segment → Largest by sales volume.  

---

## 6. Recommendations  
1. **Reassess discounting strategy** → Reduce deep discounts in low-margin categories.  
2. **Focus on Technology growth** → Expand offerings and marketing in this segment.  
3. **Fix South region performance** → Pricing adjustments and cost control measures.  
4. **Prepare for Q4 peaks** → Optimize inventory and marketing campaigns before November.  
5. **Leverage top products** → Use successful SKUs as models for assortment expansion.  

---

## 7. Appendix  

### SQL Queries    
```sql
-- Sales & Profit by Segment
SELECT 
    Customer_Segment,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Customer_Segment;

-- Regional Performance
SELECT 
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Region;
```
### Python Snippets
```python
# Profit Margin Calculation
df["Profit_Margin"] = df["Total_Profit"] / df["Total_Sales"]

# Correlation between Sales & Profit Margin
correlation = df["Total_Sales"].corr(df["Profit_Margin"])
print("Correlation:", correlation)
```