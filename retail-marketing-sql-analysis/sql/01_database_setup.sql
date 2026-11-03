-- Academic case study using dummy data; not actual David Jones customer records.
-- Run once in a new database. No existing tables are dropped.
CREATE DATABASE IF NOT EXISTS retail_marketing_portfolio;
USE retail_marketing_portfolio;

CREATE TABLE Platform (
    PlatformID      INT          PRIMARY KEY,
    PlatformType    VARCHAR(50)  NOT NULL
);

CREATE TABLE Campaign (
    CampaignID      INT          PRIMARY KEY,
    CampaignName    VARCHAR(100) NOT NULL,
    Budget          DECIMAL(10,2),
    StartDate       DATE,
    EndDate         DATE
);

CREATE TABLE Advertisement (
    AdID            INT          PRIMARY KEY,
    PlatformID      INT,
    CampaignID      INT,
    AdDate          DATE,
    FOREIGN KEY (PlatformID)  REFERENCES Platform(PlatformID),
    FOREIGN KEY (CampaignID)  REFERENCES Campaign(CampaignID)
);

CREATE TABLE Customer (
    CustomerID      INT          PRIMARY KEY,
    Name            VARCHAR(100) NOT NULL,
    Email           VARCHAR(100),
    Age             INT,
    Location        VARCHAR(100)
);

CREATE TABLE Click (
    ClickID         INT          PRIMARY KEY,
    CustomerID      INT,
    AdID            INT,
    ClickDate       DATE,
    FOREIGN KEY (CustomerID)  REFERENCES Customer(CustomerID),
    FOREIGN KEY (AdID)        REFERENCES Advertisement(AdID)
);

CREATE TABLE `Order` (
    OrderID         INT          PRIMARY KEY,
    CustomerID      INT,
    OrderDate       DATE,
    TotalAmount     DECIMAL(10,2),
    FOREIGN KEY (CustomerID)  REFERENCES Customer(CustomerID)
);

CREATE TABLE Product (
    ProductID       INT          PRIMARY KEY,
    ProductName     VARCHAR(100) NOT NULL,
    Price           DECIMAL(10,2)
);

CREATE TABLE Contain (
    OrderID         INT,
    ProductID       INT,
    Quantity        INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID)    REFERENCES `Order`(OrderID),
    FOREIGN KEY (ProductID)  REFERENCES Product(ProductID)
);
-- ============================================================
-- INSERT DUMMY DATA
-- ============================================================

-- Platform
INSERT INTO Platform (PlatformID, PlatformType)
VALUES
(1,  'Instagram'),
(2,  'Facebook'),
(3,  'X'),
(4,  'TikTok'),
(5,  'YouTube'),
(6,  'Pinterest'),
(7,  'Snapchat'),
(8,  'LinkedIn'),
(9,  'Reddit'),
(10, 'Google Ads');

-- Campaign
INSERT INTO Campaign (CampaignID, CampaignName, Budget, StartDate, EndDate)
VALUES
(1,  'EOFY Sale 2025',           50000.00, '2025-06-01', '2025-06-30'),
(2,  'Winter Warmup 2025',       30000.00, '2025-07-01', '2025-07-31'),
(3,  'Spring Collection 2025',   25000.00, '2025-09-01', '2025-09-30'),
(4,  'Black Friday 2025',        60000.00, '2025-11-25', '2025-11-30'),
(5,  'Christmas Sale 2025',      45000.00, '2025-12-01', '2025-12-25'),
(6,  'Valentines Day 2025',      20000.00, '2025-02-01', '2025-02-14'),
(7,  'Easter Sale 2025',         22000.00, '2025-04-01', '2025-04-20'),
(8,  'Mothers Day 2025',         18000.00, '2025-05-01', '2025-05-11'),
(9,  'Fathers Day 2025',         18000.00, '2025-08-01', '2025-09-07'),
(10, 'Back to School 2025',      15000.00, '2025-01-15', '2025-02-01'),
(11, 'New Year New You 2025',    12000.00, '2025-01-01', '2025-01-14'),
(12, 'Melbourne Cup Campaign',   10000.00, '2025-10-25', '2025-11-04');

-- Advertisement
INSERT INTO Advertisement (AdID, PlatformID, CampaignID, AdDate)
VALUES
(1,  1,  1,  '2025-06-01'),
(2,  2,  1,  '2025-06-02'),
(3,  3,  1,  '2025-06-03'),
(4,  4,  1,  '2025-06-04'),
(5,  5,  2,  '2025-07-01'),
(6,  1,  2,  '2025-07-02'),
(7,  2,  2,  '2025-07-05'),
(8,  3,  3,  '2025-09-01'),
(9,  4,  3,  '2025-09-03'),
(10, 6,  3,  '2025-09-05'),
(11, 1,  4,  '2025-11-25'),
(12, 2,  4,  '2025-11-26'),
(13, 3,  4,  '2025-11-27'),
(14, 4,  5,  '2025-12-01'),
(15, 5,  5,  '2025-12-02'),
(16, 6,  6,  '2025-02-01'),
(17, 7,  6,  '2025-02-05'),
(18, 1,  7,  '2025-04-01'),
(19, 2,  7,  '2025-04-05'),
(20, 8,  8,  '2025-05-01'),
(21, 9,  9,  '2025-08-15'),
(22, 10, 9,  '2025-08-20'),
(23, 1,  10, '2025-01-15'),
(24, 3,  11, '2025-01-01'),
(25, 5,  12, '2025-10-25');

