@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Model for Online Shop'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_OrderDetails
  as select from zpsp_orderdetail
{
  key order_uuid   as OrderUuid,
      order_id     as OrderId,
      ordereditem  as Ordereditem,
      deliverydate as Deliverydate,
      creationdate as Creationdate
}
