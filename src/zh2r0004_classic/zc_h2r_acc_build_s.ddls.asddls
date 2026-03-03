@EndUserText.label: 'Maintain Accomodation building singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_H2R_ACC_BUILD_S
  provider contract transactional_query
  as projection on ZI_H2R_ACC_BUILD_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _AccBuild : redirected to composition child ZC_H2R_ACC_BUILD
  
}
