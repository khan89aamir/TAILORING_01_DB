CREATE VIEW [dbo].[vw_Chalan_Rdlc]
as
  select  so.SalesOrderID , sod.SubOrderNo,pm.GarmentName,stm.StichTypeName as StichType,ftm.FitTypeName as FitType,'Normal' as ServiceType,sod.TrailDate as gTrailDate,sod.DeliveryDate,sod.QTY,sod.rate,so.OrderNo from tblSalesOrder so join tblSalesOrderDetails sod
  on so.SalesOrderID=sod.SalesOrderID join 
 tblProductMaster pm on sod.GarmentID=pm.GarmentID
 join tblStichTypeMaster stm on sod.StichTypeID=stm.StichTypeID 
 join tblFitTypeMaster ftm on sod.FitTypeID=ftm.FitTypeID

