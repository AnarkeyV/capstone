-- Drop tables in reverse order of dependencies
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS Users;

-- Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(256) NOT NULL,
    PhoneNumber NVARCHAR(20)
);

-- Addresses
CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    Street NVARCHAR(200) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    State NVARCHAR(100) NOT NULL,
    PostalCode NVARCHAR(20) NOT NULL,
    Country NVARCHAR(100) NOT NULL
);

-- Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    OrderDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) NOT NULL DEFAULT 'Pending',
    TotalAmount DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

-- OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderID),
    VariantID BIGINT NOT NULL, -- Constraint applied below safely
    Quantity INT NOT NULL DEFAULT 1,
    UnitPrice DECIMAL(10,2) NOT NULL
);

-- Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderID),
    PaymentMethod NVARCHAR(50) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(10,2) NOT NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Pending'
);

-- Safe Cross-Schema Link: Apply foreign key to Variants if the table exists
IF OBJECT_ID('dbo.Variants', 'U') IS NOT NULL
BEGIN
    ALTER TABLE OrderDetails 
    ADD CONSTRAINT FK_OrderDetails_Variants 
    FOREIGN KEY (VariantID) REFERENCES Variants(VariantID);
END

-- Indexes for performance optimization
CREATE NONCLUSTERED INDEX IX_Orders_UserID ON Orders(UserID);
CREATE NONCLUSTERED INDEX IX_Orders_OrderDate_Status ON Orders(OrderDate, Status);
CREATE NONCLUSTERED INDEX IX_OrderDetails_OrderID ON OrderDetails(OrderID);
CREATE NONCLUSTERED INDEX IX_Payments_OrderID ON Payments(OrderID);

