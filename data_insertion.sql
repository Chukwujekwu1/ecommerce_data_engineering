-- Now let's insert data into the table
/* The data would be inserted into the tables in an orderly manner
   because of the foreign key constraint
   PSQL would be used to insert the data into the PostgreSQL database*/

\COPY categories   FROM 'C:/Users/mchim/Downloads/ecommerce_dataset/categories.csv'    CSV HEADER;
\COPY suppliers    FROM 'C:/Users/mchim/Downloads/ecommerce_dataset/suppliers.csv'     CSV HEADER;
\COPY products     FROM 'C:/Users/mchim/Downloads/ecommerce_dataset/products.csv'      CSV HEADER;
\COPY customers    FROM 'C:/Users/mchim/Downloads/ecommerce_dataset/customers.csv'     CSV HEADER;
\COPY orders       FROM 'C:/Users/mchim/Downloads/ecommerce_dataset/orders.csv'        CSV HEADER;
\COPY order_items  FROM 'C:/Users/mchim/Downloads/ecommerce_dataset/order_items.csv'   CSV HEADER;
\COPY payments     FROM 'C:/Users/mchim/Downloads/ecommerce_dataset/payments.csv'      CSV HEADER;
\COPY invoices     FROM 'C:/Users/mchim/Downloads/ecommerce_dataset/invoices.csv'      CSV HEADER;
\COPY reviews      FROM 'C:/Users/mchim/Downloads/ecommerce_dataset/reviews.csv'       CSV HEADER;




-- Let's verify the row count of the inserted table 

SELECT 'categories' AS table_name, COUNT(*) AS row_count 
FROM categories
UNION ALL
SELECT 'suppliers', COUNT(*)
FROM suppliers
UNION ALL
SELECT 'products', COUNT(*)
FROM products
UNION ALL
SELECT 'customers', COUNT(*)
FROM customers
UNION ALL
SELECT 'orders', COUNT(*) 
FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) 
FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) 
FROM payments
UNION ALL
SELECT 'invoices', COUNT(*) 
FROM invoices
UNION ALL
SELECT 'reviews', COUNT(*)
FROM reviews
