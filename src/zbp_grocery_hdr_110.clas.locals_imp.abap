CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Header.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Header.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Header.

    METHODS read FOR READ
      IMPORTING keys FOR READ Header RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Header.

    METHODS rba_Items FOR READ
      IMPORTING keys_rba FOR READ Header\_Items FULL result_requested RESULT result LINK association_links.

    METHODS cba_Items FOR MODIFY
      IMPORTING entities_cba FOR CREATE Header\_Items.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.
    DATA(lo_util) = zcl_grocery_buffer_110=>get_instance( ).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
      DATA(ls_header) = CORRESPONDING zgrocery_hdr_110( <entity> MAPPING FROM ENTITY ).


      IF ls_header-order_id IS INITIAL.
        DATA(lv_uuid_tmp) = cl_system_uuid=>create_uuid_c32_static( ).
        ls_header-order_id = 'ORD-' && substring( val = lv_uuid_tmp off = 26 len = 6 ).
      ENDIF.

      lo_util->set_hdr_buffer( ls_header ).

      " Mapping back to framework
      INSERT VALUE #( %cid = <entity>-%cid
                      orderuuid = <entity>-orderuuid ) INTO TABLE mapped-header.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    DATA(lo_util) = zcl_grocery_buffer_110=>get_instance( ).
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
      DATA(ls_header) = CORRESPONDING zgrocery_hdr_110( <entity> MAPPING FROM ENTITY ).
      lo_util->set_hdr_buffer( ls_header ).
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    DATA(lo_util) = zcl_grocery_buffer_110=>get_instance( ).
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
      lo_util->set_hdr_for_delete( VALUE #( order_uuid = <key>-orderuuid ) ).
      lo_util->set_deletion_flag( abap_true ).
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
    IF keys IS NOT INITIAL.
      SELECT * FROM zgrocery_hdr_110
        FOR ALL ENTRIES IN @keys
        WHERE order_uuid = @keys-orderuuid
        INTO TABLE @DATA(lt_headers).

      LOOP AT lt_headers INTO DATA(ls_header).
        INSERT CORRESPONDING #( ls_header MAPPING TO ENTITY ) INTO TABLE result.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD lock.

  ENDMETHOD.

  METHOD rba_Items.
  ENDMETHOD.

 METHOD cba_Items.
    DATA(lo_util) = zcl_grocery_buffer_110=>get_instance( ).

    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<entity_cba>).

      DATA(lv_order_uuid) = <entity_cba>-orderuuid.

      LOOP AT <entity_cba>-%target ASSIGNING FIELD-SYMBOL(<item_entity>).

        DATA(ls_item) = CORRESPONDING zgrocery_itm_110( <item_entity> MAPPING FROM ENTITY ).


        ls_item-order_uuid = lv_order_uuid.


        IF ls_item-item_uuid IS INITIAL.
          TRY.
              ls_item-item_uuid = cl_system_uuid=>create_uuid_x16_static( ).
            CATCH cx_uuid_error.
          ENDTRY.
        ENDIF.


        lo_util->set_itm_buffer( ls_item ).


        INSERT VALUE #( %cid      = <item_entity>-%cid
                        itemuuid  = ls_item-item_uuid
                        %is_draft = <item_entity>-%is_draft ) INTO TABLE mapped-item.

      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
