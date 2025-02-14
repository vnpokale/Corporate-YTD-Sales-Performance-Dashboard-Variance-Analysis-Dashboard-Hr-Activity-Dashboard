
-- Create Sales Data (Fact Table)
CREATE TABLE sales_data (
    order_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_date DATE NOT NULL,
    customer_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_sales DECIMAL(12,2) NOT NULL,
    discount DECIMAL(10,2),
    profit DECIMAL(12,2),
    region VARCHAR(50),
    sales_rep_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (sales_rep_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

-- Create Customers Table (Dimension Table)
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18),
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female')),
    city VARCHAR(100),
    country VARCHAR(100),
    email VARCHAR(150),
    phone VARCHAR(20),
    customer_segment VARCHAR(50) CHECK (customer_segment IN ('Retail', 'Wholesale', 'Corporate'))
);

-- Create Products Table (Dimension Table)
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    brand VARCHAR(100),
    supplier_id VARCHAR(10) NOT NULL,
    unit_cost DECIMAL(10,2),
    stock_quantity INT CHECK (stock_quantity >= 0),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE CASCADE
);

-- Create Suppliers Table
CREATE TABLE suppliers (
    supplier_id VARCHAR(10) PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(150),
    country VARCHAR(100)
);

-- Create Employees Table (Sales Representatives)
CREATE TABLE employees (
    employee_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age BETWEEN 18 AND 65),
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female')),
    department VARCHAR(50),
    job_role VARCHAR(50),
    salary DECIMAL(12,2),
    hire_date DATE,
    region VARCHAR(50)
);

-- Create Finance Transactions Table
CREATE TABLE transactions (
    transaction_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    transaction_date DATE NOT NULL,
    customer_id VARCHAR(10) NOT NULL,
    payment_method VARCHAR(50) CHECK (payment_method IN ('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Cash')),
    amount DECIMAL(12,2) NOT NULL,
    currency VARCHAR(10) CHECK (currency = 'USD'),
    status VARCHAR(20) CHECK (status IN ('Completed', 'Pending', 'Failed')),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- Create Inventory Management Table
CREATE TABLE inventory (
    product_id VARCHAR(10) PRIMARY KEY,
    warehouse_location VARCHAR(100),
    stock_level INT CHECK (stock_level >= 0),
    reorder_point INT CHECK (reorder_point >= 0),
    last_restock_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Create Marketing Campaigns Table
CREATE TABLE marketing_campaigns (
    campaign_id VARCHAR(10) PRIMARY KEY,
    campaign_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    budget DECIMAL(12,2),
    revenue_generated DECIMAL(12,2),
    roi DECIMAL(5,2)
);

-- Add Indexes for Performance Optimization
CREATE INDEX idx_sales_date ON sales_data(order_date);
CREATE INDEX idx_customer_name ON customers(name);
CREATE INDEX idx_product_name ON products(product_name);
CREATE INDEX idx_transaction_date ON transactions(transaction_date);
CREATE INDEX idx_employee_region ON employees(region);
