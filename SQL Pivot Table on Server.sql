select * from (SELECT 
    EXTRACT(YEAR FROM smd.date) AS year,
    TO_CHAR(smd.date, 'Mon') AS month,
    r.region,
    SUM(CASE WHEN p.productcategory = 'Books' THEN smd.sales ELSE 0 END) AS Books,
    SUM(CASE WHEN p.productcategory = 'Clothing' THEN smd.sales ELSE 0 END) AS Clothing,
    SUM(CASE WHEN p.productcategory = 'Electronics' THEN smd.sales ELSE 0 END) AS Electronics,
    SUM(CASE WHEN p.productcategory = 'Health' THEN smd.sales ELSE 0 END) AS Health,
    SUM(CASE WHEN p.productcategory = 'Home & Kitchen' THEN smd.sales ELSE 0 END) AS "Home & Kitchen",
    SUM(CASE WHEN p.productcategory = 'Sports' THEN smd.sales ELSE 0 END) AS Sports,
    SUM(CASE WHEN p.productcategory = 'Toys' THEN smd.sales ELSE 0 END) AS Toys,
    SUM(smd.sales) AS "Grand Total"
FROM sales_monthly_data smd
JOIN sales_metrics sm ON sm.product_code = smd.product_code 
                      AND sm.region_id = smd.region_id
JOIN products p ON sm.product_code = p.product_code
JOIN regions r ON sm.region_id = r.region_id
GROUP BY year, month, r.region
ORDER BY year, month, r.region )as subquery
