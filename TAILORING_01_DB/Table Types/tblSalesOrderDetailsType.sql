CREATE TYPE [dbo].[tblSalesOrderDetailsType] AS TABLE(
	[SalesOrderID] [int] NULL,
	[StichTypeID] [int] NULL,
	[FitTypeID] [int] NULL,
	[GarmentID] [int] NULL,
	[MasterGarmentID] [int] NULL,
	[Service] [int] NULL,
	[TrailDate] [date] NULL,
	[DeliveryDate] [date] NULL,
	[TrimAmount] [decimal](18, 2) NULL,
	[QTY] [int] NULL,
	[Rate] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[CreatedBy] [int] NULL
)