CREATE TABLE [dbo].[CompanyMaster](
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](100) NULL,
	[Address] [nvarchar](max) NULL,
	[MobileNo] [varchar](20) NULL,
	[EmailID] [varchar](50) NULL,
	[IsDefault] BIT NULL DEFAULT 0, 
	[LastChange] [timestamp] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
    CONSTRAINT [PK_CompanyMaster] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO