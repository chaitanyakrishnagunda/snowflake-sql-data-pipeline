-- Tasty Bytes Sample Data Setup Script
-- Author: Chaitanya Krishna Gunda
-- Description: This SQL script sets up a sample database, schema, table, and runs analytical queries in Snowflake.

-- Step 1: Set the Role
USE ROLE accountadmin;

-- Step 2: Set the Warehouse
USE WAREHOUSE compute_wh;

-- Step 3: Create the Tasty Bytes Database
CREATE OR REPLACE DATABASE tasty_bytes_sample_data;

-- Step 4: Create the Raw POS (Point-of-Sale) Schema
CREATE OR REPLACE SCHEMA tasty_bytes_sample_data.raw_pos;

-- Step 5: Create the Raw Menu Table
CREATE OR REPLACE TABLE tasty_bytes_sample_data.raw_pos.menu
(
    menu_id NUMBER(19,0),
    menu_type_id NUMBER(38,0),
    menu_type VARCHAR(16777216),
    truck_brand_name VARCHAR(16777216),
    menu_item_id NUMBER(38,0),
    menu_item_name VARCHAR(16777216),
    item_category VARCHAR(16777216),
    item_subcategory VARCHAR(16777216),
    cost_of_goods_usd NUMBER(38,4),
    sale_price_usd NUMBER(38,4),
    menu_item_health_metrics_obj VARIANT
);

-- Step 6: Create a Stage referencing the S3 Blob location and CSV File Format
CREATE OR REPLACE STAGE tasty_bytes_sample_data.public.blob_stage
URL = 's3://sfquickstarts/tastybytes/'
FILE_FORMAT = (TYPE = CSV);

-- Step 7: Query the Stage to verify the file path
LIST @tasty_bytes_sample_data.public.blob_stage/raw_pos/menu/;

-- Step 8: Copy the Menu CSV file into the Menu table
COPY INTO tasty_bytes_sample_data.raw_pos.menu
FROM @tasty_bytes_sample_data.public.blob_stage/raw_pos/menu/;

-- Step 9: Verify row count
SELECT COUNT(*) AS row_count FROM tasty_bytes_sample_data.raw_pos.menu;

-- Step 10: Display top 10 records
SELECT TOP 10 * FROM tasty_bytes_sample_data.raw_pos.menu;

-- Step 11: Get count of menu items by truck brand
SELECT TRUCK_BRAND_NAME, COUNT(*)
FROM tasty_bytes_sample_data.raw_pos.menu
GROUP BY 1
ORDER BY 2 DESC;

-- Step 12: Get count of menu items by truck brand and menu type
SELECT
    TRUCK_BRAND_NAME,
    MENU_TYPE,
    COUNT(*)
FROM tasty_bytes_sample_data.raw_pos.menu
GROUP BY 1,2
ORDER BY 3 DESC;

-- Step 13: Count items with category 'Snack' and subcategory 'Warm Option'
SELECT COUNT(*) AS snack_warm_option
FROM tasty_bytes_sample_data.raw_pos.menu
WHERE item_category = 'Snack'
  AND item_subcategory = 'Warm Option';

-- Step 14: Find max sale price for each subcategory (Hot, Cold, Warm)
SELECT 
    item_subcategory,
    MAX(sale_price_usd) AS max_sale_price
FROM tasty_bytes_sample_data.raw_pos.menu
WHERE item_subcategory IN ('Hot Option', 'Cold Option', 'Warm Option')
GROUP BY 1
ORDER BY 2 DESC;
