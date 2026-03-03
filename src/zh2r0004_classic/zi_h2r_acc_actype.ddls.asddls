@EndUserText.label: 'Accomodation type'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_H2R_ACC_ACTYPE
  as select from ZTH2R_A_ACTYPE
  association to parent ZI_H2R_ACC_ACTYPE_S as _AccTypeAll on $projection.SingletonID = _AccTypeAll.SingletonID
  composition [0..*] of ZI_H2R_ACC_ACTYPT as _AccTypeText
{
  key ACTYPE as Actype,
  @Semantics.user.createdBy: true
  CREATE_USER as CreateUser,
  @Semantics.systemDateTime.createdAt: true
  CREATE_TMST as CreateTmst,
  @Semantics.user.lastChangedBy: true
  CHANGE_USER as ChangeUser,
  @Semantics.systemDateTime.lastChangedAt: true
  CHANGE_TMST as ChangeTmst,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_CHANGE_TMST as LocalChangeTmst,
  1 as SingletonID,
  _AccTypeAll,
  _AccTypeText
  
}