-- Customer
INSERT INTO Customer (CustomerID, Name, Email, Age, Location)
VALUES
(1001, 'Emma Wilson',      'emma.wilson@example.com',      28, 'Sydney'),
(1002, 'James Brown',      'james.brown@example.com',      35, 'Melbourne'),
(1003, 'Olivia Smith',     'olivia.smith@example.com',     22, 'Brisbane'),
(1004, 'Liam Johnson',     'liam.johnson@example.com',     45, 'Perth'),
(1005, 'Sophia Davis',     'sophia.davis@example.com',   31, 'Sydney'),
(1006, 'Noah Taylor',      'noah.taylor@example.com',      27, 'Adelaide'),
(1007, 'Ava Martinez',     'ava.martinez@example.com',   33, 'Sydney'),
(1008, 'William Lee',      'william.lee@example.com',      29, 'Melbourne'),
(1009, 'Isabella White',   'isabella.white@example.com',   24, 'Brisbane'),
(1010, 'Mason Harris',     'mason.harris@example.com',     38, 'Sydney'),
(1011, 'Mia Clark',        'mia.clark@example.com',      26, 'Perth'),
(1012, 'Ethan Lewis',      'ethan.lewis@example.com',      41, 'Melbourne'),
(1013, 'Charlotte Walker', 'charlotte.walker@example.com', 23, 'Sydney'),
(1014, 'Alexander Hall',   'alex.hall@example.com',        36, 'Adelaide'),
(1015, 'Amelia Young',     'amelia.young@example.com',   30, 'Brisbane'),
(1016, 'Henry King',       'henry.king@example.com',       44, 'Sydney'),
(1017, 'Harper Scott',     'harper.scott@example.com',     25, 'Melbourne'),
(1018, 'Lucas Green',      'lucas.green@example.com',      32, 'Perth'),
(1019, 'Evelyn Adams',     'evelyn.adams@example.com',   27, 'Sydney'),
(1020, 'Benjamin Baker',   'ben.baker@example.com',        39, 'Brisbane'),
(1021, 'Abigail Nelson',   'abigail.nelson@example.com',   21, 'Sydney'),
(1022, 'Daniel Carter',    'daniel.carter@example.com',    34, 'Melbourne'),
(1023, 'Emily Mitchell',   'emily.mitchell@example.com', 28, 'Adelaide'),
(1024, 'Matthew Perez',    'matt.perez@example.com',       43, 'Sydney'),
(1025, 'Sofia Roberts',    'sofia.roberts@example.com',    26, 'Perth');

-- Click
INSERT INTO Click (ClickID, CustomerID, AdID, ClickDate)
VALUES
(2001, 1001, 1,  '2025-06-02'),
(2002, 1002, 2,  '2025-06-03'),
(2003, 1003, 3,  '2025-06-04'),
(2004, 1004, 4,  '2025-06-05'),
(2005, 1005, 5,  '2025-07-02'),
(2006, 1006, 6,  '2025-07-03'),
(2007, 1007, 7,  '2025-07-06'),
(2008, 1008, 8,  '2025-09-02'),
(2009, 1009, 9,  '2025-09-04'),
(2010, 1010, 10, '2025-09-06'),
(2011, 1011, 11, '2025-11-25'),
(2012, 1012, 12, '2025-11-26'),
(2013, 1013, 13, '2025-11-27'),
(2014, 1014, 14, '2025-12-02'),
(2015, 1015, 15, '2025-12-03'),
(2016, 1016, 16, '2025-02-02'),
(2017, 1017, 17, '2025-02-06'),
(2018, 1018, 18, '2025-04-02'),
(2019, 1019, 19, '2025-04-06'),
(2020, 1020, 20, '2025-05-02'),
(2021, 1021, 21, '2025-08-16'),
(2022, 1022, 22, '2025-08-21'),
(2023, 1023, 23, '2025-01-16'),
(2024, 1024, 24, '2025-01-02'),
(2025, 1025, 25, '2025-10-26'),
(2026, 1001, 11, '2025-11-26'),
(2027, 1005, 14, '2025-12-02'),
(2028, 1010, 1,  '2025-06-03'),
(2029, 1015, 8,  '2025-09-03'),
(2030, 1020, 18, '2025-04-03');

