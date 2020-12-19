CREATE TABLE [dbo].[tblBodyPostureMapping](
	[BodyPostureMappingID] [int] IDENTITY(1,1) NOT NULL,
	[BodyPostureID] [int] NOT NULL,
	[BodyPostureName] [varchar](50) NOT NULL,
	[BodyPostureImage] [varchar](100) NOT NULL,
	[LastChange] [timestamp] NULL,
 CONSTRAINT [PK_tblBodyPostureMapping] PRIMARY KEY CLUSTERED 
(
	[BodyPostureMappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO