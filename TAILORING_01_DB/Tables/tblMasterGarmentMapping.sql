CREATE TABLE [dbo].[tblMasterGarmentMapping](
	[MasterGarmentMappingID] [int] IDENTITY(1,1) NOT NULL,
	[MasterGarmentID] [int] NOT NULL,
	[GarmentID] [int] NOT NULL,
	[LastChange] [timestamp] NULL,
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_tblMasterGarmentMapping_CreatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblMasterGarmentMapping] PRIMARY KEY CLUSTERED 
(
	[MasterGarmentMappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO