CREATE TABLE [dbo].[tblMeasurementMaster](
	[MeasurementID] [int] IDENTITY(1,1) NOT NULL,
	[MeasurementName] [nvarchar](50) NULL,
	[LastChange] [timestamp] NULL,
	[CreatedBy] [int] NOT NULL CONSTRAINT [DF_tblMeasurementMaster_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_tblMeasurementMaster_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tblMeasurementMaster] PRIMARY KEY CLUSTERED 
(
	[MeasurementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO