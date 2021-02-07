CREATE VIEW [dbo].[vw_GetOrderStatusDetails]
as
SELECT so.SalesOrderID,sd.SalesOrderDetailsID,sd.SubOrderNo,pm.GarmentName,pm.GarmentID,prm.GarmentCode, st.StichTypeName
	,ft.FitTypeName,sd.TrimAmount,sd.QTY,sd.Rate,
	(CASE sd.[Service] WHEN 1 THEN 'Urgent' WHEN 0 THEN 'Normal' END) [Service]
	,IIF(sd.TrailDate='1900-01-01',NULL,sd.TrailDate) TrailDate,sd.DeliveryDate,
	(sd.QTY*sd.Rate) as Total,  
	osm.OrderStatus, os.OrderStatus as OrderStatusID
	FROM [dbo].[tblSalesOrder] so
	INNER JOIN [dbo].[tblSalesOrderDetails] sd ON so.SalesOrderID=sd.SalesOrderID
	INNER JOIN dbo.tblProductMaster pm ON sd.GarmentID=pm.GarmentID
	INNER JOIN dbo.tblProductRateMaster prm ON pm.GarmentID=prm.GarmentID AND prm.OrderType=sd.[Service]
	INNER JOIN dbo.CustomerMaster cm ON so.CustomerID=cm.CustomerID
	INNER JOIN [dbo].[tblFitTypeMaster] ft ON sd.FitTypeID=ft.FitTypeID
	INNER JOIN [dbo].[tblStichTypeMaster] st ON sd.StichTypeID=st.StichTypeID
	LEFT JOIN dbo.EmployeeDetails ed ON so.CreatedBy=ed.EmpID
	LEFT JOIN dbo.tblOrderStatus os on sd.SalesOrderDetailsID =os.SalesOrderDetailsID
	LEFT JOIN dbo.tblOrderStatusMaster osm ON os.OrderStatus=osm.Id