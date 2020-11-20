CREATE TABLE [dbo].[tblStyleImageMaster](
	[StyleImageID] [int] IDENTITY(1,1) NOT NULL,
	[GarmentID] [int] NOT NULL,
	[StyleID] [int] NOT NULL,
	[ImageName] [varchar](100) NOT NULL,
	[LastChange] [timestamp] NULL,
	[CreatedBy] [int] NOT NULL CONSTRAINT [DF_StyleImageMaster_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_StyleImageMaster_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_StyleImageMaster] PRIMARY KEY CLUSTERED 
(
	[StyleImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO