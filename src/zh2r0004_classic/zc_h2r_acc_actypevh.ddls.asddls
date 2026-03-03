@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accomodation: type VH'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
@ObjectModel.representativeKey: 'AccType'

define view entity ZC_H2R_ACC_ACTYPEVH
  as select from ZI_H2R_ACC_ACTYPE
{
      @Search: { defaultSearchElement: true }
      @ObjectModel.text.element: [ 'AccTypeText' ]
  key Actype                  as AccType,

      @Semantics.text: true
      _AccTypeText[ Spras = $session.system_language ].ActypeText as AccTypeText

}
