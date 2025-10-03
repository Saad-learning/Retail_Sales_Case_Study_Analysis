----------- Data Cleaning and Preparation -----------
-- Remove duplicates
WITH cte AS (
    SELECT *
    , ROW_NUMBER() OVER (PARTITION BY Order_ID, Customer_ID, Product_Name ORDER BY Order_Date) AS rn
    FROM
        dbo.retail_sales
)
DELETE FROM cte WHERE rn > 1;

-- Fix Product_Category typos and missning values ---

UPDATE
    dbo.retail_sales
SET
    Product_Category = 
        CASE 
            WHEN Product_Category IN ('Electrnics', 'Electronics ', 'electrnics') THEN 'Electronics'
            WHEN Product_Category IN ('Furnitre') THEN 'Furniture'
            WHEN Product_Category IS NULL OR Product_Category = '' THEN 'Other'
            ELSE Product_Category
        END;

-- Replace missing Customer_Name ---
UPDATE
    dbo.retail_sales
SET
    Customer_Name = 'Unknown'
WHERE
    Customer_Name IS NULL OR Customer_Name = '';

-- Clean Unit_Price ---
UPDATE
    dbo.retail_sales
SET
    Unit_Price = 
        REPLACE(REPLACE(Unit_Price, '$', ''), '£', '')
WHERE
    Unit_Price LIKE '%$%' OR Unit_Price LIKE '%£%';


-- Convert Unit_Price to numeric ---

SELECT DISTINCT Unit_Price
FROM dbo.retail_sales
WHERE TRY_CAST(Unit_Price AS FLOAT) IS NULL 
      AND Unit_Price IS NOT NULL;

DELETE FROM dbo.retail_sales
WHERE TRY_CAST(Unit_Price AS FLOAT) IS NULL;

ALTER TABLE
    retail_sales
ALTER COLUMN 
    Unit_Price FLOAT;

-- Remove rows with missing Unit_Price ---
DELETE FROM
    dbo.retail_sales
WHERE
    Unit_Price IS NULL;

-- Fix Dates ---
ALTER TABLE 
    dbo.retail_sales
ALTER COLUMN
    Order_Date DATE;

-- Handle negative sales ---
ALTER TABLE dbo.retail_sales
ALTER COLUMN Quantity INT;

UPDATE
    dbo.retail_sales
SET
    Total_Sales = ABS(Total_Sales);

-- Replace Total_Sales --
UPDATE
    dbo.retail_sales
SET
    Total_Sales = Quantity * Unit_Price * (1 - Discount);


-- Outliers for Total_Sales

ALTER TABLE dbo.retail_sales
ALTER COLUMN Total_Sales FLOAT;

-- Recalculate Total_Sales
ALTER TABLE dbo.retail_sales
ADD Discount_clean FLOAT;

-- Handle outliers
WITH stats AS (
  SELECT 
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Total_Sales) OVER() AS Q1
    ,PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Total_Sales) OVER() AS Q3
  FROM dbo.retail_sales
),
limits AS (
  SELECT 
    TOP 1 
    Q1
    ,Q3
    ,(Q3 - Q1) AS IQR
    ,(Q1 - 1.5*(Q3-Q1)) AS lower
    ,(Q3 + 1.5*(Q3-Q1)) AS upper
  FROM 
    stats
)
UPDATE rs
SET 
    rs.Total_Sales = CASE 
        WHEN rs.Total_Sales < l.lower THEN l.lower
        WHEN rs.Total_Sales > l.upper THEN l.upper
        ELSE rs.Total_Sales
    END
FROM 
    dbo.retail_sales rs
CROSS JOIN 
    limits l;



-- New features: Year, Month
ALTER TABLE 
    retail_sales 
ADD 
    Order_Year INT;
ALTER TABLE 
    retail_sales 
ADD 
    Order_Month INT;
UPDATE 
    retail_sales
SET 
    Order_Year = YEAR(Order_Date)
    ,Order_Month = MONTH(Order_Date);

-- Recalculate Total_Sales
UPDATE 
    retail_sales
SET 
    Total_Sales = Quantity * Unit_Price * (1 - Discount_clean);

