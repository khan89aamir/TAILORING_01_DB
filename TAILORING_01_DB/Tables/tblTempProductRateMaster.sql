CREATE TABLE [dbo].[tblTempProductRateMaster](
	[GarmentRateID] [int] IDENTITY(1,1) NOT NULL,
	[GarmentID] [varchar](max) NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
	[OrderType] [varchar](max) NOT NULL,
	[MappingStatus] [varchar](50) NULL DEFAULT ('Pending'),
 CONSTRAINT [PK_tblTempProductRateMaster] PRIMARY KEY CLUSTERED 
(
	[GarmentRateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO