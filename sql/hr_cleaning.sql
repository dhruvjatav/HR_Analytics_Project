-- HR Analytics Data Cleaning & Preprocessing
-- (Placeholder script for project completeness)

-- 1. View raw data
SELECT * FROM HR_Analytics_Data;

-- 2. Remove duplicate rows
DELETE FROM HR_Analytics_Data
WHERE EmployeeID IN (
    SELECT EmployeeID
    FROM (
        SELECT EmployeeID,
               ROW_NUMBER() OVER (PARTITION BY EmployeeID ORDER BY EmployeeID) AS rn
        FROM HR_Analytics_Data
    ) X
    WHERE rn > 1
);

-- 3. Check for null values
SELECT 
    SUM(CASE WHEN Age IS NULL THEN 1 END) AS Null_Age,
    SUM(CASE WHEN Gender IS NULL THEN 1 END) AS Null_Gender,
    SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 END) AS Null_MonthlyIncome
FROM HR_Analytics_Data;

-- 4. Remove rows with missing critical values (if any)
DELETE FROM HR_Analytics_Data
WHERE Age IS NULL OR Gender IS NULL;

-- 5. Final clean table
SELECT * FROM HR_Analytics_Data;
