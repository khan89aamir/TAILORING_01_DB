CREATE VIEW [dbo].[vw_GetOrderStatusDetails]
as
SELECT so.SalesOrderID,sd.SalesOrderDetailsID,sd.SubOrderNo,pm.GarmentName,pm.GarmentID,pm.GarmentCode, st.StichTypeName
	,ft.FitTypeName,sd.TrimAmount,sd.QTY,sd.Rate,
	(CASE sd.[Service] WHEN 1 THEN 'Urgent' WHEN 0 THEN 'Normal' END) [Service]
	,IIF(sd.TrailDate='1900-01-01',NULL,sd.TrailDate) TrailDate,sd.DeliveryDate,
	(sd.QTY*sd.Rate) as Total,  
	(case  when os.OrderStatus IS NULL  then 'NA'
		  when os.OrderStatus=3 then 'In Process'
	      when os.OrderStatus=4 then 'Received'
		  when os.OrderStatus=1 then 'Delivered'
		   when os.OrderStatus=2 then 'Critical'
		  
		  end)
	as OrderStatus
	FROM [dbo].[tblSalesOrder] so
	INNER JOIN [dbo].[tblSalesOrderDetails] sd ON so.SalesOrderID=sd.SalesOrderID
	INNER JOIN dbo.tblProductMaster pm ON sd.GarmentID=pm.GarmentID
	INNER JOIN dbo.CustomerMaster cm ON so.CustomerID=cm.CustomerID
	INNER JOIN [dbo].[tblFitTypeMaster] ft ON sd.FitTypeID=ft.FitTypeID
	INNER JOIN [dbo].[tblStichTypeMaster] st ON sd.StichTypeID=st.StichTypeID
	LEFT JOIN dbo.EmployeeDetails ed ON so.CreatedBy=ed.EmpID
	Left join dbo.tblOrderStatus os on sd.SalesOrderDetailsID =os.SalesOrderDetailsID



