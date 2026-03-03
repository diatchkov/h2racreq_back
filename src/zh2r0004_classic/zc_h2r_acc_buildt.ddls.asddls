@EndUserText.label: 'Maintain Accomodation building text'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_H2R_ACC_BUILDT
  as projection on ZI_H2R_ACC_BUILDT
{
  @ObjectModel.text.element: [ 'LanguageName' ]
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_Language', 
      element: 'Language'
    }
  } ]
  key Spras,
  key Build,
  BuildName,
  @Consumption.hidden: true
  SingletonID,
  _LanguageText.LanguageName : localized,
  _AccBuild : redirected to parent ZC_H2R_ACC_BUILD,
  _AccBuildAll : redirected to ZC_H2R_ACC_BUILD_S
  
}
