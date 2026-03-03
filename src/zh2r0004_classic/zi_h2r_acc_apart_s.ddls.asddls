@EndUserText.label: 'Accomodation apartment singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_H2R_ACC_APART_S
  as select from I_Language
    left outer join ZTH2R_A_APART on 0 = 0
  composition [0..*] of ZI_H2R_ACC_APART as _AccApart
{
  key 1 as SingletonID,
  _AccApart,
  max( ZTH2R_A_APART.CHANGE_TMST ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
