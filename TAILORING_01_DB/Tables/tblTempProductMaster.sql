CREATE TABLE [dbo].[tblTempProductMaster](
	[GarmentID] [int] IDENTITY(1,1) NOT NULL,
	[GarmentCode] [nvarchar](max) NULL,
	[GarmentName] [nvarchar](max) NOT NULL,
	[Photo] [varchar](max) NULL,
	[GarmentType] [varchar](max) NOT NULL,
	[MappingStatus] [varchar](50) NULL CONSTRAINT [DF_tblTempProductMaster_MappingStatus]  DEFAULT ('Pending'),
 CONSTRAINT [PK_tblTempProductMaster] PRIMARY KEY CLUSTERED 
(
	[GarmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO