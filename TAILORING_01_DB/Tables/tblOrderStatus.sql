CREATE TABLE [dbo].[tblOrderStatus]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [SalesOrderID] INT NULL, 
    [SalesOrderDetailsID] INT NULL, 
    [OrderStatus] INT NULL, 
    [ReceivedDate] DATETIME NULL, 
    [ReceivedBy] INT NULL, 
    [DeliveredDate] DATETIME NULL, 
    [DeliveredBy] INT NULL
)
