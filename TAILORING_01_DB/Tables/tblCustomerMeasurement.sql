﻿CREATE TABLE [dbo].[tblCustomerMeasurement](
	[CustMeasurementID] [int] IDENTITY(1,1) NOT NULL,
	[SalesOrderID] [int] NOT NULL,
	[MasterGarmentID] [int] NOT NULL,
	[GarmentID] [int] NOT NULL,
	[MeasurementID] [int] NOT NULL,
	[MeasurementValue] [decimal](18, 2) NOT NULL,
	[LastChange] [timestamp] NULL,
	[CreatedBy] [int] NOT NULL DEFAULT 0,
	[CreatedOn] [datetime] NOT NULL DEFAULT getdate(),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tblCustomerMeasurement] PRIMARY KEY CLUSTERED 
(
	[CustMeasurementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO