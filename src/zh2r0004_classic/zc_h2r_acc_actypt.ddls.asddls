@EndUserText.label: 'Maintain Accomodation type text'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_H2R_ACC_ACTYPT
  as projection on ZI_H2R_ACC_ACTYPT
{
  @ObjectModel.text.element: [ 'LanguageName' ]
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_Language', 
      element: 'Language'
    }
  } ]
  key Spras,
  key Actype,
  ActypeText,
  @Consumption.hidden: true
  SingletonID,
  _LanguageText.LanguageName : localized,
  _AccType : redirected to parent ZC_H2R_ACC_ACTYPE,
  _AccTypeAll : redirected to ZC_H2R_ACC_ACTYPE_S
  
}
