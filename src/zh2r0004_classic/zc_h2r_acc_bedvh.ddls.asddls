@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accomodation: bed VH'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
@ObjectModel.representativeKey: 'AccBed'

define view entity ZC_H2R_ACC_BEDVH
  as select from    ZI_H2R_ACC_BED as _Bed
    left outer join zth2r_a_acreq  as _Request on  _Request.build  =  _Bed.Build
                                               and _Request.floor  =  _Bed.Floor
                                               and _Request.apart  =  _Bed.Apart
                                               and _Request.bed    =  _Bed.Bed
                                               and _Request.status <> '96'
{
  key _Bed.Build      as AccBuild,
  key _Bed.Floor      as AccFloor,
  key _Bed.Apart      as AccApart,
      @Search: { defaultSearchElement: true }
  key _Bed.Bed        as AccBed,
      _Bed.Accid,
      @Semantics.amount.currencyCode: 'Currency'
      _Bed.Amount,
      @UI.hidden: true
      _Bed.Currency
}
where
  _Request.reqid is null
