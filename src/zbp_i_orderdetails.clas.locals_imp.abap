CLASS lhc_ZI_OrderDetails DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZI_OrderDetails RESULT result.

    METHODS calculate_order_id FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZI_OrderDetails~calculate_order_id.

ENDCLASS.

CLASS lhc_ZI_OrderDetails IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD calculate_order_id.
    DATA:
      online_shops TYPE TABLE FOR UPDATE ZI_OrderDetails,
      online_shop  TYPE STRUCTURE FOR UPDATE ZI_OrderDetails.
* delete from zpsp_orderdetail UP TO 15 ROWS.

*  Get Max Order ID
    SELECT MAX( order_id ) FROM zpsp_orderdetail INTO @DATA(max_order_id).
    READ ENTITIES OF ZI_OrderDetails IN LOCAL MODE
        ENTITY Online_Shop
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_online_shop_result)
        FAILED DATA(lt_failed)
        REPORTED DATA(lt_reported).

    DATA(today) = cl_abap_context_info=>get_system_date( ).

*- Set values for Order ID and date fields
    LOOP AT lt_online_shop_result INTO DATA(online_shop_read).
      max_order_id += 1.
      online_shop = CORRESPONDING #( online_shop_read ).
      online_shop-order_id = max_order_id.
      online_shop-Creationdate = today.
      online_shop-Deliverydate = today + 10.
      APPEND online_shop TO online_shops.
    ENDLOOP.

*- Replace SET FIELDS with FIELDS for large tables
    MODIFY ENTITIES OF ZI_OrderDetails IN LOCAL MODE
        ENTITY Online_Shop UPDATE SET FIELDS WITH online_shops
        MAPPED DATA(ls_mapped_modify)
        FAILED DATA(lt_failed_modify)
        REPORTED DATA(lt_reported_modify).

  ENDMETHOD.

ENDCLASS.



CLASS lsc_ZI_ORDERDETAILS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_ORDERDETAILS IMPLEMENTATION.

  METHOD save_modified.
    IF create-online_shop IS NOT INITIAL.
*    Raise event with key and ordered item name
      RAISE ENTITY EVENT ZI_OrderDetails~ItemIsOrdered
        FROM VALUE #( FOR online_shop IN create-online_shop ( %key              = online_shop-%key
                                                              %param-ItemName   = online_shop-Ordereditem ) ).

    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
