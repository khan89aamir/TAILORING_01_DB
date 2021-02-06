CREATE VIEW [dbo].[vw_OrderDetails_RDLC]
as
  select  so.SalesOrderID , sod.SubOrderNo,pm.GarmentName,stm.StichTypeName as StichType,ftm.FitTypeName as FitType,'Normal' as ServiceType,sod.TrailDate as gTrailDate,sod.DeliveryDate,sod.rate,so.OrderNo,
  osm.OrderStatus
 
  
   from tblSalesOrder so join tblSalesOrderDetails sod
  on so.SalesOrderID=sod.SalesOrderID join 
tblOrderStatus os on sod.SalesOrderDetailsID=os.SalesOrderDetailsID join
 tblProductMaster pm on sod.GarmentID=pm.GarmentID
 join tblStichTypeMaster stm on sod.StichTypeID=stm.StichTypeID 
 join tblFitTypeMaster ftm on sod.FitTypeID=ftm.FitTypeID
 join tblOrderStatusMaster osm on os.OrderStatus=osm.Id

