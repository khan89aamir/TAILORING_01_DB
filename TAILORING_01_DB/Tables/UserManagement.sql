﻿CREATE TABLE [dbo].[UserManagement](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](max) NULL,
	[EmailID] [varchar](50) NULL,
	[EmployeeID] [int] NULL,
	[IsAdmin] [bit] NULL,
	[ActiveStatus] [bit] NULL CONSTRAINT [DF_UserManagement_ActiveStatus]  DEFAULT ((1)),
	[SecurityQuestion] [nvarchar](50) NULL,
	[Answer] [nvarchar](100) NULL,
	IsBlock  [bit],
	[LastChange] [timestamp] NULL,
	[CreatedBy] [int] NULL CONSTRAINT [DF_UserManagement_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_UserManagement_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_UserManagement] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO