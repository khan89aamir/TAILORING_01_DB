CREATE TABLE [dbo].[tblTempGarmentStyleMapping](
	[GarmentStyleID] [int] IDENTITY(1,1) NOT NULL,
	[StyleID] [varchar](max) NOT NULL,
	[TypeID] [int] NULL,
	[GarmentID] [varchar](max) NULL,
	[IsMandatory] [bit] NULL CONSTRAINT [DF_tblTempGarmentStyleMapping_IsMandatory]  DEFAULT ((0)),
	[MappingStatus] [varchar](50) NULL CONSTRAINT [DF_tblTempGarmentStyleMapping_MappingStatus]  DEFAULT ('Pending'),
 CONSTRAINT [PK_tblTempGarmentStyleMapping] PRIMARY KEY CLUSTERED 
(
	[GarmentStyleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO