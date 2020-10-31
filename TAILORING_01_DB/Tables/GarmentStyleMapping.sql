CREATE TABLE [dbo].[GarmentStyleMapping](
	[GarmentStyleID] [int] IDENTITY(1,1) NOT NULL,
	[StyleID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[GarmentID] [int] NULL,
	[CreatedBy] [int] NOT NULL CONSTRAINT [DF_GarmentStyleMapping_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_GarmentStyleMapping_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_GarmentStyleMapping] PRIMARY KEY CLUSTERED 
(
	[GarmentStyleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO