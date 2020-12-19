CREATE TABLE [dbo].[tblTempBodyPostureMapping](
	[BodyPostureMappingID] [int] IDENTITY(1,1) NOT NULL,
	[BodyPostureID] [varchar](max) NOT NULL,
	[BodyPostureName] [varchar](max) NOT NULL,
	[BodyPostureImage] [varchar](max) NOT NULL,
	[MappingStatus] [varchar](50) NULL CONSTRAINT [DF_tblTempBodyPostureMapping_MappingStatus]  DEFAULT ('Pending'),
 CONSTRAINT [PK_tblTempBodyPostureMapping] PRIMARY KEY CLUSTERED 
(
	[BodyPostureMappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO