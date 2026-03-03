@EndUserText.label: 'Accomodation building'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_H2R_ACC_BUILD
  as select from ZTH2R_A_BUILD
  association to parent ZI_H2R_ACC_BUILD_S as _AccBuildAll on $projection.SingletonID = _AccBuildAll.SingletonID
  composition [0..*] of ZI_H2R_ACC_BUILDT as _AccBuildText
{
  key BUILD as Build,
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
  _AccBuildAll,
  _AccBuildText
  
}
