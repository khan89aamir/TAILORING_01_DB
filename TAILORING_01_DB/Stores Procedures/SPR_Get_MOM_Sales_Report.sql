-- =============================================
-- Author:		<AAMIR KHAN>
-- Create date: <11th FEB 2021>
-- Update date: <09th MAR 2021>
-- Description:	<Description,,>
-- =============================================
--EXEC SPR_Get_MOM_Sales_Report '2021-03-01'
CREATE PROCEDURE [dbo].[SPR_Get_MOM_Sales_Report]
@MonthDate DATE='1900-01-01'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
	DECLARE @PARAMERES NVARCHAR(MAX)=''

	DECLARE @Columns NVARCHAR(MAX)=''
	DECLARE @query1 NVARCHAR(MAX)=''
	DECLARE @query2 NVARCHAR(MAX)=''
	DECLARE @query3 NVARCHAR(MAX)=''
	DECLARE @SumOfQTY NVARCHAR(MAX)=''

	DECLARE @WHERE VARCHAR(MAX)=''
	DECLARE @GarmentID INT=0
	DECLARE @GarmentName NVARCHAR(MAX)=''

	DECLARE @UrgentColumns NVARCHAR(MAX)=''
	DECLARE @UrgentSumOfQTY NVARCHAR(MAX)=''
	DECLARE @UrgentGarmentName NVARCHAR(MAX)=''
	DECLARE @query4 NVARCHAR(MAX)=''

	DECLARE @Table NVARCHAR(MAX)=''

	SET @PARAMERES=@MonthDate

	SET @Table='CREATE TABLE #tblMOM_Sales
	(
		SalesOrderID INT
		,OrderNo VARCHAR(MAX),'
	DECLARE cursor_Garment_Urgent CURSOR
			FOR

			SELECT DISTINCT sd.GarmentID,pm.GarmentName
			--,ISNULL(MAX(CASE WHEN sd.[Service]=1 AND sd.MasterGarmentID=1 THEN sd.QTY END),0) [GarmentName Urgent]
			FROM [dbo].[tblSalesOrderDetails] sd
			INNER JOIN tblProductMaster pm ON sd.MasterGarmentID=pm.GarmentID
			WHERE 
			YEAR(sd.CreatedOn)=YEAR(@MonthDate) AND MONTH(sd.CreatedOn)=MONTH(@MonthDate) 
			AND sd.[Service]=1
			GROUP BY sd.SalesOrderID,sd.GarmentID,pm.GarmentName

			OPEN cursor_Garment_Urgent;

			FETCH NEXT FROM cursor_Garment_Urgent INTO @GarmentID,@GarmentName

				WHILE @@FETCH_STATUS <> -1
				BEGIN

				SET @UrgentColumns += 'ISNULL(MAX(CASE WHEN a.[Service]=1 AND a.GarmentID = '+CAST(@GarmentID AS VARCHAR)+
				' THEN a.QTY END),0) '+QUOTENAME(CONCAT(@GarmentName,' Urgent'));

				SET @UrgentSumOfQTY +='SUM(b.'+QUOTENAME(CONCAT(@GarmentName,' Urgent'))+') '+QUOTENAME(CONCAT(@GarmentName,' Urgent'))
				--SET @UrgentColumns += 'ISNULL(MAX(CASE a.GarmentID WHEN '+CAST(@GarmentID AS VARCHAR)+
				--' THEN a.QTY END),0) '+QUOTENAME(@GarmentName);

				SET @UrgentGarmentName+=QUOTENAME(CONCAT(@GarmentName,' Urgent'))+' INT'

				FETCH NEXT FROM cursor_Garment_Urgent INTO @GarmentID,@GarmentName

				IF @@FETCH_STATUS <> -1 BEGIN
					SET @UrgentColumns+=','
					SET @UrgentSumOfQTY+=','
					SET @UrgentGarmentName+=','
				END

				END

			CLOSE cursor_Garment_Urgent;
			DEALLOCATE cursor_Garment_Urgent;

			SET @UrgentColumns=IIF(LEN(@UrgentColumns)=0,'',CONCAT(',',@UrgentColumns))
			SET @UrgentSumOfQTY=IIF(LEN(@UrgentSumOfQTY)=0,'',CONCAT(',',@UrgentSumOfQTY))

			--PRINT @UrgentColumns
			--PRINT @UrgentSumOfQTY

			DECLARE cursor_Garment CURSOR
			FOR
			
			SELECT GarmentID,GarmentName
			FROM tblProductMaster WITH(NOLOCK)
	
			OPEN cursor_Garment;

			FETCH NEXT FROM cursor_Garment INTO @GarmentID,@GarmentName

				WHILE @@FETCH_STATUS <> -1
				BEGIN

				SET @Columns += 'ISNULL(MAX(CASE WHEN a.[Service]=0 AND a.GarmentID='+CAST(@GarmentID AS VARCHAR)+
				' THEN a.QTY END),0) '+QUOTENAME(@GarmentName);

				SET @SumOfQTY +='SUM(b.'+QUOTENAME(@GarmentName)+') '+QUOTENAME(@GarmentName)

				SET @Table+=QUOTENAME(@GarmentName)+' INT'

				FETCH NEXT FROM cursor_Garment INTO @GarmentID,@GarmentName
				
				IF @@FETCH_STATUS <> -1 BEGIN
					SET @Columns+=','
					SET @SumOfQTY +=','
					SET @Table+=','
				END

				END

			CLOSE cursor_Garment;
			DEALLOCATE cursor_Garment;


	SET @Table+=','+@UrgentGarmentName+')'
	--PRINT @Table

	SET @query1 ='SELECT a.SalesOrderID,a.OrderNo,a.QTY,'+@Columns+@UrgentColumns+' FROM(
	SELECT so.SalesOrderID
	,so.OrderNo
	,pm.GarmentName
	,pm.GarmentID
	,t.QTY
	,sd.[Service]
	,ROW_NUMBER() OVER(PARTITION BY so.SalesOrderID,pm.GarmentID,sd.[Service] ORDER BY pm.GarmentID,sd.[Service]) rw
	FROM [dbo].[tblSalesOrder] so
	INNER JOIN [dbo].[tblSalesOrderDetails] sd ON so.SalesOrderID=sd.SalesOrderID
	INNER JOIN 
		(
			SELECT SalesOrderID,MasterGarmentID,GarmentID,SUM(QTY) QTY,[Service] FROM [tblSalesOrderDetails] WITH(NOLOCK)
			GROUP BY SalesOrderID,MasterGarmentID,GarmentID,[Service]
		)t ON sd.SalesOrderID=t.SalesOrderID AND sd.GarmentID=t.GarmentID AND sd.[Service]=t.[Service]
	INNER JOIN dbo.tblProductMaster pm ON sd.GarmentID=pm.GarmentID
	INNER JOIN dbo.tblProductRateMaster prm ON pm.GarmentID=prm.GarmentID AND prm.OrderType=sd.[Service]
	INNER JOIN dbo.CustomerMaster cm ON so.CustomerID=cm.CustomerID
	INNER JOIN [dbo].[tblFitTypeMaster] ft ON sd.FitTypeID=ft.FitTypeID
	INNER JOIN [dbo].[tblStichTypeMaster] st ON sd.StichTypeID=st.StichTypeID
	LEFT JOIN dbo.EmployeeDetails ed ON so.CreatedBy=ed.EmpID
	WHERE YEAR(so.OrderDate)=YEAR('''+CAST(@MonthDate AS VARCHAR)+''') AND MONTH(so.OrderDate)=MONTH('''+CAST(@MonthDate AS VARCHAR)+''') AND sd.GarmentID=sd.MasterGarmentID
	)a
	WHERE a.rw=1
	GROUP BY a.SalesOrderID,a.OrderNo,a.QTY,a.[Service]'

	SET @query2=' UNION
	SELECT a.SalesOrderID,a.OrderNo,a.QTY,'+@Columns+@UrgentColumns+' FROM(
	SELECT so.SalesOrderID
	,so.OrderNo
	,pm.GarmentName
	,pm.GarmentID
	,sd.QTY
	,sd.[Service]
	,ROW_NUMBER() OVER(PARTITION BY so.SalesOrderID,pm.GarmentID,sd.[Service] ORDER BY pm.GarmentID,sd.[Service]) rw
	FROM [dbo].[tblSalesOrder] so
	INNER JOIN [dbo].[tblSalesOrderDetails] sd ON so.SalesOrderID=sd.SalesOrderID
	INNER JOIN dbo.tblProductMaster pm ON sd.MasterGarmentID=pm.GarmentID
	INNER JOIN dbo.tblProductRateMaster prm ON pm.GarmentID=prm.GarmentID AND prm.OrderType=sd.[Service]
	INNER JOIN dbo.CustomerMaster cm ON so.CustomerID=cm.CustomerID
	INNER JOIN [dbo].[tblFitTypeMaster] ft ON sd.FitTypeID=ft.FitTypeID
	INNER JOIN [dbo].[tblStichTypeMaster] st ON sd.StichTypeID=st.StichTypeID
	LEFT JOIN dbo.EmployeeDetails ed ON so.CreatedBy=ed.EmpID
	WHERE YEAR(so.OrderDate)=YEAR('''+CAST(@MonthDate AS VARCHAR)+''') AND MONTH(so.OrderDate)=MONTH('''+CAST(@MonthDate AS VARCHAR)+''') AND sd.GarmentID<>sd.MasterGarmentID
	)a
	WHERE a.rw=1
	GROUP BY a.SalesOrderID,a.OrderNo,a.QTY,a.[Service]'

	SET @query3='SELECT b.SalesOrderID,b.OrderNo,'+@SumOfQTY+@UrgentSumOfQTY+' FROM('
	--SET @query3='SELECT b.SalesOrderID,b.OrderNo,'+@SumOfQTY+@UrgentSumOfQTY+',SUM(b.QTY) Total FROM('
	SET @query2+=')b GROUP BY b.SalesOrderID,b.OrderNo'
	
	/*
	PRINT @query3	--287
	PRINT '--@query1'
	PRINT @query1	--1645
	PRINT '--@query2'
	PRINT @query2	--1530
	*/
	

	SET @Table+=' INSERT INTO #tblMOM_Sales '
	--EXEC (@query3+@query1+@query2)

	--PRINT @query3+@query1+@query2

	--CREATE TABLE #tblMOM_Sales
	--(
	--	SalesOrderID INT
	--	,OrderNo VARCHAR(MAX)
	--	,[Shirt] INT
	--	,[Trouser] INT
	--	,[JacketSingleB] INT
	--	,[JacketDB] INT
	--	,[Tuxedo] INT
	--	,[Bandgalan] INT
	--	,[2PCSUIT] INT
	--	,[3PCSUIT] INT
	--	,[Shirt Urgent] INT
	--	--,[2PCSUIT Urgent] INT
	--	,Total INT
	--)

	--INSERT INTO #tblMOM_Sales
	--EXEC (@query3 + @query1 + @query2)


	--SET @Table+=' SELECT * FROM #tblMOM_Sales
	--UNION
	--SELECT '''' SalesOrderID,''Total'' AS OrderNo,'+@SumOfQTY+@UrgentSumOfQTY+'
	--FROM
	--(
	--	SELECT * FROM #tblMOM_Sales
	--)b
	--ORDER BY 2'

	

	SET @query4+=' SELECT * FROM #tblMOM_Sales
	UNION
	SELECT '''' SalesOrderID,''Total'' AS OrderNo,'+@SumOfQTY+@UrgentSumOfQTY+'
	FROM
	(
		SELECT * FROM #tblMOM_Sales
	)b
	ORDER BY 2'

	--PRINT @Table+@query3+@query1+@query2+@query4

	--SELECT LEN(@Table),LEN(@query3),LEN(@query1),LEN(@query2),LEN(@query4)
	EXEC (@Table+@query3+@query1+@query2+@query4)

	--SELECT * FROM #tblMOM_Sales

	--SELECT * FROM #tblMOM_Sales
	--UNION
	--SELECT '''' SalesOrderID,'Total' AS OrderNo,SUM(a.Shirt)Shirt,SUM(a.Trouser) Trouser, SUM(a.[JacketSingleB]) [JacketSingleB]
	--,SUM(a.[JacketDB]) [JacketDB], SUM(a.[Tuxedo]) Tuxedo, SUM(a.[Bandgalan]) Bandgalan, SUM(a.[2PCSUIT]) [2PCSUIT], SUM(a.[3PCSUIT]) [3PCSUIT],SUM(a.[Shirt Urgent]) [Shirt Urgent],SUM(a.Total) Total
	--FROM
	--(
	--	SELECT * FROM #tblMOM_Sales
	--)a
	--ORDER BY 2

	END TRY
	
	BEGIN CATCH
	
	INSERT [dbo].[ERROR_Log]
	(
	ERR_NUMBER
	, ERR_SEVERITY
	, ERR_STATE
	, ERR_LINE
	, ERR_MESSAGE
	, ERR_PROCEDURE
	, PARAMERES
	)
	SELECT  
	ERROR_NUMBER() 
	,ERROR_SEVERITY() 
	,ERROR_STATE() 
	,ERROR_LINE()
	,ERROR_MESSAGE()
	,ISNULL(ERROR_PROCEDURE(),'SPR_Get_MOM_Sales_Report')
	,@PARAMERES
	
	SELECT -1 AS Flag,ERROR_MESSAGE() AS Msg
	
	END CATCH

END