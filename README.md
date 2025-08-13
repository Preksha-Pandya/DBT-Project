# European Fashion Retail Analytics – dbt Project

## 📌 Project Overview
This project demonstrates a complete **data transformation pipeline** for a European fashion retail company using **dbt (Data Build Tool)**.  
The dataset, sourced from Kaggle, includes **transactional, customer, product, campaign, channel, and stock data**.  
Our goal: **Transform raw data into actionable insights** for analytics and BI dashboards.

The pipeline uses **Snowflake** for data warehousing, with dbt handling transformations, testing, documentation, and lineage tracking.

---

## 📂 Project Structure

### **Raw Layer**
- Stored in Snowflake’s `raw` database.
- Direct ingestion from CSV files without transformations.

### **Final Layer**
- Stored in `final.final_schema`.
- dbt models materialized as **tables** or **incremental tables**.

### **dbt Folder Structure**
```
staging/       → Base cleaned models from raw sources
intermediate/  → Enriched, business logic models
marts/         → Final analytics-ready models for BI
snapshots/     → Historical tracking of dimensional changes
tests/         → Data quality checks (YAML + custom tests)
exposures/     → BI dashboard dependencies
macros/        → Reusable Jinja macros
```

---

## 📑 Schema & Table Descriptions

### **1. campaigns**
Stores marketing campaign details:  
`campaign_id`, `campaign_name`, `start_date`, `end_date`, `channel`, `discount_type`, `discount_value`.

### **2. channels**
Sales channels information:  
`channel` (e.g., Online, Mobile App, In-Store), `description`.

### **3. customers**
Customer demographics and signup data:  
`customer_id`, `country`, `age_range`, `signup_date`.

### **4. products**
Product master data:  
`product_id`, `product_name`, `brand`, `category`, `color`, `size`, `gender`, `catalog_price`, `cost_price`.

### **5. sales**
Transaction-level purchase summary:  
`sale_id`, `channel`, `discounted`, `total_amount`, `sale_date`, `customer_id`, `country`.

### **6. salesitems**
Item-level breakdown of each transaction:  
`item_id`, `sale_id`, `product_id`, `quantity`, `unit_price`, `discount_applied`, `discount_percent`, `discounted`, `item_total`, `sale_date`, `channel`.

### **7. stock**
Inventory levels by product and country:  
`country`, `product_id`, `stock_quantity`.

---

## 🛠 dbt Architecture

### **Staging Models**
-Contains as it is source data.
- Apply tests: **primary key**, **foreign key**, **not null**.

### **Intermediate Models**
- `clean_campaigns` → Did some cleansing in the campaigns data.
- `clean_products` → Did some cleansing in the products data.
- `clean_salesitems` →Did some cleansing in the salesitems data.
- `int_sales_data` → Combines sales, items, products, customers, campaigns, and channels.
- `int_campaign_sales` → Filters sales within campaign periods.
- `int_customer_orders` → Aggregates customer order history.
- `int_product_inventory` → Joins product and stock data.
- `int_channel_performance` → Aggregates sales per channel.
- `int_product_sales` → Aggregates sales per product.

### **Mart Models**
- `mrt_customer_lifetime_value` → Customer spend, avg order value.
- `mrt_campaign_performance` → Campaign-level revenue and orders.
- `mrt_channel_revenue` → Channel-level sales performance.
- `mrt_inventory_stock` → Stock health (low-stock detection).
- `mrt_product_performance` → Best-selling and stagnant products.
- `mrt_customer_rfm` → RFM (Recency, Frequency, Monetary) segmentation.
- `mrt_daily_sales_summary` → Day-wise sales trends.

### **Snapshots**
- Track Slowly Changing Dimensions (SCD Type 2) for:
  - `products_snapshots`
  - `customers_snapshots`
  - `stock_snapshots`

### **Tests**
- Primary Key / Unique constraints.
- Foreign Key relationships.
- Not Null checks.
- Custom macros (e.g., `profit_margin()`).

### **Exposures**
- Link mart models to **Power BI dashboards**:
  - `daily_sales_dashboard`
  - `customer_dashboard`
  - `marketing_performance_dashboard`
  - `products_dashboard`
  - `inventory_stock_dashboard`

---

## 📊 Use Cases & Insights
- **Sales Dashboards**: Breakdown by country, channel, category, and brand.
- **KPI Calculations**: Average ticket, profit margin, turnover rate.
- **Campaign Analysis**: Impact on revenue & volume.
- **Stock Simulations**: Stockout detection and financial loss estimation.
- **Channel Performance**: Mobile App vs E-commerce.
- **Customer Segmentation**: RFM and churn detection.
- **Product Analysis**: High vs stagnant turnover products.

---

## 🚀 How to Run
1. **Install dbt** and connect to Snowflake.
2. Place raw CSVs into Snowflake `raw` schema.
3. Run transformations:
   ```bash
   dbt run
   ```
4. Run tests:
   ```bash
   dbt test
   ```
5. Build snapshots:
   ```bash
   dbt snapshot
   ```
6. View documentation:
   ```bash
   dbt docs generate && dbt docs serve
   ```

---

## 📈 BI Integration
All marts are exposed for Power BI, enabling **interactive dashboards** for:
- Sales Trends
- Campaign Effectiveness
- Inventory Health
- Customer Lifetime Value