-- Order
INSERT INTO `Order` (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(3001, 1001, '2025-06-02',  250.00),
(3002, 1002, '2025-06-03',  180.00),
(3003, 1003, '2025-06-04',  420.00),
(3004, 1004, '2025-06-05',  310.00),
(3005, 1005, '2025-07-02',   95.00),
(3006, 1006, '2025-07-03',  560.00),
(3007, 1007, '2025-07-06',  200.00),
(3008, 1008, '2025-09-02',  340.00),
(3009, 1009, '2025-09-04',  150.00),
(3010, 1010, '2025-09-06',  890.00),
(3011, 1011, '2025-11-25',  430.00),
(3012, 1012, '2025-11-26',  275.00),
(3013, 1013, '2025-11-27',  615.00),
(3014, 1014, '2025-12-02',  190.00),
(3015, 1015, '2025-12-03',  320.00),
(3016, 1016, '2025-02-02',  480.00),
(3017, 1017, '2025-02-06',  210.00),
(3018, 1018, '2025-04-02',  390.00),
(3019, 1019, '2025-04-06',  750.00),
(3020, 1020, '2025-05-02',  520.00),
(3021, 1021, '2025-08-16',  160.00),
(3022, 1022, '2025-08-21',  445.00),
(3023, 1023, '2025-01-16',  280.00),
(3024, 1024, '2025-01-02',  370.00),
(3025, 1025, '2025-10-26',  495.00),
(3026, 1001, '2025-11-26',  320.00),
(3027, 1005, '2025-12-02',  175.00),
(3028, 1010, '2025-06-03',  640.00),
(3029, 1015, '2025-09-03',  290.00),
(3030, 1020, '2025-04-03',  415.00);

-- Product
INSERT INTO Product (ProductID, ProductName, Price)
VALUES
(4001, 'Winter Jacket',  189.99),
(4002, 'Dress Shirt',     79.99),
(4003, 'Sneakers',       129.99),
(4004, 'Handbag',        249.99),
(4005, 'Sunglasses',      89.99),
(4006, 'Perfume',        119.99),
(4007, 'Wool Coat',      299.99),
(4008, 'Silk Scarf',      59.99),
(4009, 'Leather Belt',    49.99),
(4010, 'Running Shoes',  149.99),
(4011, 'Casual Dress',   109.99),
(4012, 'Denim Jeans',     99.99),
(4013, 'Polo Shirt',      69.99),
(4014, 'Ankle Boots',    179.99),
(4015, 'Gym Bag',         79.99);

-- Contain (Order Item)
INSERT INTO Contain (OrderID, ProductID, Quantity)
VALUES
(3001, 4001, 1),
(3001, 4002, 2),
(3002, 4003, 1),
(3002, 4013, 1),
(3003, 4004, 1),
(3003, 4005, 2),
(3004, 4001, 1),
(3004, 4006, 1),
(3005, 4005, 1),
(3006, 4004, 2),
(3006, 4007, 1),
(3007, 4002, 1),
(3007, 4008, 2),
(3008, 4003, 2),
(3008, 4006, 1),
(3009, 4009, 1),
(3009, 4010, 1),
(3010, 4007, 1),
(3010, 4004, 1),
(3010, 4011, 2),
(3011, 4012, 2),
(3011, 4013, 1),
(3012, 4002, 1),
(3012, 4014, 1),
(3013, 4004, 1),
(3013, 4006, 2),
(3014, 4013, 2),
(3015, 4010, 1),
(3015, 4015, 1),
(3016, 4007, 1),
(3016, 4008, 1),
(3017, 4011, 1),
(3017, 4009, 2),
(3018, 4012, 1),
(3018, 4003, 1),
(3019, 4004, 2),
(3019, 4007, 1),
(3020, 4001, 1),
(3020, 4006, 2),
(3021, 4005, 2),
(3022, 4014, 1),
(3022, 4013, 2),
(3023, 4002, 2),
(3023, 4009, 1),
(3024, 4010, 1),
(3024, 4011, 1),
(3025, 4003, 2),
(3025, 4015, 1),
(3026, 4007, 1),
(3026, 4004, 1),
(3027, 4002, 1),
(3027, 4005, 2),
(3028, 4001, 2),
(3028, 4006, 1),
(3029, 4003, 1),
(3029, 4012, 1),
(3030, 4011, 2),
(3030, 4014, 1);

SELECT 'Platform'       AS TableName, COUNT(*) AS TotalRows FROM Platform
UNION ALL
SELECT 'Campaign',        COUNT(*) FROM Campaign
UNION ALL
SELECT 'Advertisement',   COUNT(*) FROM Advertisement
UNION ALL
SELECT 'Customer',        COUNT(*) FROM Customer
UNION ALL
SELECT 'Click',           COUNT(*) FROM Click
UNION ALL
SELECT 'Order',           COUNT(*) FROM `Order`
UNION ALL
SELECT 'Product',         COUNT(*) FROM Product
UNION ALL
SELECT 'Contain',         COUNT(*) FROM Contain;

