PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE customers(customer_id INTEGER PRIMARY KEY, customer_name TEXT NOT NULL, email TEXT, city TEXT, signup_date TEXT);
INSERT INTO customers VALUES(1,'Asha Mehta','asha@example.com','Pune','2021-02-15');
INSERT INTO customers VALUES(2,'Rahul Sharma','rahul@example.com','Mumbai','2020-11-20');
INSERT INTO customers VALUES(3,'Simran Kaur','simran@example.com','Delhi','2022-01-05');
INSERT INTO customers VALUES(4,'Vikram Singh','vikram@example.com','Bengaluru','2019-06-10');
INSERT INTO customers VALUES(5,'Nisha Patel','nisha@example.com','Ahmedabad','2021-09-30');
INSERT INTO customers VALUES(6,'Karan Verma','karan@example.com','Chennai','2020-03-22');
INSERT INTO customers VALUES(7,'Priya Rao','priya@example.com','Hyderabad','2022-05-11');
INSERT INTO customers VALUES(8,'Manish Gupta','manish@example.com','Pune','2021-12-01');
INSERT INTO customers VALUES(9,'Leena Joshi','leena@example.com',NULL,'2020-07-07');
INSERT INTO customers VALUES(10,'Suresh Nair','suresh@example.com','Kochi','2018-10-18');
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT,
    unit_price NUMERIC
);
INSERT INTO products VALUES(101,'Wireless Mouse','Accessories',599);
INSERT INTO products VALUES(102,'Mechanical Keyboard','Accessories',2499);
INSERT INTO products VALUES(103,'27-inch Monitor','Display',12999);
INSERT INTO products VALUES(104,'USB-C Adapter','Accessories',499);
INSERT INTO products VALUES(105,'Laptop 14-inch','Computers',54999);
INSERT INTO products VALUES(106,'External SSD 1TB','Storage',7999);
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price NUMERIC,
    order_date TEXT,
    status TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO orders VALUES(1001,1,101,1,599,'2022-01-10','delivered');
INSERT INTO orders VALUES(1002,2,102,1,2499,'2022-02-15','delivered');
INSERT INTO orders VALUES(1003,3,104,2,499,'2022-03-05','delivered');
INSERT INTO orders VALUES(1005,4,105,1,54999,'2022-04-02','delivered');
INSERT INTO orders VALUES(1006,5,101,2,599,'2022-04-18','delivered');
INSERT INTO orders VALUES(1007,6,106,1,7999,'2022-05-06','delivered');
INSERT INTO orders VALUES(1008,7,102,1,2499,'2022-05-25','delivered');
INSERT INTO orders VALUES(1009,8,104,3,499,'2022-06-10','delivered');
INSERT INTO orders VALUES(1010,9,101,1,599,'2022-06-21','returned');
INSERT INTO orders VALUES(1011,10,105,1,54999,'2022-07-02','delivered');
INSERT INTO orders VALUES(1012,2,106,2,7999,'2022-07-18','delivered');
INSERT INTO orders VALUES(1013,3,101,4,599,'2022-08-05','delivered');
INSERT INTO orders VALUES(1014,4,104,1,499,'2022-08-20','delivered');
INSERT INTO orders VALUES(1015,5,102,1,2499,'2022-09-01','pending');
INSERT INTO orders VALUES(1016,6,103,1,12999,'2022-09-15','delivered');
INSERT INTO orders VALUES(1017,7,105,1,54999,'2022-10-03','delivered');
INSERT INTO orders VALUES(1018,8,106,1,7999,'2022-10-25','pending');
INSERT INTO orders VALUES(1019,9,101,2,599,'2022-11-11','delivered');
INSERT INTO orders VALUES(1020,10,104,5,499,'2022-11-29','delivered');
INSERT INTO orders VALUES(1021,1,102,1,2499,'2022-12-05','delivered');
INSERT INTO orders VALUES(1022,2,101,3,599,'2022-12-20','delivered');
INSERT INTO orders VALUES(1100,3,106,1,7999,'2023-01-05','pending');
CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    paid_amount NUMERIC,
    payment_date TEXT,
    payment_method TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
INSERT INTO payments VALUES(5001,1001,599,'2022-01-11 10:10:00','card');
INSERT INTO payments VALUES(5002,1002,2499,'2022-02-16 11:15:00','card');
INSERT INTO payments VALUES(5003,1005,54999,'2022-04-03 09:05:00','bank_transfer');
INSERT INTO payments VALUES(5004,1007,7999,'2022-05-07 14:00:00','card');
INSERT INTO payments VALUES(5005,1011,54999,'2022-07-03 12:20:00','bank_transfer');
INSERT INTO payments VALUES(5006,1012,15998,'2022-07-19 16:45:00','card');
INSERT INTO payments VALUES(5007,1016,12999,'2022-09-16 10:00:00','card');
INSERT INTO payments VALUES(5008,1017,54999,'2022-10-04 18:30:00','bank_transfer');
COMMIT;
