CLASS lhc_h2raccrequest DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR h2raccrequest RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR h2raccrequest RESULT result.

    METHODS setstatus FOR MODIFY
      IMPORTING keys FOR ACTION h2raccrequest~setstatus.

    METHODS oncreate FOR DETERMINE ON MODIFY
      IMPORTING keys FOR h2raccrequest~oncreate.

    METHODS setcomment FOR MODIFY
      IMPORTING keys FOR ACTION h2raccrequest~setcomment.

    METHODS checkin FOR MODIFY
      IMPORTING keys FOR ACTION h2raccrequest~checkin.

    METHODS checkout FOR MODIFY
      IMPORTING keys FOR ACTION h2raccrequest~checkout.
    METHODS setapprovedstatus FOR MODIFY
      IMPORTING keys FOR ACTION h2raccrequest~setapprovedstatus.

    METHODS setrejectedstatus FOR MODIFY
      IMPORTING keys FOR ACTION h2raccrequest~setrejectedstatus.

    METHODS approval FOR MODIFY
      IMPORTING keys FOR ACTION h2raccrequest~approval.

ENDCLASS.

CLASS lhc_h2raccrequest IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.
    TYPES ts_result TYPE STRUCTURE FOR INSTANCE FEATURES RESULT zr_h2r_acc_acreq\\h2raccrequest.

    READ ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
       ENTITY h2raccrequest ALL FIELDS
       WITH CORRESPONDING #( keys )
       RESULT DATA(lt_acreq).

    LOOP AT lt_acreq ASSIGNING FIELD-SYMBOL(<acreq>).
      DATA(ls_result) = VALUE ts_result(
        %tky    = <acreq>-%tky

        %delete = COND #(
          WHEN <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-initial
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-create_rejected
          THEN if_abap_behv=>fc-f-unrestricted
          ELSE if_abap_behv=>fc-f-read_only )

        %action-edit = COND #(
          WHEN <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-initial
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-create_rejected
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-create_approved
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-checkin_rejected
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-checkin_approved
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-checkout_rejected
          THEN if_abap_behv=>fc-f-unrestricted
          ELSE if_abap_behv=>fc-f-read_only )

        %action-approval = COND #(
          WHEN ( <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-initial
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-create_rejected )
           AND <acreq>-%is_draft = if_abap_behv=>mk-off
          THEN if_abap_behv=>fc-f-unrestricted
          ELSE if_abap_behv=>fc-f-read_only )

        %action-checkin = COND #(
          WHEN (  <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-create_approved
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-checkin_rejected )
           AND <acreq>-%is_draft = if_abap_behv=>mk-off
          THEN if_abap_behv=>fc-f-unrestricted
          ELSE if_abap_behv=>fc-f-read_only )

        %action-checkout = COND #(
          WHEN ( <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-checkin_approved
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-checkout_rejected )
           AND <acreq>-%is_draft = if_abap_behv=>mk-off
          THEN if_abap_behv=>fc-f-unrestricted
          ELSE if_abap_behv=>fc-f-read_only )

        %field-accpersonnotes = COND #(
          WHEN <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-initial
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-create_rejected
          THEN if_abap_behv=>fc-f-unrestricted
          ELSE if_abap_behv=>fc-f-read_only )

        %field-cinpersonnotes = COND #(
          WHEN <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-create_approved
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-checkin_rejected
          THEN if_abap_behv=>fc-f-unrestricted
          ELSE if_abap_behv=>fc-f-read_only )

        %field-coutpersonnotes = COND #(
          WHEN <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-checkin_approved
            OR <acreq>-accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-checkout_rejected
          THEN if_abap_behv=>fc-f-unrestricted
          ELSE if_abap_behv=>fc-f-read_only ) ).

      INSERT ls_result
        INTO TABLE result.
    ENDLOOP.
  ENDMETHOD.

  METHOD setstatus.
    READ ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_acreq).

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
      READ TABLE lt_acreq ASSIGNING FIELD-SYMBOL(<acreq>) WITH KEY entity COMPONENTS
        %key = <key>-%key.
      CHECK sy-subrc EQ 0.
      <acreq>-accstatus = <key>-%param.
    ENDLOOP.

    MODIFY ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest
      UPDATE FIELDS ( accstatus )
      WITH VALUE #(
        FOR acreq IN lt_acreq (
          %tky      = acreq-%tky
          accstatus = acreq-accstatus ) ).
  ENDMETHOD.

  METHOD oncreate.
    READ ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_acreq).

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
      READ TABLE lt_acreq ASSIGNING FIELD-SYMBOL(<acreq>) WITH KEY entity COMPONENTS
        %key = <key>-%key.
      CHECK sy-subrc EQ 0.
      <acreq>-accuser = sy-uname.
    ENDLOOP.

    MODIFY ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest
      UPDATE FIELDS ( accuser )
      WITH VALUE #(
        FOR acreq IN lt_acreq (
          %tky    = acreq-%tky
          accuser = acreq-accuser ) ).
  ENDMETHOD.

  METHOD setcomment.
    READ ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_acreq).

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
      READ TABLE lt_acreq ASSIGNING FIELD-SYMBOL(<acreq>) WITH KEY entity COMPONENTS
        %key = <key>-%key.
      CHECK sy-subrc EQ 0.

      CASE <acreq>-accstatus.
        WHEN zcl_h2r_acc_acreq_wf=>mc_status-create_fso.
          <acreq>-accofficernotes = <key>-%param.
        WHEN zcl_h2r_acc_acreq_wf=>mc_status-create_fsm.
          <acreq>-accmanagernotes = <key>-%param.
        WHEN zcl_h2r_acc_acreq_wf=>mc_status-checkin_fso.
          <acreq>-cinofficernotes = <key>-%param.
        WHEN zcl_h2r_acc_acreq_wf=>mc_status-checkin_fsm.
          <acreq>-cinmanagernotes = <key>-%param.
        WHEN zcl_h2r_acc_acreq_wf=>mc_status-checkout_fso.
          <acreq>-coutofficernotes = <key>-%param.
        WHEN zcl_h2r_acc_acreq_wf=>mc_status-checkout_fsm.
          <acreq>-coutmanagernotes = <key>-%param.
      ENDCASE.
    ENDLOOP.

    MODIFY ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest
      UPDATE FIELDS (
        accofficernotes  accmanagernotes
        cinofficernotes  cinmanagernotes
        coutofficernotes coutmanagernotes )
      WITH VALUE #(
        FOR acreq IN lt_acreq (
          %tky      = acreq-%tky
          accofficernotes  = acreq-accofficernotes
          accmanagernotes  = acreq-accmanagernotes
          cinofficernotes  = acreq-cinofficernotes
          cinmanagernotes  = acreq-cinmanagernotes
          coutofficernotes = acreq-coutofficernotes
          coutmanagernotes = acreq-coutmanagernotes ) ).
  ENDMETHOD.

  METHOD checkin.
    MODIFY ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest
      EXECUTE setapprovedstatus
      FROM CORRESPONDING #( keys ).
  ENDMETHOD.

  METHOD checkout.
    MODIFY ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest
      EXECUTE setapprovedstatus
      FROM CORRESPONDING #( keys ).
  ENDMETHOD.

  METHOD approval.
    MODIFY ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest
      EXECUTE setapprovedstatus
      FROM CORRESPONDING #( keys ).
  ENDMETHOD.

  METHOD setapprovedstatus.
    READ ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest FIELDS (  accrequestid accstatus )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_acreq).

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
      READ TABLE lt_acreq ASSIGNING FIELD-SYMBOL(<acreq>) WITH KEY entity COMPONENTS
        %key = <key>-%key.
      CHECK sy-subrc EQ 0.

      DATA(lv_status) = VALUE zh2r_acc_status( ).

      zcl_asas_utilities_brf=>get_instance( )->process_function(
        EXPORTING
          iv_application_name = 'ZH2R0004_ACC_ACREQ'
          iv_function_name    = 'ACC_GET_NEXT_STATUS'
          it_parameter        = VALUE #(
            ( name = 'SCHEME' value = 'DEFAULT' )
            ( name = 'STATUS' value = <acreq>-accstatus )
            ( name = 'ACTION' value = '01' ) )
        IMPORTING
          e_data              = lv_status ).

      <acreq>-accstatus = lv_status.
    ENDLOOP.

    MODIFY ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest
      UPDATE FIELDS ( accstatus )
      WITH VALUE #(
        FOR acreq IN lt_acreq (
          %tky      = acreq-%tky
          accstatus = acreq-accstatus ) ).
  ENDMETHOD.

  METHOD setrejectedstatus.
    READ ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest FIELDS (  accrequestid accstatus )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_acreq).

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
      READ TABLE lt_acreq ASSIGNING FIELD-SYMBOL(<acreq>) WITH KEY entity COMPONENTS
        %key = <key>-%key.
      CHECK sy-subrc EQ 0.

      DATA(lv_status) = VALUE zh2r_acc_status( ).

      zcl_asas_utilities_brf=>get_instance( )->process_function(
        EXPORTING
          iv_application_name = 'ZH2R0004_ACC_ACREQ'
          iv_function_name    = 'ACC_GET_NEXT_STATUS'
          it_parameter        = VALUE #(
            ( name = 'SCHEME' value = 'DEFAULT' )
            ( name = 'STATUS' value = <acreq>-accstatus )
            ( name = 'ACTION' value = '02' ) )
        IMPORTING
          e_data              = lv_status ).

      <acreq>-accstatus = lv_status.
    ENDLOOP.

    MODIFY ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest
      UPDATE FIELDS ( accstatus )
      WITH VALUE #(
        FOR acreq IN lt_acreq (
          %tky      = acreq-%tky
          accstatus = acreq-accstatus ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zr_h2r_acc_acreq DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zr_h2r_acc_acreq IMPLEMENTATION.

  METHOD save_modified.
    DATA(lt_acreq) = VALUE ztth2r0004_acc_status( ).

    LOOP AT create-h2raccrequest ASSIGNING FIELD-SYMBOL(<acreq_ins>).
      APPEND VALUE #( reqid = <acreq_ins>-accrequestid ) TO lt_acreq.
    ENDLOOP.

    LOOP AT update-h2raccrequest ASSIGNING FIELD-SYMBOL(<acreq_upd>).
      APPEND VALUE #( reqid = <acreq_upd>-accrequestid ) TO lt_acreq.
    ENDLOOP.

    READ ENTITIES OF zr_h2r_acc_acreq IN LOCAL MODE
      ENTITY h2raccrequest FIELDS (  accrequestid accstatus )
      WITH VALUE #(
        FOR acreq IN lt_acreq ( %key-accrequestid = acreq-reqid ) )
      RESULT DATA(lt_requests).

    LOOP AT lt_requests ASSIGNING FIELD-SYMBOL(<request>)
      WHERE accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-create_fso
         OR accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-checkin_fso
         OR accstatus EQ zcl_h2r_acc_acreq_wf=>mc_status-checkout_fso.
      TRY.
          cl_swf_evt_event=>raise_in_update_task(
            im_objcateg        = cl_swf_evt_event=>mc_objcateg_cl
            im_objtype         = zcl_h2r_acc_acreq_wf=>mc_class
            im_event           = zcl_h2r_acc_acreq_wf=>mc_event-submit
            im_objkey          = CONV #( <request>-accrequestid ) ).
        CATCH cx_swf_evt_invalid_objtype.
        CATCH cx_swf_evt_invalid_event.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
