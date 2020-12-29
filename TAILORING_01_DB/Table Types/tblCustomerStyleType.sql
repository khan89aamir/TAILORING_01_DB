CREATE TYPE [dbo].[tblCustomerStyleType] AS TABLE(
	[SalesOrderID] [int] NULL,
	[GarmentID] [int] NULL,
	[StyleID] [int] NULL,
	[QTY] [int] NOT NULL DEFAULT 1,
	[StyleImageID] [int] NULL,
	[CreatedBy] [int] NULL
)