CLASS zlht_cl_pict DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zlht_cl_pict IMPLEMENTATION.

METHOD  if_sadl_exit_calc_element_read~calculate.

    DATA picture TYPE STANDARD TABLE OF zlht_c_el_proj WITH DEFAULT KEY.
                    picture = CORRESPONDING #( it_original_data ).

    LOOP AT picture ASSIGNING FIELD-SYMBOL(<locationname>).
      <locationname>-LocImageURL = 'https://images.pexels.com/photos/6210904/pexels-photo-6210904.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( picture ).
  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    ENDMETHOD.

ENDCLASS.
