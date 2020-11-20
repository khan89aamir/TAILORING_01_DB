CREATE TABLE [dbo].[CustomerMaster](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[MobileNo] [varchar](20) NOT NULL,
	[EmailID] [varchar](50) NULL,
	[Address] [nvarchar](1000) NULL,
	[Gender] [bit] NULL CONSTRAINT [DF_CustomerMaster_Gender]  DEFAULT ((1)),
	[ActiveStatus] [bit] NOT NULL CONSTRAINT [DF_CustomerMaster_ActiveStatus]  DEFAULT ((1)),
	[LastChange] [timestamp] NULL,
	[CreatedBy] [int] NOT NULL CONSTRAINT [DF__CustomerM__Creat__1273C1CD]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_CustomerMaster_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_CustomerMaster] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO