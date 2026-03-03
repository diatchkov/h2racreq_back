FUNCTION z_h2r0004_set_rejected_status.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_LPOR) TYPE  SIBFLPOR
*"     VALUE(IV_COMMENT) TYPE  SWC_VALUE
*"----------------------------------------------------------------------

  DATA(lo_request) = NEW zcl_h2r_acc_acreq_wf( is_lpor = is_lpor ).
  lo_request->set_comment( iv_comment = iv_comment ).
  lo_request->set_rejected_status( ).
ENDFUNCTION.
