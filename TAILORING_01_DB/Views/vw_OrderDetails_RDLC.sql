CREATE VIEW [dbo].[vw_OrderDetails_RDLC]
as

 SELECT  so.SalesOrderID ,so.OrderNo, sod.SubOrderNo,so.OrderDate,pm.GarmentName,stm.StichTypeName AS StichType,ftm.FitTypeName AS FitType,(CASE sod.[Service] WHEN 1 THEN 'Urgent' WHEN 0 THEN 'Normal' END) AS ServiceType, CAST(NULLIF( sod.TrailDate,'') AS DATE)  as gTrailDate,sod.DeliveryDate,sod.Rate,
  osm.OrderStatus,os.ReceivedDate,os.DeliveredDate,
  (SELECT [Name] FROM EmployeeDetails WITH(NOLOCK) WHERE EmpID=os.ReceivedBy ) AS ReceivedBy, 
  (SELECT [Name] FROM EmployeeDetails WITH(NOLOCK) WHERE EmpID=os.DeliveredBy ) AS DeliveredBy

  FROM tblSalesOrder so 
  JOIN tblSalesOrderDetails sod ON so.SalesOrderID=sod.SalesOrderID 
  JOIN tblOrderStatus os ON sod.SalesOrderDetailsID=os.SalesOrderDetailsID 
  JOIN tblProductMaster pm ON sod.GarmentID=pm.GarmentID
  JOIN tblStichTypeMaster stm ON sod.StichTypeID=stm.StichTypeID 
  JOIN tblFitTypeMaster ftm ON sod.FitTypeID=ftm.FitTypeID
  JOIN tblOrderStatusMaster osm ON os.OrderStatus=osm.Id