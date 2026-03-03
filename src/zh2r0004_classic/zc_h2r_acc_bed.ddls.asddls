@EndUserText.label: 'Maintain Accomodation bed'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_H2R_ACC_BED
  as projection on ZI_H2R_ACC_BED
{
  key Build,
  key Floor,
  key Apart,
  key Bed,
  Accid,
  Amount,
  Currency,
  CreateUser,
  CreateTmst,
  ChangeUser,
  ChangeTmst,
  @Consumption.hidden: true
  LocalChangeTmst,
  @Consumption.hidden: true
  SingletonID,
  _AccApartBedAll : redirected to parent ZC_H2R_ACC_BED_S
  
}
