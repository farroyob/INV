USE MASTER

-- Check if the database exists
IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'Inventory'
)
BEGIN
    -- Drop the database if it exists
    ALTER DATABASE Inventory SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Inventory;
END
GO

-- Create the Inventory database
CREATE DATABASE Inventory;
GO

-- Use the Inventory database
USE Inventory;
GO

-- Check if the tables exist and drop them if they do
IF OBJECT_ID('Warehouse', 'U') IS NOT NULL
DROP TABLE Warehouse;
GO

IF OBJECT_ID('Category', 'U') IS NOT NULL
DROP TABLE Category;
GO

IF OBJECT_ID('Brand', 'U') IS NOT NULL
DROP TABLE Brand;
GO

IF OBJECT_ID('Product', 'U') IS NOT NULL
DROP TABLE Product;
GO

IF OBJECT_ID('ProductWarehouse', 'U') IS NOT NULL
DROP TABLE ProductWarehouse;
GO

-- Create the Warehouse table
CREATE TABLE Warehouse (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255) NULL,
	IsActive BIT
);
GO

-- Create the Category table
CREATE TABLE Category (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Status BIT
);
GO

-- Create the Brand table
CREATE TABLE Brand (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Status BIT
);
GO

-- Create the Product table
CREATE TABLE Product (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SerialNumber VARCHAR(50) NOT NULL,
    Description VARCHAR(255) NULL,
    CategoryId INT,
    BrandId INT,
    Type INT,
    ParentProductId INT,
    Cost DECIMAL(18,5),
    Price DECIMAL(18,5),
    FOREIGN KEY (CategoryId) REFERENCES Category(Id),
    FOREIGN KEY (BrandId) REFERENCES Brand(Id),
    FOREIGN KEY (ParentProductId) REFERENCES Product(Id)
);
GO

-- Create the ProductWarehouse table
CREATE TABLE ProductWarehouse (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    WarehouseId INT,
    ProductId INT,
    Localization VARCHAR(100) NOT NULL,
    Amount INT NOT NULL,
    FOREIGN KEY (WarehouseId) REFERENCES Warehouse(Id),
    FOREIGN KEY (ProductId) REFERENCES Product(Id)
);
GO

-- Insert 10 rows into the Warehouse table
INSERT INTO Warehouse (Name, Description, IsActive)
VALUES
    ('Warehouse 1', 'Description 1', 1),
    ('Warehouse 2', 'Description 2', 1),
    ('Warehouse 3', 'Description 3', 1),
    ('Warehouse 4', 'Description 4', 1),
    ('Warehouse 5', 'Description 5', 1),
    ('Warehouse 6', 'Description 6', 1),
    ('Warehouse 7', 'Description 7', 0),
    ('Warehouse 8', 'Description 8', 1),
    ('Warehouse 9', 'Description 9', 1),
    ('Warehouse 10', 'Description 10', 1);

-- Insert 10 rows into the Category table
INSERT INTO Category (Name, Status)
VALUES
    ('Category 1', 1),
    ('Category 2', 1),
    ('Category 3', 1),
    ('Category 4', 1),
    ('Category 5', 1),
    ('Category 6', 1),
    ('Category 7', 1),
    ('Category 8', 0),
    ('Category 9', 1),
    ('Category 10', 1);

-- Insert 10 rows into the Brand table
INSERT INTO Brand (Name, Status)
VALUES
    ('Brand 1', 1),
    ('Brand 2', 1),
    ('Brand 3', 1),
    ('Brand 4', 1),
    ('Brand 5', 1),
    ('Brand 6', 1),
    ('Brand 7', 0),
    ('Brand 8', 1),
    ('Brand 9', 1),
    ('Brand 10', 1);

-- Insert 10 rows into the Product table
INSERT INTO Product (SerialNumber, Description, CategoryId, BrandId, Type, ParentProductId, Cost, Price)
VALUES
    ('SN1', 'Description 1', 1, 1, 1, NULL, 10.00, 15.00),
    ('SN2', 'Description 2', 2, 2, 2, NULL, 20.00, 25.00),
    ('SN3', 'Description 3', 3, 3, 3, NULL, 30.00, 35.00),
    ('SN4', 'Description 4', 4, 4, 4, NULL, 40.00, 45.00),
    ('SN5', 'Description 5', 5, 5, 5, NULL, 50.00, 55.00),
    ('SN6', 'Description 6', 6, 6, 6, NULL, 60.00, 65.00),
    ('SN7', 'Description 7', 7, 7, 7, NULL, 70.00, 75.00),
    ('SN8', 'Description 8', 8, 8, 8, NULL, 80.00, 85.00),
    ('SN9', 'Description 9', 9, 9, 9, NULL, 90.00, 95.00),
    ('SN10', 'Description 10', 10, 10, 10, NULL, 100.00, 105.00);

 -- Insert 20 rows into the ProductWarehouse table
INSERT INTO ProductWarehouse (WarehouseId, ProductId, Localization, Amount)
VALUES
    (1, 1, 'Localization 1', 100),
    (1, 2, 'Localization 2', 150),
    (2, 3, 'Localization 3', 200),
    (2, 4, 'Localization 4', 120),
    (3, 5, 'Localization 5', 180),
    (3, 6, 'Localization 6', 90),
    (4, 7, 'Localization 7', 210),
    (4, 8, 'Localization 8', 80),
    (5, 9, 'Localization 9', 240),
    (5, 10, 'Localization 10', 70),
    (6, 1, 'Localization 11', 110),
    (6, 2, 'Localization 12', 160),
    (7, 3, 'Localization 13', 190),
    (7, 4, 'Localization 14', 130),
    (8, 5, 'Localization 15', 170),
    (8, 6, 'Localization 16', 100),
    (9, 7, 'Localization 17', 220),
    (9, 8, 'Localization 18', 90),
    (10, 9, 'Localization 19', 250),
    (10, 10, 'Localization 20', 60);

	-- Insert 5 rows into the ProductWarehouse table for each warehouse
INSERT INTO ProductWarehouse (WarehouseId, ProductId, Localization, Amount)
VALUES
    -- Warehouse 1
    (1, 1, 'Localization 1', 100),
    (1, 2, 'Localization 2', 150),
    (1, 3, 'Localization 3', 200),
    (1, 4, 'Localization 4', 120),
    (1, 5, 'Localization 5', 180),

    -- Warehouse 2
    (2, 6, 'Localization 1', 90),
    (2, 7, 'Localization 2', 210),
    (2, 8, 'Localization 3', 80),
    (2, 9, 'Localization 4', 240),
    ( 2, 10, 'Localization 5', 70),

    -- Warehouse 3
    (3, 1, 'Localization 1', 110),
    (3, 2, 'Localization 2', 160),
    (3, 3, 'Localization 3', 190),
    (3, 4, 'Localization 4', 130),
    (3, 5, 'Localization 5', 170),

    -- Warehouse 4
    (4, 6, 'Localization 1', 100),
    (4, 7, 'Localization 2', 220),
    (4, 8, 'Localization 3', 90),
    (4, 9, 'Localization 4', 250),
    (4, 10, 'Localization 5', 60);

