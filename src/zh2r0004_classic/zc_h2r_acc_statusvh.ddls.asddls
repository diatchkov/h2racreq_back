@EndUserText.label: 'Accommodation request: status value help'
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
@ObjectModel.representativeKey: 'Status'
@Search.searchable: true

define view entity ZC_H2R_ACC_STATUSVH as select from ZC_DOMAIN_VALUES( p_domain_name: 'ZH2R_ACC_STATUS' )
{   
    @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.8}  
    @ObjectModel.text.element: [ 'StatusText' ]
    key cast( DomainValue as zh2r_acc_status ) as Status,

    @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.8 } 
    @Semantics.text: true
    DomainValueText as StatusText,
      
    substring(DomainValueText, 1, instr(DomainValueText,':') - 1) as RequestText    
    
}
