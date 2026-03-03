@EndUserText.label: 'Maintain Accomodation type'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_H2R_ACC_ACTYPE
  as projection on ZI_H2R_ACC_ACTYPE
{
  key Actype,
  CreateUser,
  CreateTmst,
  ChangeUser,
  ChangeTmst,
  @Consumption.hidden: true
  LocalChangeTmst,
  @Consumption.hidden: true
  SingletonID,
  _AccTypeAll : redirected to parent ZC_H2R_ACC_ACTYPE_S,
  _AccTypeText : redirected to composition child ZC_H2R_ACC_ACTYPT,
  _AccTypeText.ActypeText : localized
  
}
