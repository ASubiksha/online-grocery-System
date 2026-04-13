CLASS lsc_ZI_GROCERY_HDR_110 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_GROCERY_HDR_110 IMPLEMENTATION.

  METHOD finalize.

  ENDMETHOD.

  METHOD check_before_save.

  ENDMETHOD.

  METHOD save.

    DATA(lo_util) = zcl_grocery_buffer_110=>get_instance( ).

    DATA: ls_hdr_data TYPE zgrocery_hdr_110,
          ls_itm_data TYPE zgrocery_itm_110,
          lt_hdr_del  TYPE zcl_grocery_buffer_110=>tt_order_keys,
          lt_itm_del  TYPE zcl_grocery_buffer_110=>tt_item_keys.


    lo_util->get_hdr_buffer( IMPORTING ex_header = ls_hdr_data ).
    IF ls_hdr_data IS NOT INITIAL.
      MODIFY zgrocery_hdr_110 FROM @ls_hdr_data.
    ENDIF.


    lo_util->get_itm_buffer( IMPORTING ex_item = ls_itm_data ).
    IF ls_itm_data IS NOT INITIAL.
      MODIFY zgrocery_itm_110 FROM @ls_itm_data.
    ENDIF.


    lo_util->get_hdr_for_delete( IMPORTING ex_order_keys = lt_hdr_del ).
    IF lt_hdr_del IS NOT INITIAL.
      LOOP AT lt_hdr_del INTO DATA(ls_h_del).
        DELETE FROM zgrocery_hdr_110 WHERE order_uuid = @ls_h_del-order_uuid.
        DELETE FROM zgrocery_itm_110 WHERE order_uuid = @ls_h_del-order_uuid.
      ENDLOOP.
    ENDIF.


    lo_util->get_itm_for_delete( IMPORTING ex_item_keys = lt_itm_del ).
    IF lt_itm_del IS NOT INITIAL.
      LOOP AT lt_itm_del INTO DATA(ls_i_del).
        DELETE FROM zgrocery_itm_110 WHERE item_uuid = @ls_i_del-item_uuid.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.

    zcl_grocery_buffer_110=>get_instance( )->cleanup_buffer( ).
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
