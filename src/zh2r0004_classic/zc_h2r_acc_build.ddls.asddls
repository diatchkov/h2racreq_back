@EndUserText.label: 'Maintain Accomodation building'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_H2R_ACC_BUILD
  as projection on ZI_H2R_ACC_BUILD
{
  key Build,
  CreateUser,
  CreateTmst,
  ChangeUser,
  ChangeTmst,
  @Consumption.hidden: true
  LocalChangeTmst,
  @Consumption.hidden: true
  SingletonID,
  _AccBuildAll : redirected to parent ZC_H2R_ACC_BUILD_S,
  _AccBuildText : redirected to composition child ZC_H2R_ACC_BUILDT,
  _AccBuildText.BuildName : localized
  
}
