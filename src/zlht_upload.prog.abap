*&---------------------------------------------------------------------*
*& Report zlht_upload
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlht_upload.

*  empty database table

DELETE FROM zlht_eventdetail.

*  communication FE to BE

DATA:lt_excel  TYPE filetable,
     lv_file   TYPE i,
     lv_action TYPE i.

cl_gui_frontend_services=>file_open_dialog( EXPORTING file_filter = |xlsx (*.xlsx)\|*.xlsx\| { cl_gui_frontend_services=>filetype_all }|
                                            CHANGING  file_table  = lt_excel
                                                      rc          = lv_file
                                                      user_action = lv_action ).

*   check itab Upload

IF lv_action = cl_gui_frontend_services=>action_ok.

  IF lines( lt_excel ) > 0 .
    DATA: lv_filesize  TYPE w3param-cont_len,
          lv_filetype  TYPE w3param-cont_type,
          it_bin_table TYPE w3mimetabtype.

    cl_gui_frontend_services=>gui_upload( EXPORTING filename   = |{ lt_excel[ 1 ]-filename }|
                                                    filetype   = 'BIN'
                                          IMPORTING filelength = lv_filesize
                                          CHANGING  data_tab   = it_bin_table
                                                  ).

*   itab Upload an conversion

    DATA(lv_bin_table) = cl_bcs_convert=>solix_to_xstring( it_solix = it_bin_table ).
    DATA(o_excel) = NEW cl_fdt_xl_spreadsheet( document_name = CONV #( lt_excel[ 1 ]-filename )
                                               xdocument     = lv_bin_table ).


*    Checks


    DATA it_worksheet_names TYPE if_fdt_doc_spreadsheet=>t_worksheet_names.

    o_excel->if_fdt_doc_spreadsheet~get_worksheet_names( IMPORTING worksheet_names = it_worksheet_names ).

    IF lines( it_worksheet_names ) > 0.
      DATA(o_worksheet_itab) = o_excel->if_fdt_doc_spreadsheet~get_itab_from_worksheet( it_worksheet_names[ 1 ] ).


*      Export to Database

      FIELD-SYMBOLS: <worksheet> TYPE ANY TABLE.
      ASSIGN o_worksheet_itab->* TO <worksheet>.

      DATA: o_row TYPE REF TO data.
      CREATE DATA o_row LIKE LINE OF <worksheet>.
      ASSIGN o_row->* TO FIELD-SYMBOL(<row>).

      DATA: ls_event TYPE zlht_eventdetail.
      FIELD-SYMBOLS: <fs_mykey>             TYPE string,
                     <fs_locationname>      TYPE string,
                     <fs_email>             TYPE string,
                     <fs_phone>             TYPE string,
                     <fs_min_attendees>     TYPE string,
                     <fs_max_attendees>     TYPE string,
                     <fs_features>          TYPE string,
                     <fs_feature_details>   TYPE string,
                     <fs_website>           TYPE string,
                     <fs_food_package>      TYPE string,
                     <fs_drink_package>     TYPE string,
                     <fs_starter>           TYPE string,
                     <fs_meat>              TYPE string,
                     <fs_fish>              TYPE string,
                     <fs_vegan>             TYPE string,
                     <fs_dessert>           TYPE string,
                     <fs_dessert_vegan>     TYPE string,
                     <fs_average_valuation> TYPE string,
                     <fs_valuation_from>    TYPE string,
                     <fs_feedback_type>     TYPE string,
                     <fs_feedback_date>     TYPE string,
                     <fs_feedback_user>     TYPE string,
                     <fs_feedback>          TYPE string.

*    Loop

      LOOP AT <worksheet> ASSIGNING <row>.
        IF sy-tabix > 1.
          ASSIGN COMPONENT:
                            1 OF STRUCTURE <row> TO <fs_mykey>,
                            2 OF STRUCTURE <row> TO <fs_locationname>,
                            3 OF STRUCTURE <row> TO <fs_email>,
                            4 OF STRUCTURE <row> TO <fs_phone>,
                            5 OF STRUCTURE <row> TO <fs_min_attendees>,
                            6 OF STRUCTURE <row> TO <fs_max_attendees>,
                            7 OF STRUCTURE <row> TO <fs_features>,
                            8 OF STRUCTURE <row> TO <fs_feature_details>,
                            9 OF STRUCTURE <row> TO <fs_website>,
                           10 OF STRUCTURE <row> TO <fs_food_package>,
                           11 OF STRUCTURE <row> TO <fs_drink_package>,
                           12 OF STRUCTURE <row> TO <fs_starter>,
                           13 OF STRUCTURE <row> TO <fs_meat>,
                           14 OF STRUCTURE <row> TO <fs_fish>,
                           15 OF STRUCTURE <row> TO <fs_vegan>,
                           16 OF STRUCTURE <row> TO <fs_dessert>,
                           17 OF STRUCTURE <row> TO <fs_dessert_vegan>,
                           18 OF STRUCTURE <row> TO <fs_average_valuation>,
                           19 OF STRUCTURE <row> TO <fs_valuation_from>,
                           20 OF STRUCTURE <row> TO <fs_feedback_type>,
                           21 OF STRUCTURE <row> TO <fs_feedback_date>,
                           22 OF STRUCTURE <row> TO <fs_feedback_user>,
                           23 OF STRUCTURE <row> TO <fs_feedback>.

          ls_event-mykey = <fs_mykey>.
          ls_event-locationname = <fs_locationname>.
          ls_event-email = <fs_email>.
          ls_event-phone = <fs_phone>.
          ls_event-min_attendees = <fs_min_attendees>.
          ls_event-max_attendees = <fs_max_attendees>.
          ls_event-features = <fs_features>.
          ls_event-feature_details = <fs_feature_details>.
          ls_event-website = <fs_website>.
          ls_event-food_package = <fs_food_package>.
          ls_event-drink_package = <fs_drink_package>.
          ls_event-starter = <fs_starter>.
          ls_event-meat = <fs_meat>.
          ls_event-fish = <fs_fish>.
          ls_event-vegan = <fs_vegan>.
          ls_event-dessert = <fs_dessert>.
          ls_event-dessert_vegan = <fs_dessert_vegan>.
          ls_event-average_valuation = <fs_average_valuation>.
          ls_event-valuation_details = <fs_valuation_from>.
          ls_event-feedback_type = <fs_feedback_type>.
          ls_event-feedback_date = <fs_feedback_date>.
          ls_event-feedback_user = <fs_feedback_user>.
          ls_event-feedback = <fs_feedback>.



          INSERT INTO zlht_eventdetail VALUES ls_event.
          IF sy-subrc = 4.
            WRITE: / 'Erfolgreich'.
          ENDIF.
          CLEAR ls_event.

        ENDIF.

      ENDLOOP.
    ENDIF.
  ENDIF.
ENDIF.
