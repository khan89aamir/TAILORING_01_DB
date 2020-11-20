CREATE TABLE [dbo].[tblMobileActivation]
(
	[ID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
      [SerialNumber] VARCHAR(50),
      [ActivationCode] INT,
      [CreatedBy] [int] NOT NULL CONSTRAINT [DF__tblMobileActivation__Creat__1273C1CD]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_tblMobileActivation_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL
)
