CREATE TABLE [dbo].[tblTempBodyPostureMaster](
	[BodyPostureID] [int] IDENTITY(1,1) NOT NULL,
	[BodyPostureType] [varchar](max) NOT NULL,
	[GarmentType] [varchar](max) NOT NULL,
	[MappingStatus] [varchar](50) NULL DEFAULT ('Pending'),
 CONSTRAINT [PK_tblTempBodyPostureMaster] PRIMARY KEY CLUSTERED 
(
	[BodyPostureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO