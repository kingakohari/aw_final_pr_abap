"! @testing BDEF:ZLHT_R_EL_ROOT
CLASS ltcl_zlht DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    CLASS-DATA:
      class_under_test     TYPE REF TO lhc_Root_Behavior,
      go_client_proxy      TYPE REF TO /iwbep/if_cp_client_proxy,
      cds_test_environment TYPE REF TO if_cds_test_environment,
      sql_test_environment TYPE REF TO if_osql_test_environment,
      cds_mock_data        TYPE STANDARD TABLE OF zlht_r_el_root.
    CLASS-METHODS:
      class_setup,
      class_teardown.
    METHODS:
      setup,
      teardown,
      test FOR TESTING.
ENDCLASS.


CLASS ltcl_zlht IMPLEMENTATION.
  METHOD class_setup.
    CREATE OBJECT class_under_test FOR TESTING.
    " Erstellt Testdouble der Datenbanktabelle der angegebenen View
    " OpenSQL-Aufrufe des Testdoubles sind durch create_for_multiple_cds automatisch aktiviert
    cds_test_environment = cl_cds_test_environment=>create_for_multiple_cds(
                                i_for_entities = VALUE #( ( i_for_entity = 'ZLHT_R_EL_ROOT' ) ) ).
    cds_mock_data = VALUE #( ( mykey = '1'
                               locationname = 'Restaurant' ) ).
*    cds_test_environment->insert_test_data( cds_mock_data ).
  ENDMETHOD.

  METHOD class_teardown.
    cds_test_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    cds_test_environment->clear_doubles(  ).
  ENDMETHOD.

  METHOD teardown.
    ROLLBACK ENTITIES.
  ENDMETHOD.

  METHOD test.

  ENDMETHOD.
ENDCLASS.
