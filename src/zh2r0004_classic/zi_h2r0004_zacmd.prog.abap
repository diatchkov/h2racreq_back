*&---------------------------------------------------------------------*
*& Include ZI_H2R0004_ZACMD
*&---------------------------------------------------------------------*

FORM fuzacmd.
  DATA lr_status TYPE RANGE OF zh2r_acc_status.

  DATA(lv_user) = VALUE syuname( ).

  CALL FUNCTION 'HR_GET_USER_FROM_EMPLOYEE'
    EXPORTING
      pernr             = pernr-pernr
      begda             = pn-begda
      endda             = pn-endda
      iv_with_authority = abap_false
    IMPORTING
      user              = lv_user.

  lr_status = VALUE #( (
    sign   = if_salv_bs_c_filter=>sign_including
    option = if_salv_bs_c_filter=>operator_eq
    low    = zcl_h2r_acc_acreq_wf=>mc_status-checkin_approved ) (
    sign   = if_salv_bs_c_filter=>sign_including
    option = if_salv_bs_c_filter=>operator_eq
    low    = zcl_h2r_acc_acreq_wf=>mc_status-checkout_fso ) (
    sign   = if_salv_bs_c_filter=>sign_including
    option = if_salv_bs_c_filter=>operator_eq
    low    = zcl_h2r_acc_acreq_wf=>mc_status-checkout_fsm ) (
    sign   = if_salv_bs_c_filter=>sign_including
    option = if_salv_bs_c_filter=>operator_eq
    low    = zcl_h2r_acc_acreq_wf=>mc_status-checkout_rejected ) (
    sign   = if_salv_bs_c_filter=>sign_including
    option = if_salv_bs_c_filter=>operator_eq
    low    = zcl_h2r_acc_acreq_wf=>mc_status-checkout_approved ) ).

  SELECT req~accuser, req~accstatus, req~accbuild, req~accfloor, req~accapart,
         req~accbed, bed~accid, bed~amount, bed~currency, req~changetmst
    FROM zr_h2r_acc_acreq AS req
    JOIN zc_h2r_acc_bed AS bed
      ON bed~build EQ req~accbuild
     AND bed~floor EQ req~accfloor
     AND bed~apart EQ req~accapart
     AND bed~bed   EQ req~accbed
   WHERE req~accuser   EQ @lv_user
     AND req~accstatus IN @lr_status
     INTO TABLE @DATA(lt_accommodations).

  DATA(lv_acmd_lgart) = CONV lgart( zcl_asas_tvarv_constant=>get_value( iv_name = 'ZH2R0004_ACMD_LGART' ) ).
  DATA(ls_wpbp)       = VALUE #( wpbp[ lines( wpbp[] ) ] OPTIONAL ).

  LOOP AT lt_accommodations ASSIGNING FIELD-SYMBOL(<accommodation>).
    DATA(lv_coeff) = VALUE float( ).

    CASE <accommodation>-accstatus.
      WHEN zcl_h2r_acc_acreq_wf=>mc_status-checkout_approved.
        CONVERT TIME STAMP <accommodation>-changetmst TIME ZONE sy-zonlo
           INTO DATE DATA(lv_endda).

        IF lv_endda GT pn-endda.
          lv_endda = pn-endda.
        ENDIF.

        lv_coeff = ( lv_endda - pn-begda + 1 ) / ( pn-endda - pn-begda + 1 ). " +1 means include the last day

      WHEN zcl_h2r_acc_acreq_wf=>mc_status-checkin_approved.
        CONVERT TIME STAMP <accommodation>-changetmst TIME ZONE sy-zonlo
           INTO DATE DATA(lv_begda).

        IF lv_begda LT pn-begda.
          lv_begda = pn-begda.
        ENDIF.

        lv_coeff = ( pn-endda - lv_begda + 1 ) / ( pn-endda - pn-begda + 1 ). " +1 means include the last day

      WHEN OTHERS.
        lv_coeff = 1.

    ENDCASE.

    IF lv_coeff LT 0.
      CONTINUE.
    ENDIF.

    DATA(ls_rt) = VALUE pc207(
      abart = 3
      apznr = ls_wpbp-apznr
      lgart = lv_acmd_lgart
      betrg = <accommodation>-amount * lv_coeff * ( -1 ) ).

    INSERT ls_rt
      INTO TABLE rt[].
  ENDLOOP.
ENDFORM.
