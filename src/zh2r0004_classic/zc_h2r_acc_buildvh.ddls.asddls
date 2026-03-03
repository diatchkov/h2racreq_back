@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accomodation: build VH'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
@ObjectModel.representativeKey: 'AccBuild'

define view entity ZC_H2R_ACC_BUILDVH
  as select distinct from ZI_H2R_ACC_BUILD   as _Build
    join                  ZC_H2R_ACC_FLOORVH as _Floor on _Floor.AccBuild = _Build.Build
{
      @Search: { defaultSearchElement: true }
      @ObjectModel.text.element: [ 'AccBuildName' ]
  key _Build.Build                                                       as AccBuild,

      @Semantics.text: true
      _Build._AccBuildText[ Spras = $session.system_language ].BuildName as AccBuildName

}
