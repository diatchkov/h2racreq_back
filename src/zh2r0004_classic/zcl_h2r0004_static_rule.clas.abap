class ZCL_H2R0004_STATIC_RULE definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_RSM_BADI_STATIC_RULE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_H2R0004_STATIC_RULE IMPLEMENTATION.


  METHOD if_rsm_badi_static_rule~responsibility_rule.
    DATA(ls_error_message) = VALUE scx_t100key( ).

    TRY.
        DATA(lv_request_id) = VALUE sysuuid_x16( ).
        DATA(ls_param)      = it_parameter_name_value_pair[ name = 'ACCREQUESTID' ].

        lv_request_id = ls_param-value->*.

        DATA(lo_request) = NEW zcl_h2r_acc_acreq_wf(
          is_lpor = VALUE #(
            instid = lv_request_id
            typeid = 'ZCL_H2R_ACC_ACREQ_WF'
            catid  = cl_swf_evt_event=>mc_objcateg_cl ) ).

        DATA(lv_status) = lo_request->get_status( ).
        DATA(lt_actors) = VALUE tswhactor( ).

        zcl_asas_utilities_brf=>get_instance( )->process_function(
          EXPORTING
            iv_application_name = 'ZH2R0004_ACC_ACREQ'
            iv_function_name    = 'ACC_GET_AGENTS'
            it_parameter        = VALUE #(
              ( name = 'SCHEME' value = 'DEFAULT' )
              ( name = 'STATUS' value = lv_status ) )
          IMPORTING
            e_data              = lt_actors ).

        et_agents = VALUE #( FOR <actor> IN lt_actors WHERE ( otype EQ cl_hrpiq00const=>c_otype_us ) ( <actor>-objid ) ).
      CATCH cx_sy_itab_line_not_found.
        ls_error_message = VALUE #(
          msgid = 'ZH2R_0004_CLASSIC'
          msgno = 002
          attr1 = lv_request_id ).

        RAISE EXCEPTION TYPE cx_rsm_agt_detn_tech_exception
          EXPORTING
            textid = ls_error_message.
    ENDTRY.

    IF et_agents IS INITIAL.
      ls_error_message = VALUE #(
        msgid = 'ZH2R_0004_CLASSIC'
        msgno = 001
        attr1 = lv_request_id
        attr2 = lv_status ).

      RAISE EXCEPTION TYPE cx_rsm_agt_detn_busi_exception
        EXPORTING
          textid = ls_error_message.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
