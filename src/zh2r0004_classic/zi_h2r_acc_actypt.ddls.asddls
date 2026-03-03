@EndUserText.label: 'Accomodation type text'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.dataCategory: #TEXT
define view entity ZI_H2R_ACC_ACTYPT
  as select from ZTH2R_A_ACTYPT
  association [1..1] to ZI_H2R_ACC_ACTYPE_S as _AccTypeAll on $projection.SingletonID = _AccTypeAll.SingletonID
  association to parent ZI_H2R_ACC_ACTYPE as _AccType on $projection.Actype = _AccType.Actype
  association [0..*] to I_LanguageText as _LanguageText on $projection.Spras = _LanguageText.LanguageCode
{
  @Semantics.language: true
  key SPRAS as Spras,
  key ACTYPE as Actype,
  @Semantics.text: true
  ACTYPE_TEXT as ActypeText,
  1 as SingletonID,
  _AccTypeAll,
  _AccType,
  _LanguageText
  
}
