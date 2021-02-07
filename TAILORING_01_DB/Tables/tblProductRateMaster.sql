CREATE TABLE [dbo].[tblProductRateMaster](
	[GarmentRateID] [int] IDENTITY(1,1) NOT NULL,
	[GarmentID] [int] NOT NULL,
	[GarmentCode] [nvarchar](50) NULL,
	[Rate] [decimal](18, 2) NOT NULL,
	[OrderType] [int] NOT NULL CONSTRAINT [DF_tblProductRateMaster_OrderType]  DEFAULT ((0)),
	[LastChange] [timestamp] NULL,
	[CreatedBy] [int] NOT NULL CONSTRAINT [DF_tblProductRateMaster_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_tblProductRateMaster_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tblProductRateMaster] PRIMARY KEY CLUSTERED 
(
	[GarmentRateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO