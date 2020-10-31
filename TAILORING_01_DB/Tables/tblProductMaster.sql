CREATE TABLE [dbo].[tblProductMaster](
	[GarmentID] [int] IDENTITY(1,1) NOT NULL,
	[GarmentCode] [nvarchar](50) NULL,
	[GarmentName] [nvarchar](100) NULL,
	[Rate] [decimal](18, 2) NULL,
	[OrderType] [int] NULL CONSTRAINT [DF_tblProductMaster_OrderType]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL CONSTRAINT [DF_tblProductMaster_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_tblProductMaster_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tblProductMaster] PRIMARY KEY CLUSTERED 
(
	[GarmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO