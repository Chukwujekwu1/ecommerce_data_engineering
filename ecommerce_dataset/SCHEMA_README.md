# E-Commerce Motor Parts Dataset — Schema Reference

**Total Records:** 2,541,996 rows across 9 tables  
**Date Range:** 2020-01-01 to 2024-12-31  
**Use Case:** OLAP, Data Modelling, Database Practice

---

## Entity Relationship Overview

```
categories ──< products >── order_items >── orders >── payments
                                                  └──> invoices
suppliers  (reference)      customers ──────────────────────^
                                  └──> reviews >── products
```

---

## Tables

### 1. `categories.csv` — 10 rows
| Column | Type | Description |
|--------|------|-------------|
| category_id | INT PK | Unique category ID |
| category_name | VARCHAR | Category name |

### 2. `products.csv` — 200 rows
| Column | Type | Description |
|--------|------|-------------|
| product_id | INT PK | Unique product ID |
| sku | VARCHAR | Stock Keeping Unit |
| product_name | VARCHAR | Full product name |
| category_id | INT FK | → categories.category_id |
| brand | VARCHAR | Brand name |
| unit_price | DECIMAL(10,2) | Selling price |
| cost_price | DECIMAL(10,2) | Cost of goods |
| stock_quantity | INT | Current inventory |
| weight_kg | DECIMAL(5,2) | Shipping weight |
| is_active | TINYINT | 1=active, 0=discontinued |
| created_at | DATETIME | Listing date |

### 3. `suppliers.csv` — 30 rows
| Column | Type | Description |
|--------|------|-------------|
| supplier_id | INT PK | Unique supplier ID |
| supplier_name | VARCHAR | Company name |
| contact_name | VARCHAR | Primary contact |
| email | VARCHAR | Contact email |
| phone | VARCHAR | Phone number |
| country | VARCHAR | Country of origin |
| city | VARCHAR | City |
| lead_time_days | INT | Average lead time |
| payment_terms | VARCHAR | Payment terms |
| created_at | DATETIME | Onboarding date |

### 4. `customers.csv` — 50,000 rows
| Column | Type | Description |
|--------|------|-------------|
| customer_id | INT PK | Unique customer ID |
| customer_type | VARCHAR | Individual/Workshop/Dealer/Fleet/Online Retailer |
| first_name | VARCHAR | First name |
| last_name | VARCHAR | Last name |
| email | VARCHAR UNIQUE | Email address |
| phone | VARCHAR | Phone number |
| date_of_birth | DATE | DOB |
| gender | CHAR(1) | M/F/Other |
| registration_date | DATETIME | Sign-up date |
| country | VARCHAR | Country |
| state | VARCHAR | State/Province |
| city | VARCHAR | City |
| postal_code | VARCHAR | Postal/ZIP code |
| address_line1 | VARCHAR | Street address |
| loyalty_tier | VARCHAR | Bronze/Silver/Gold/Platinum |
| total_lifetime_value | DECIMAL(12,2) | Sum of delivered orders |
| is_active | TINYINT | 1=active, 0=inactive |

### 5. `orders.csv` — 400,000 rows
| Column | Type | Description |
|--------|------|-------------|
| order_id | INT PK | Unique order ID |
| customer_id | INT FK | → customers.customer_id |
| order_date | DATETIME | Order placement time |
| status | VARCHAR | Pending/Processing/Shipped/Delivered/Cancelled/Refunded |
| payment_method | VARCHAR | Payment method used |
| shipping_method | VARCHAR | Shipping type |
| subtotal | DECIMAL(10,2) | Before discounts & tax |
| discount_amount | DECIMAL(10,2) | Order-level discount |
| tax_amount | DECIMAL(10,2) | Tax charged |
| shipping_cost | DECIMAL(10,2) | Shipping fee |
| total_amount | DECIMAL(10,2) | Final order total |
| shipping_address | VARCHAR | Delivery address |
| city | VARCHAR | Delivery city |
| state | VARCHAR | Delivery state |
| country | VARCHAR | Delivery country |
| postal_code | VARCHAR | Delivery postal code |
| notes | TEXT | Optional order notes |

### 6. `order_items.csv` — 1,011,756 rows
| Column | Type | Description |
|--------|------|-------------|
| order_item_id | INT PK | Unique line item ID |
| order_id | INT FK | → orders.order_id |
| product_id | INT FK | → products.product_id |
| quantity | INT | Units ordered |
| unit_price | DECIMAL(10,2) | Price at time of order |
| discount_pct | INT | Line-level discount % |
| line_total | DECIMAL(10,2) | qty × price × (1 - disc%) |

### 7. `payments.csv` — 400,000 rows
| Column | Type | Description |
|--------|------|-------------|
| payment_id | INT PK | Unique payment ID |
| order_id | INT FK | → orders.order_id |
| payment_date | DATETIME | Time payment processed |
| amount | DECIMAL(10,2) | Amount charged |
| payment_method | VARCHAR | Card/PayPal/etc. |
| payment_status | VARCHAR | Completed/Failed/Refunded |
| transaction_ref | UUID | Gateway transaction ID |
| gateway | VARCHAR | Payment processor |
| currency | CHAR(3) | ISO currency code |

### 8. `invoices.csv` — 400,000 rows
| Column | Type | Description |
|--------|------|-------------|
| invoice_id | INT PK | Unique invoice ID |
| order_id | INT FK | → orders.order_id |
| invoice_date | DATE | Invoice issue date |
| due_date | DATE | Payment due date |
| total_amount | DECIMAL(10,2) | Invoice total |
| paid_amount | DECIMAL(10,2) | Amount received |
| balance_due | DECIMAL(10,2) | Outstanding balance |
| invoice_status | VARCHAR | Paid/Partial/Overdue |
| notes | TEXT | Optional notes |

### 9. `reviews.csv` — 280,000 rows
| Column | Type | Description |
|--------|------|-------------|
| review_id | INT PK | Unique review ID |
| product_id | INT FK | → products.product_id |
| customer_id | INT FK | → customers.customer_id |
| order_id | INT FK | → orders.order_id |
| rating | TINYINT | 1–5 stars |
| review_title | VARCHAR | Short title |
| review_body | TEXT | Review text |
| review_date | DATETIME | Posted date |
| verified_purchase | TINYINT | 1=verified |
| helpful_votes | INT | Upvotes |
| is_approved | TINYINT | 1=published |

---

## Suggested OLAP Analyses
- **Sales cube:** time × category × country × customer_type
- **Revenue vs. Cost margin** per product/brand/category
- **Customer cohort analysis** by registration month
- **Order funnel** Pending → Delivered conversion rates
- **Review sentiment** by rating vs. product category
- **Payment failure rates** by gateway/currency
- **Repeat purchase rate** per loyalty tier
