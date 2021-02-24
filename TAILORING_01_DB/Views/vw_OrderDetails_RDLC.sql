CREATE VIEW [dbo].[vw_OrderDetails_RDLC]
as

 SELECT  so.SalesOrderID , sod.SubOrderNo,pm.GarmentName,stm.StichTypeName AS StichType,ftm.FitTypeName AS FitType,(CASE sod.[Service] WHEN 1 THEN 'Urgent' WHEN 0 THEN 'Normal' END) AS ServiceType, CAST(NULLIF( sod.TrailDate,'') AS DATE)  as gTrailDate,sod.DeliveryDate,sod.Rate,so.OrderNo,
  osm.OrderStatus,os.ReceivedDate,os.DeliveredDate,
  (SELECT [Name] FROM EmployeeDetails WITH(NOLOCK) WHERE EmpID=os.ReceivedBy ) AS ReceivedBy, 
  (SELECT [Name] FROM EmployeeDetails WITH(NOLOCK) WHERE EmpID=os.DeliveredBy ) AS DeliveredBy

  FROM tblSalesOrder so 
  join tblSalesOrderDetails sod ON so.SalesOrderID=sod.SalesOrderID 
  join tblOrderStatus os ON sod.SalesOrderDetailsID=os.SalesOrderDetailsID 
  join tblProductMaster pm ON sod.GarmentID=pm.GarmentID
  join tblStichTypeMaster stm ON sod.StichTypeID=stm.StichTypeID 
  join tblFitTypeMaster ftm ON sod.FitTypeID=ftm.FitTypeID
  join tblOrderStatusMaster osm ON os.OrderStatus=osm.Id