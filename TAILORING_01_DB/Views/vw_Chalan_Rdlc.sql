CREATE VIEW [dbo].[vw_Chalan_Rdlc]
as
  SELECT  so.SalesOrderID ,so.OrderNo,sod.SubOrderNo,pm.GarmentName,stm.StichTypeName as StichType,ftm.FitTypeName as FitType,(CASE sod.[Service] WHEN 1 THEN 'Urgent' WHEN 0 THEN 'Normal' END) as ServiceType,CAST(NULLIF (sod.TrailDate, '') AS DATE) as gTrailDate,sod.DeliveryDate,sod.QTY,sod.Rate 
  from tblSalesOrder so 
  join tblSalesOrderDetails sod on so.SalesOrderID=sod.SalesOrderID 
  join tblProductMaster pm on sod.GarmentID=pm.GarmentID
  join tblStichTypeMaster stm on sod.StichTypeID=stm.StichTypeID 
  join tblFitTypeMaster ftm on sod.FitTypeID=ftm.FitTypeID