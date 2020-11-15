CREATE TYPE [dbo].[tblSalesOrderDetailsType] AS TABLE(
	[SalesOrderID] [int] NULL,
	[GarmentID] [int] NULL,
	[TrimAmount] [decimal](18, 2) NULL,
	[QTY] [int] NULL,
	[Rate] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[CreatedBy] [int] NULL
)