CREATE TABLE [dbo].[tblUserRights](
	[UserRightsID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[FormID] [int] NOT NULL,
	[IsView] [int] NULL DEFAULT 0,
	[IsSave] [int] NULL DEFAULT 0,
	[IsUpdate] [int] NULL DEFAULT 0,
	[IsDelete] [int] NULL DEFAULT 0,
	[IsOther] [int] NULL DEFAULT 0,
	[CreatedBy] [int] NOT NULL DEFAULT 0,
	[CreatedOn] [datetime] NOT NULL DEFAULT getdate(),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK__tblUserR__3214EC071033C564] PRIMARY KEY CLUSTERED 
(
	[UserRightsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO