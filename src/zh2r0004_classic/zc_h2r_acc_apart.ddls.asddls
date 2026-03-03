@EndUserText.label: 'Maintain Accomodation apartment'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_H2R_ACC_APART
  as projection on ZI_H2R_ACC_APART
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
  @Consumption.valueHelpDefinition: [{
     entity: {
       name: 'ZC_H2R_ACC_FLOORVH',
       element: 'AccFloor'
     },
     distinctValues: true,
     
     additionalBinding: [{ 
       element: 'AccBuild',
       localElement: 'Build',
       usage: #FILTER }]
  }]  
  key Floor,
  key Apart,
  
  @UI.hidden: true
  _Build._AccBuildText.BuildName as BuildName : localized,  
  
  @Consumption.valueHelpDefinition: [{
     entity: {
       name: 'ZC_H2R_ACC_APART_TYPEVH',
       element: 'Type'
     },
     distinctValues: true
  }]   
  
  @ObjectModel.text.element: [ 'ApartTypeText' ]
  @UI.textArrangement: #TEXT_FIRST  
  Atype, 
  
  _ApartType.TypeText as ApartTypeText,
    
  CreateUser,
  CreateTmst,
  ChangeUser,
  ChangeTmst,
  @Consumption.hidden: true
  LocalChangeTmst,
  @Consumption.hidden: true
  SingletonID,
  _AccApartAll : redirected to parent ZC_H2R_ACC_APART_S
  
}
