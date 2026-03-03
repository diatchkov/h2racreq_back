@EndUserText.label: 'Accomodation apartment'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_H2R_ACC_APART
  as select from zth2r_a_apart
  association [1..1] to ZC_H2R_ACC_BUILD as _Build on _Build.Build = $projection.Build
  association [1..1] to ZC_H2R_ACC_FLOOR as _Floor on _Floor.Build = $projection.Build and _Floor.Floor = $projection.Floor
  association [1..1] to ZC_H2R_ACC_APART_TYPEVH as _ApartType on _ApartType.Type = $projection.Atype
  association to parent ZI_H2R_ACC_APART_S as _AccApartAll on $projection.SingletonID = _AccApartAll.SingletonID
{
  key build as Build,
  key floor as Floor,
  key apart as Apart,
  atype as Atype,
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
  _AccApartAll,
  _Build,
  _Floor,
  _ApartType
}
