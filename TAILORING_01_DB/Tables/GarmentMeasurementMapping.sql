CREATE TABLE [dbo].[GarmentMeasurementMapping](
	[GarmentMeasurementID] [int] IDENTITY(1,1) NOT NULL,
	[MeasurementID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[GarmentID] [int] NOT NULL,
	[IsMandatory] [bit] NULL CONSTRAINT [DF_GarmentMeasurementMapping_IsMandatory]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL CONSTRAINT [DF_GarmentMeasurementMapping_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_GarmentMeasurementMapping_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_GarmentMeasurementMapping] PRIMARY KEY CLUSTERED 
(
	[GarmentMeasurementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO