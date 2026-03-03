class ZCL_H2R_ACC_ACREQ_WF_RUN definition
  public
  inheriting from CL_SWF_FLEX_IFS_RUN_APPL_BASE
  final
  create public .

public section.

  methods IF_SWF_FLEX_IFS_RUN_APPL_STEP~AFTER_COMPLETION_CALLBACK
    redefinition .
  methods IF_SWF_FLEX_IFS_RUN_APPL~RESULT_CALLBACK
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_H2R_ACC_ACREQ_WF_RUN IMPLEMENTATION.


  METHOD if_swf_flex_ifs_run_appl_step~after_completion_callback.
    DATA(lt_result) = io_current_activity->get_execution_results( ).
    DATA(lv_result) = VALUE #( lt_result[ 1 ]-result OPTIONAL ).

    DATA(lo_task_container) = io_context->get_task_container( ).

    DATA(lo_request) = NEW zcl_h2r_acc_acreq_wf( is_lpor = VALUE #( ) ).
    DATA(lv_comment) = VALUE swc_value( ).

    TRY.
        lo_task_container->get(
          EXPORTING
            name       = 'ACCREQUEST'
          IMPORTING
            value      = lo_request ).

        DATA(ls_lpor) = lo_request->if_workflow~lpor( ).

        lo_task_container->get(
          EXPORTING
            name       = 'ACTION_COMMENTS'
          IMPORTING
            value      = lv_comment ).
      CATCH cx_swf_cnt_elem_not_found.
      CATCH cx_swf_cnt_elem_type_conflict.
    ENDTRY.

    CHECK lo_request IS BOUND.

    " to avoid __AFTER_SET_UPD_TASK_LOCAL error in RAP use RFC modules

    CASE lv_result.
      WHEN zcl_h2r_acc_acreq_wf=>mc_result-approved.
        CALL FUNCTION 'Z_H2R0004_SET_APPROVED_STATUS' DESTINATION 'NONE'
          EXPORTING
            is_lpor = ls_lpor.

      WHEN zcl_h2r_acc_acreq_wf=>mc_result-rejected.
        CALL FUNCTION 'Z_H2R0004_SET_REJECTED_STATUS' DESTINATION 'NONE'
          EXPORTING
            is_lpor    = ls_lpor
            iv_comment = lv_comment.
    ENDCASE.
  ENDMETHOD.


  METHOD if_swf_flex_ifs_run_appl~result_callback.
    DATA(ls_result) = io_result->get_result( ).
    ev_outcome = ls_result-result.
  ENDMETHOD.
ENDCLASS.
