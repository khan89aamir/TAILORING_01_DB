﻿CREATE TABLE [dbo].[tblFitTypeMaster](
	[FitTypeID] [int] IDENTITY(1,1) NOT NULL,
	[FitTypeName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tblFitTypeMaster] PRIMARY KEY CLUSTERED 
(
	[FitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO