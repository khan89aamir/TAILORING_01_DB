CREATE TABLE [dbo].[tblCommonMeasurement](
	[MeasurementComID] [int] IDENTITY(1,1) NOT NULL,
	[GarmentID] [int] NOT NULL,
	[MeasurementID] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_tblCommonMeasurement_CreatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblCommonMeasurement] PRIMARY KEY CLUSTERED 
(
	[MeasurementComID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO