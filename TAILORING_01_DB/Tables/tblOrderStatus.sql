CREATE TABLE [dbo].[tblOrderStatus]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [SalesOrderID] INT NULL, 
    [SalesOrderDetailsID] INT NULL, 
    [GarmentID] INT NULL, 
    [OrderStatus] INT NULL
)
