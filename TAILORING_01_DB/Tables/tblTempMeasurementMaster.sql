CREATE TABLE [dbo].[tblTempMeasurementMaster](
	[MeasurementID] [int] IDENTITY(1,1) NOT NULL,
	[MeasurementName] [nvarchar](max) NULL,
	[MappingStatus] [varchar](50) NULL DEFAULT ('Pending'),
 CONSTRAINT [PK_tblTempMeasurementMaster] PRIMARY KEY CLUSTERED 
(
	[MeasurementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO