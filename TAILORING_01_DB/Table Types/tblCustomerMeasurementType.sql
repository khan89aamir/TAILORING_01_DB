CREATE TYPE [dbo].[tblCustomerMeasurementType] AS TABLE(
	[SalesOrderID] [int] NULL,
	[GarmentID] [int] NULL,
	[MeasurementID] [int] NULL,
	[MeasurementValue] [decimal](18, 2) NULL,
	[CreatedBy] [int] NULL
)