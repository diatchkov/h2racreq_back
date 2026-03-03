@EndUserText.label: 'Accommodation: apart type value help'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.representativeKey: 'Type'
@Search.searchable: true

define view entity ZC_H2R_ACC_APART_TYPEVH as select from ZC_DOMAIN_VALUES( p_domain_name: 'ZH2R_ACC_APART_TYPE' )
{   
    @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.8}  
    @ObjectModel.text.element: [ 'TypeText' ]
    key cast( DomainValue as zh2r_acc_apart_type ) as Type,

    @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.8 } 
    @Semantics.text: true
    DomainValueText as TypeText    
    
}
