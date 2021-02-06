CREATE PROCEDURE [dbo].[SPR_GetDashboardData]

AS

select 
  (select count(*) from vw_GetOrderStatusDetails where  OrderStatusID=3 ) as In_Process,
  (select count(*) from vw_GetOrderStatusDetails where Convert(date,DeliveryDate)<Convert(Date,getdate()) and OrderStatusID<>1
  ) as Critical,
  (select count(*) from vw_GetOrderStatusDetails where  Convert(date,DeliveryDate)=Convert(Date,getdate())) as TodaysDelivery


select SubOrderNo,DeliveryDate from vw_GetOrderStatusDetails where  OrderStatusID=3 order by SalesOrderID desc
select SubOrderNo,DeliveryDate from vw_GetOrderStatusDetails where Convert(date,DeliveryDate)<Convert(Date,getdate()) and OrderStatusID<>1 order by SalesOrderID desc
select  SubOrderNo,DeliveryDate  from vw_GetOrderStatusDetails where  Convert(date,DeliveryDate)=Convert(Date,getdate())  and OrderStatusID<>1 order by SalesOrderID desc


RETURN 0
