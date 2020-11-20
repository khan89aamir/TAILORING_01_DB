CREATE TABLE [dbo].[tblTempGarmentMeasureMapping](
	[GarmentMeasurementID] [int] IDENTITY(1,1) NOT NULL,
	[MeasurementID] [varchar](max) NOT NULL,
	[TypeID] [int] NULL,
	[GarmentID] [varchar](max) NOT NULL,
	[IsMandatory] [bit] NULL,
	[MappingStatus] [varchar](50) NULL DEFAULT ('Pending'),
 CONSTRAINT [PK_tblTempGarmentMeasureMapping] PRIMARY KEY CLUSTERED 
(
	[GarmentMeasurementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO