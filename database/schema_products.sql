-- Drop tables in reverse order of dependencies to prevent constraint locks
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Variants;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Collections;

-- Collections
CREATE TABLE Collections (
    CollectionID BIGINT PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Handle NVARCHAR(200),
    Description NVARCHAR(MAX),
    PublishedAt DATETIME,
    UpdatedAt DATETIME,
    Image NVARCHAR(500),
    ProductsCount INT DEFAULT 0
);

-- Products
CREATE TABLE Products (
    ProductID BIGINT PRIMARY KEY,
    CollectionID BIGINT NOT NULL FOREIGN KEY REFERENCES Collections(CollectionID),
    Title NVARCHAR(300) NOT NULL,
    BodyHTML NVARCHAR(MAX),
    Vendor NVARCHAR(200),
    ProductType NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE(),
    Handle NVARCHAR(200),
    UpdatedAt DATETIME,
    PublishedAt DATETIME,
    TemplateSuffix NVARCHAR(100),
    PublishedScope NVARCHAR(50),
    Tags NVARCHAR(MAX)
);

-- Variants
CREATE TABLE Variants (
    VariantID BIGINT PRIMARY KEY,
    ProductID BIGINT NOT NULL FOREIGN KEY REFERENCES Products(ProductID),
    Title NVARCHAR(200) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    SKU NVARCHAR(100),
    Position INT,
    FulfillmentService NVARCHAR(100),
    InventoryManagement NVARCHAR(100),
    Option1 NVARCHAR(100),
    Option2 NVARCHAR(100),
    Option3 NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME,
    Taxable BIT DEFAULT 1,
    Barcode NVARCHAR(100),
    Grams INT,
    ImageID BIGINT,
    Weight DECIMAL(10,2),
    WeightUnit NVARCHAR(10),
    RequiresShipping BIT DEFAULT 1,
    MinQuantity INT DEFAULT 1,
    MaxQuantity INT,
    IncrementQuantity INT DEFAULT 1,
    PriceCurrency NVARCHAR(10) DEFAULT 'SGD'
);

-- Inventory
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    VariantID BIGINT NOT NULL FOREIGN KEY REFERENCES Variants(VariantID),
    StockQuantity INT NOT NULL DEFAULT 0,
    WarehouseLocation NVARCHAR(100)
);

-- Indexes for performance optimization
CREATE NONCLUSTERED INDEX IX_Collections_Handle ON Collections(Handle);
CREATE NONCLUSTERED INDEX IX_Products_Handle ON Products(Handle);
CREATE NONCLUSTERED INDEX IX_Products_Vendor_Type ON Products(Vendor, ProductType);
CREATE NONCLUSTERED INDEX IX_Variants_SKU ON Variants(SKU);
CREATE NONCLUSTERED INDEX IX_Variants_Barcode ON Variants(Barcode);

