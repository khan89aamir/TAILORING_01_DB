CREATE TABLE [dbo].[tblBodyPostureMaster](
	[BodyPostureID] [int] IDENTITY(1,1) NOT NULL,
	[BodyPostureType] [varchar](50) NOT NULL,
	[GarmentType] [varchar](50) NULL,
	[LastChange] [timestamp] NULL,
 CONSTRAINT [PK_tblBodyPostureMaster] PRIMARY KEY CLUSTERED 
(
	[BodyPostureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO