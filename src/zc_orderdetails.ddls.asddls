@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Online Shop'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZC_OrderDetails
  as projection on ZI_OrderDetails
{
  key OrderUuid,
      OrderId,
      Ordereditem,
      Deliverydate,
      Creationdate
}
