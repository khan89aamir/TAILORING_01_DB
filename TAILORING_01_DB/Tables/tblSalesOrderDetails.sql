CREATE TABLE [dbo].[tblSalesOrderDetails](
	[SalesOrderDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[SalesOrderID] [int] NOT NULL,
	  [SubOrderNo] NVARCHAR(50) NULL,
	[GarmentID] [int] NOT NULL,
	[StichTypeID] [int] NOT NULL,
	[FitTypeID] [int] NOT NULL,
	[Service] [int] NULL CONSTRAINT [DF_tblSalesOrderDetails_Service]  DEFAULT ((0)),
	[TrailDate] [date] NULL,
	[DeliveryDate] [date] NULL,
	[TrimAmount] [decimal](18, 2) NULL DEFAULT 0,
	[QTY] [int] NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
	[CreatedBy] [int] NOT NULL DEFAULT 0,
	[CreatedOn] [datetime] NOT NULL DEFAULT getdate(),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL 
  
) ON [PRIMARY]

GO