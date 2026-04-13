CLASS lhc_Item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Item.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Item.

    METHODS read FOR READ
      IMPORTING keys FOR READ Item RESULT result.

    METHODS rba_Header FOR READ
      IMPORTING keys_rba FOR READ Item\_Header FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.

  METHOD update.

    DATA(lo_util) = zcl_grocery_buffer_110=>get_instance( ).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entity>).

      DATA(ls_db_itm) = CORRESPONDING zgrocery_itm_110( <ls_entity> MAPPING FROM ENTITY ).


      lo_util->set_itm_buffer( im_item = ls_db_itm ).
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.

    DATA(lo_util) = zcl_grocery_buffer_110=>get_instance( ).

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_key>).

      lo_util->set_itm_for_delete( im_item_key = VALUE #( item_uuid = <ls_key>-ItemUuid ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD read.

    IF keys IS NOT INITIAL.
      SELECT * FROM zgrocery_itm_110
        FOR ALL ENTRIES IN @keys
        WHERE item_uuid = @keys-ItemUuid
        INTO TABLE @DATA(lt_db_itm).

      LOOP AT lt_db_itm INTO DATA(ls_db_itm).
        INSERT CORRESPONDING #( ls_db_itm MAPPING TO ENTITY ) INTO TABLE result.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD rba_Header.
    " Read By Association logic (Standard Draft logic usually handles this)
  ENDMETHOD.

ENDCLASS.
