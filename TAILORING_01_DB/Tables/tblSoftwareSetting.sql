CREATE TABLE [dbo].[tblSoftwareSetting](
	[SoftwareSettingID] [int] IDENTITY(1,1) NOT NULL,
	[ImagePath] [varchar](50) NOT NULL,
	[GenericImagePath] [varchar](50) NOT NULL,
	[CopyOrderMonth] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL CONSTRAINT [DF_tblSoftwareSetting_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_tblSoftwareSetting_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tblSoftwareSetting] PRIMARY KEY CLUSTERED 
(
	[SoftwareSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO