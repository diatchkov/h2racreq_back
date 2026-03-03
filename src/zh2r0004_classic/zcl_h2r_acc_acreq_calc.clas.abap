class ZCL_H2R_ACC_ACREQ_CALC definition
  public
  final
  create public .

public section.

  interfaces IF_SADL_EXIT .
  interfaces IF_SADL_EXIT_CALC_ELEMENT_READ .

  constants MC_PROBATION_END type DATAR value '07' ##NO_TEXT.
protected section.
private section.

  methods GET_DEPARTMENT
    importing
      !IV_ORGEH type ORGEH
    returning
      value(RV_NAME) type STEXT .
  methods GET_HIRE_DATE
    importing
      !IV_PERNR type PERNR_D
    returning
      value(RV_HIRE) type DATUM .
  methods GET_PROBATION_END
    importing
      !IV_PERNR type PERNR_D
    returning
      value(RV_PROBATION_END) type DATUM .
ENDCLASS.



CLASS ZCL_H2R_ACC_ACREQ_CALC IMPLEMENTATION.


METHOD if_sadl_exit_calc_element_read~calculate.
  LOOP AT it_original_data ASSIGNING FIELD-SYMBOL(<orig>).
    TRY.
        DATA(calc) = REF #( ct_calculated_data[ sy-tabix ] ).
        ASSIGN COMPONENT 'ACCEMPLOYEE' OF STRUCTURE <orig> TO FIELD-SYMBOL(<pernr>).
        ASSIGN COMPONENT 'ACCEMPLOYEEORGUNIT' OF STRUCTURE <orig> TO FIELD-SYMBOL(<orgeh>).
      CATCH cx_sy_itab_line_not_found.
        CONTINUE.
    ENDTRY.

    DATA(lv_pernr) = CONV pernr_d( <pernr> ).
    DATA(lv_orgeh) = CONV orgeh( <orgeh> ).

    LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<field>).
      ASSIGN COMPONENT <field> OF STRUCTURE calc->* TO FIELD-SYMBOL(<calc_field>).
      CHECK sy-subrc EQ 0.

      CASE <field>.
        WHEN 'ACCEMPLOYEEORGUNITNAME'.
          <calc_field> = get_department( iv_orgeh = lv_orgeh ).
        WHEN 'ACCEMPLOYEEJOINDATE'.
          <calc_field> = get_hire_date( iv_pernr = lv_pernr ).
        WHEN 'ACCEMPLOYEEPROBATIONEND'.
          <calc_field> = get_probation_end( iv_pernr = lv_pernr ).
      ENDCASE.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.


METHOD if_sadl_exit_calc_element_read~get_calculation_info.
ENDMETHOD.


  METHOD get_department.
    DATA(lt_units) = VALUE objec_t( ).

    CALL FUNCTION 'HRCM_ORGUNIT_MANAGER_GET'
      EXPORTING
        plvar              = cl_hrpiq00const=>c_plvar_active
        otype              = cl_hrpiq00const=>c_otype_o
        objid              = iv_orgeh
        begda              = sy-datum
        endda              = sy-datum
        path_id            = 'A002'
      TABLES
        manager_info_table = lt_units
      EXCEPTIONS
        OTHERS             = 0.

    rv_name = VALUE #( lt_units[ 1 ]-stext OPTIONAL ).
  ENDMETHOD.


  METHOD get_hire_date.
    CALL FUNCTION 'RP_GET_HIRE_DATE'
      EXPORTING
        persnr          = iv_pernr
        check_infotypes = '0000,0001,0041'
      IMPORTING
        hiredate        = rv_hire.
  ENDMETHOD.


  METHOD get_probation_end.
    TYPES:
      BEGIN OF ts_date,
        dar TYPE  datar,
        dat TYPE  dardt,
      END OF ts_date.

    TRY.
        DATA(ls_dates) = VALUE p0041( ).

        cl_hrpa_read_infotype=>get_instance( IMPORTING infotype_reader = DATA(lo_reader) ).

        lo_reader->read_single(
          EXPORTING
            tclas         = 'A'
            pernr         = iv_pernr
            infty         = '0041'
            subty         = space
            objps         = space
            sprps         = abap_false
            begda         = sy-datum
            endda         = sy-datum
            mode          = '0'
            no_auth_check = abap_true
          IMPORTING
            pnnnn         = ls_dates ).

        DATA(ls_date) = VALUE ts_date( ).

        DO if_hrpa_constants=>gc_number_of_date_types_it0041 TIMES
          VARYING ls_date-dar FROM ls_dates-dar01 NEXT ls_dates-dar02
          VARYING ls_date-dat FROM ls_dates-dat01 NEXT ls_dates-dat02.

          IF ls_date-dar EQ mc_probation_end.
            rv_probation_end = ls_date-dat.
            EXIT.
          ENDIF.
        ENDDO.

      CATCH cx_root.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
