CREATE TABLE [dbo].[tblSalesOrder](
	[SalesOrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[OrderNo] [varchar](100) NOT NULL,
	[OrderDate] [date] NOT NULL,
	[TrailDate] [date] NOT NULL,
	[AdvanceAmount] [decimal](18, 2) NULL DEFAULT 0,
	[OrderAmount] [decimal](18, 2) NOT NULL,
	[OrderQTY] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL DEFAULT 0,
	[CreatedOn] [datetime] NOT NULL DEFAULT getdate(),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY]

GO