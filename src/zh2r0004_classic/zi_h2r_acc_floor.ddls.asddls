@EndUserText.label: 'Accomodation floor'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_H2R_ACC_FLOOR
  as select from zth2r_a_floor
  association [1..1] to ZC_H2R_ACC_BUILD as _Build on _Build.Build = $projection.Build
  association to parent ZI_H2R_ACC_FLOOR_S as _AccFloorAll on $projection.SingletonID = _AccFloorAll.SingletonID
{ 
  key build as Build,
  key floor as Floor,
  @Semantics.user.createdBy: true
  create_user as CreateUser,
  @Semantics.systemDateTime.createdAt: true
  create_tmst as CreateTmst,
  @Semantics.user.lastChangedBy: true
  change_user as ChangeUser,
  @Semantics.systemDateTime.lastChangedAt: true
  change_tmst as ChangeTmst,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_change_tmst as LocalChangeTmst,
  1 as SingletonID,
  _AccFloorAll,
  _Build
}
