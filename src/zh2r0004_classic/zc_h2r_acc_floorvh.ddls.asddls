@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accomodation: floor VH'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
@ObjectModel.representativeKey: 'AccFloor'

define view entity ZC_H2R_ACC_FLOORVH
  as select distinct from ZI_H2R_ACC_FLOOR   as _Floor
    join                  ZC_H2R_ACC_APARTVH as _Apart on  _Apart.AccBuild = _Floor.Build
                                                       and _Apart.AccFloor = _Floor.Floor
{
  key _Floor.Build as AccBuild,
      @Search: { defaultSearchElement: true }
  key _Floor.Floor as AccFloor

}
