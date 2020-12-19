CREATE TABLE [dbo].[tblTempStyleImageMaster](
	[StyleImageID] [int] IDENTITY(1,1) NOT NULL,
	[GarmentID] [varchar](max) NOT NULL,
	[StyleID] [varchar](max) NOT NULL,
	[ImageName] [varchar](max) NOT NULL,
	[MappingStatus] [varchar](50) NULL CONSTRAINT [DF_tblTempStyleImageMaster_MappingStatus]  DEFAULT ('Pending'),
 CONSTRAINT [PK_tblTempStyleImageMaster] PRIMARY KEY CLUSTERED 
(
	[StyleImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO