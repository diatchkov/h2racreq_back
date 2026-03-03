FUNCTION z_h2r0004_set_approved_status.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_LPOR) TYPE  SIBFLPOR
*"----------------------------------------------------------------------

  DATA(lo_request) = NEW zcl_h2r_acc_acreq_wf( is_lpor = is_lpor ).
  lo_request->set_approved_status( ).

ENDFUNCTION.
