CLASS lhc_Root_Behavior DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS createInternalOrder FOR MODIFY
      IMPORTING keys FOR ACTION Root_Behavior~createInternalOrder RESULT result.

    METHODS createVendor FOR MODIFY
      IMPORTING keys FOR ACTION Root_Behavior~createVendor RESULT result.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR Root_Behavior RESULT result.

ENDCLASS.

CLASS lhc_Root_Behavior IMPLEMENTATION.

  METHOD createInternalOrder.

    DATA lt_master_data TYPE bapi2075_7.
    DATA lv_orderid TYPE aufnr.
    DATA lt_return TYPE STANDARD TABLE OF bapiret2.
    DATA lv_restaurant TYPE text.
    DATA lt_restaurant_info TYPE zevent_location.

    READ ENTITIES OF zlht_c_el_proj
        ENTITY Projec_Behavior
            FROM VALUE #(
                FOR key IN keys (
                             mykey = key-mykey
                             %control = VALUE #(
                                      locationname = if_abap_behv=>mk-on
                                      streetname = if_abap_behv=>mk-on
                                      housenumber = if_abap_behv=>mk-on
                                      postcode = if_abap_behv=>mk-on
                                      city = if_abap_behv=>mk-on
                                      contact = if_abap_behv=>mk-on
                                      phone = if_abap_behv=>mk-on
                                      openinghour = if_abap_behv=>mk-on
                                      cuisine = if_abap_behv=>mk-on
                                      dietvegan = if_abap_behv=>mk-on
                                      dietvegetarian = if_abap_behv=>mk-on
                                      organic = if_abap_behv=>mk-on
                                      wheelchair      = if_abap_behv=>mk-on )
                                     )
                           )
    RESULT DATA(lt_result).

    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<ls_result>).
      lv_restaurant = <ls_result>-locationname.
    ENDLOOP.

    lt_master_data-order_name = |Event bei { lv_restaurant } .|.
    lt_master_data-comp_code = 'OBDE'.
    lt_master_data-order_type = '0400'.
    lt_master_data-co_area = 'OBEU'.


    CALL FUNCTION 'BAPI_INTERNALORDER_CREATE'
      EXPORTING
        i_master_data = lt_master_data
      IMPORTING
        orderid       = lv_orderid
      TABLES
        return        = lt_return
      .

  result = VALUE #(
            FOR zlht_c_el_proj
                IN lt_result (
                        mykey = zlht_c_el_proj-mykey
                        %param = zlht_c_el_proj
                              )
                   ).
  ENDMETHOD.



  METHOD createVendor.

    DATA lv_partnercategory TYPE bu_type.
    DATA ls_centraldata TYPE bapibus1006_central.
    DATA ls_centraldataorg TYPE bapibus1006_central_organ.
    DATA ls_addressdata TYPE bapibus1006_address.
    DATA lv_bupa TYPE bu_partner.

    READ ENTITIES OF zlht_c_el_proj
    ENTITY Projec_Behavior
          FROM VALUE #( FOR key IN keys (
                                    mykey = key-mykey
                                    %control = VALUE #(
                                          locationname = if_abap_behv=>mk-on
                                          streetname = if_abap_behv=>mk-on
                                          housenumber = if_abap_behv=>mk-on
                                          postcode = if_abap_behv=>mk-on
                                          city = if_abap_behv=>mk-on
                                          contact = if_abap_behv=>mk-on
                                          phone = if_abap_behv=>mk-on
                                          openinghour = if_abap_behv=>mk-on
                                          cuisine = if_abap_behv=>mk-on
                                          dietvegan = if_abap_behv=>mk-on
                                          dietvegetarian = if_abap_behv=>mk-on
                                          organic = if_abap_behv=>mk-on
                                          wheelchair      = if_abap_behv=>mk-on )
                                            )
                          )
 RESULT DATA(lt_result).

   result = VALUE #( FOR zlht_c_el_proj
                        IN lt_result (
                                mykey = zlht_c_el_proj-mykey
                               %param    = zlht_c_el_proj
                                        )
                     ).

    lv_partnercategory = 2.

    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<ls_result>).
      ls_centraldataorg-name1 = <ls_result>-locationname.
      ls_addressdata-street = <ls_result>-streetname.
      ls_addressdata-house_no = <ls_result>-housenumber.
      ls_addressdata-postl_cod1 = <ls_result>-postcode.
      ls_addressdata-city = <ls_result>-city.
    ENDLOOP.

    ls_addressdata-countryiso = 'DE'.
    ls_addressdata-languiso = 'DE'.

    CALL FUNCTION 'BAPI_BUPA_CREATE_FROM_DATA'
      EXPORTING
        partnercategory         = lv_partnercategory
        centraldata             = ls_centraldata
        centraldataorganization = ls_centraldataorg
        addressdata             = ls_addressdata
      IMPORTING
        businesspartner         = lv_bupa
      .


    DATA lv_businesspartnerrole TYPE bu_partnerrole.

    lv_businesspartnerrole = 'FLVN00'.

    CALL FUNCTION 'BAPI_BUPA_ROLE_ADD_2'
      EXPORTING
        businesspartner     = lv_bupa
        businesspartnerrole = lv_businesspartnerrole
      .

    .

  ENDMETHOD.

  METHOD get_features.

*     %control-<fieldname> specifies which fields are read

    READ ENTITY zlht_c_el_proj FROM VALUE #( FOR keyval IN keys
                                                      (  %key = keyval-%key
                                                        ) )
    RESULT DATA(lt_result).


    result = VALUE #( FOR ls_result IN lt_result
                      ( %key                           = ls_result-%key
                         )
                       ).

  ENDMETHOD.

ENDCLASS.
