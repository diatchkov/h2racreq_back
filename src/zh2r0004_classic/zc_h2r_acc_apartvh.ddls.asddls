@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accomodation: apart VH'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
@ObjectModel.representativeKey: 'AccApart'

define view entity ZC_H2R_ACC_APARTVH
  as select distinct from ZI_H2R_ACC_APART as _Apart
    join                  ZC_H2R_ACC_BEDVH as _Bed on  _Bed.AccBuild = _Apart.Build
                                                   and _Bed.AccFloor = _Apart.Floor
                                                   and _Bed.AccApart = _Apart.Apart
{
  key _Apart.Build               as AccBuild,
  key _Apart.Floor               as AccFloor,
      @Search: { defaultSearchElement: true }
  key _Apart.Apart               as AccApart,

      @ObjectModel.text.element: [ 'ApartTypeText' ]
      @UI.textArrangement: #TEXT_ONLY
      _Apart.Atype,

      _Apart._ApartType.TypeText as ApartTypeText
}
