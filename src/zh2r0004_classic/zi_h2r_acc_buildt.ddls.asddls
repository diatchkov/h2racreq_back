@EndUserText.label: 'Accomodation building text'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.dataCategory: #TEXT
define view entity ZI_H2R_ACC_BUILDT
  as select from ZTH2R_A_BUILDT
  association [1..1] to ZI_H2R_ACC_BUILD_S as _AccBuildAll on $projection.SingletonID = _AccBuildAll.SingletonID
  association to parent ZI_H2R_ACC_BUILD as _AccBuild on $projection.Build = _AccBuild.Build
  association [0..*] to I_LanguageText as _LanguageText on $projection.Spras = _LanguageText.LanguageCode
{
  @Semantics.language: true
  key SPRAS as Spras,
  key BUILD as Build,
  @Semantics.text: true
  BUILD_NAME as BuildName,
  1 as SingletonID,
  _AccBuildAll,
  _AccBuild,
  _LanguageText
  
}
