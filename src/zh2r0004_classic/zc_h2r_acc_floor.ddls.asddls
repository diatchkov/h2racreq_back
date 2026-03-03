@EndUserText.label: 'Maintain Accomodation floor'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_H2R_ACC_FLOOR
  as projection on ZI_H2R_ACC_FLOOR
{
  @Consumption.valueHelpDefinition: [{
     entity: {
         name: 'ZC_H2R_ACC_BUILDVH',
         element: 'AccBuild'
     },
     distinctValues: true
  }]

  @ObjectModel.text.element: [ 'BuildName' ]
  @UI.textArrangement: #TEXT_FIRST 
  key Build,     
  key Floor,
  @UI.hidden: true
  _Build._AccBuildText.BuildName as BuildName : localized,
  CreateUser,
  CreateTmst,
  ChangeUser,
  ChangeTmst,
  @Consumption.hidden: true
  LocalChangeTmst,
  @Consumption.hidden: true
  SingletonID,
  _AccFloorAll : redirected to parent ZC_H2R_ACC_FLOOR_S
}
