@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Online Shop'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@Search.searchable: true

@UI: { headerInfo: { typeName: 'Online Shop',
                    typeNamePlural: 'Online Shop',
                    title: { type: #STANDARD, label: 'Online Shop', value: 'order_id' } },

      presentationVariant: [{ sortOrder: [{ by: 'Creationdate',
                                            direction: #DESC }] }] }
define root view entity ZC_OrderDetails
  as projection on ZI_OrderDetails
{
      @UI.facet: [ { id:       'Orders',
                     purpose:  #STANDARD,
                     type:     #IDENTIFICATION_REFERENCE,
                     label:    'Order',
                     position: 10 }      ]
  key Order_Uuid,

      @UI: { lineItem:       [ { position: 10,label: 'Order ID', importance: #HIGH } ],
             identification: [ { position: 10, label: 'Order ID' } ] }
      @Search.defaultSearchElement: true
      Order_Id,

      @UI: { lineItem:       [ { position: 20,label: 'Ordered Item', importance: #HIGH } ],
             identification: [ { position: 20, label: 'Ordered Item' } ] }
      @Search.defaultSearchElement: true
      Ordereditem,
      
      @EndUserText.label: 'Delivery Date'
      Deliverydate,

      @UI: { lineItem:       [ { position: 50,label: 'Created On', importance: #HIGH },
                               { type: #FOR_ACTION, dataAction: 'update_inforecord', label: 'Update InfoRecord' } ],
             identification: [ { position: 50, label: 'Created On' } ] }
      Creationdate
}
