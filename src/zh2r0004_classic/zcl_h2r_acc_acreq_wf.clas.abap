class ZCL_H2R_ACC_ACREQ_WF definition
  public
  final
  create public .

public section.

  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .

  data MV_REQID type SIBFINSTID .
  data MV_ACREQ type SYSUUID_C36 .
  constants:
    BEGIN OF mc_status,
        initial           TYPE zh2r_acc_status VALUE '00',
        create_fso        TYPE zh2r_acc_status VALUE '20',
        create_fsm        TYPE zh2r_acc_status VALUE '21',
        create_rejected   TYPE zh2r_acc_status VALUE '91',
        create_approved   TYPE zh2r_acc_status VALUE '92',
        checkin_fso       TYPE zh2r_acc_status VALUE '30',
        checkin_fsm       TYPE zh2r_acc_status VALUE '31',
        checkin_rejected  TYPE zh2r_acc_status VALUE '93',
        checkin_approved  TYPE zh2r_acc_status VALUE '94',
        checkout_fso      TYPE zh2r_acc_status VALUE '40',
        checkout_fsm      TYPE zh2r_acc_status VALUE '41',
        checkout_rejected TYPE zh2r_acc_status VALUE '95',
        checkout_approved TYPE zh2r_acc_status VALUE '96',
      END OF mc_status .
  constants:
    BEGIN OF mc_result,
        approved TYPE string VALUE 'APPROVED',
        rejected TYPE string VALUE 'REJECTED',
      END OF mc_result .
  constants MC_CLASS type SEOCLSNAME value 'ZCL_H2R_ACC_ACREQ_WF' ##NO_TEXT.
  constants:
    BEGIN OF mc_event,
        submit   TYPE sibfevent VALUE 'SUBMIT',
        restart  TYPE sibfevent VALUE 'RESTART',
        cancel   TYPE sibfevent VALUE 'CANCEL',
        approved TYPE sibfevent VALUE 'APPROVED',
        rejected TYPE sibfevent VALUE 'REJECTED',
      END OF mc_event .
  constants MC_INFO_TEMPLATE type SMTG_TMPL_ID value 'ZH2R0004_ACC_INFO' ##NO_TEXT.

  events SUBMIT .
  events RESTART .
  events CANCEL .
  events APPROVED
    exporting
      value(IV_AGENT) type SWP_AGENT
      value(IV_DECISION) type SWC_ELEM .
  events REJECTED
    exporting
      value(IV_AGENT) type SWP_AGENT
      value(IV_DECISION) type SWC_ELEM .

  methods CONSTRUCTOR
    importing
      !IS_LPOR type SIBFLPOR .
  methods SET_REJECTED_STATUS .
  methods SET_APPROVED_STATUS .
  methods SET_COMMENT
    importing
      !IV_COMMENT type SWC_VALUE .
  methods GET_SUBJECT
    returning
      value(RV_TEXT) type ZH2R_ACC_ACREQ_TEXT .
  methods GET_STATUS
    returning
      value(RV_STATUS) type ZH2R_ACC_STATUS .
  methods GET_INFO
    importing
      !IV_WIID type SWW_WIID
    returning
      value(RT_INFO) type SOLI_TAB .
protected section.
private section.

  data MS_LPOR type SIBFLPOR .
ENDCLASS.



CLASS ZCL_H2R_ACC_ACREQ_WF IMPLEMENTATION.


  METHOD bi_persistent~find_by_lpor.
    result ?= NEW zcl_h2r_acc_acreq_wf( is_lpor = lpor ).
  ENDMETHOD.


  METHOD bi_persistent~lpor.
    result = ms_lpor.
  ENDMETHOD.


  METHOD constructor.
    ms_lpor  = is_lpor.
    mv_reqid = is_lpor-instid.

    cl_system_uuid=>convert_uuid_c32_static(
      EXPORTING
        uuid     = mv_reqid
      IMPORTING
        uuid_c36 = mv_acreq ).
  ENDMETHOD.


  METHOD bi_object~execute_default_method.
  ENDMETHOD.


  METHOD bi_object~default_attribute_value.
  ENDMETHOD.


  METHOD bi_object~release.
  ENDMETHOD.


  METHOD bi_persistent~refresh.
  ENDMETHOD.


  METHOD set_approved_status.
    MODIFY ENTITIES OF zr_h2r_acc_acreq
      ENTITY h2raccrequest
      EXECUTE setapprovedstatus
      FROM VALUE #( (
        %key-accrequestid = mv_reqid ) ).

    COMMIT ENTITIES RESPONSE OF zr_h2r_acc_acreq
      REPORTED DATA(gm_reported)
      FAILED DATA(gm_failed).
  ENDMETHOD.


  METHOD set_comment.
    MODIFY ENTITIES OF zr_h2r_acc_acreq
      ENTITY h2raccrequest
      EXECUTE setcomment
      FROM VALUE #( (
        %key-accrequestid = mv_reqid
        %param            = iv_comment ) ).

    COMMIT ENTITIES RESPONSE OF zr_h2r_acc_acreq
      REPORTED DATA(gm_reported)
      FAILED DATA(gm_failed).
  ENDMETHOD.


  METHOD set_rejected_status.
    MODIFY ENTITIES OF zr_h2r_acc_acreq
      ENTITY h2raccrequest
      EXECUTE setrejectedstatus
      FROM VALUE #( (
        %key-accrequestid = mv_reqid ) ).

    COMMIT ENTITIES RESPONSE OF zr_h2r_acc_acreq
      REPORTED DATA(gm_reported)
      FAILED DATA(gm_failed).
  ENDMETHOD.


  METHOD get_status.
    READ ENTITIES OF zr_h2r_acc_acreq
      ENTITY h2raccrequest ALL FIELDS
        WITH VALUE #( ( accrequestid = mv_reqid ) )
      RESULT DATA(lt_acreq).

    rv_status = VALUE #( lt_acreq[ 1 ]-accstatus OPTIONAL ).
  ENDMETHOD.


  METHOD get_info.
    DATA(lo_email_api) = cl_smtg_email_api=>get_instance( iv_template_id = 'ZH2R0004_ACC_INFO' ).

    DATA(lt_keys) = VALUE if_smtg_email_template=>ty_gt_data_key( (
      name  = 'WorkflowTaskInternalID'
      value = iv_wiid ) ).

    TRY.
        lo_email_api->render(
          EXPORTING
            iv_language         = sy-langu
            it_data_key         = lt_keys
          IMPORTING
            ev_body_html        = DATA(lv_info) ).

        rt_info = cl_bcs_convert=>string_to_soli( iv_string = lv_info ).
      CATCH cx_smtg_email_common.
    ENDTRY.
  ENDMETHOD.


  METHOD get_subject.
    DATA(lv_status) = get_status( ).

    SELECT SINGLE RequestText
      FROM zc_h2r_acc_statusvh
     WHERE status EQ @lv_status
      INTO @rv_text.
  ENDMETHOD.
ENDCLASS.
