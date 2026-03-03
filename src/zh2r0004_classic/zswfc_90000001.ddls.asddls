@AbapCatalog.sqlViewName: 'ZSWF90000001'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@EndUserText.label: 'Generated: Flex Workflow CDS for scenario WS90000001'
@ObjectModel: {
  usageType.serviceQuality: #X,
  usageType.sizeCategory: #S,
  usageType.dataClass: #MASTER
}
@ClientHandling.algorithm: #SESSION_VARIABLE
define view ZSWFC_90000001
with parameters wf_id:sww_wiid
as select from ZSWFM_90000001(wf_id:$parameters.wf_id) as MetaData
association [0..1] to ZR_H2R_ACC_ACREQ as __LEADING_OBJECT on
  __LEADING_OBJECT.ACCREQUESTID = $projection.S____KEY1
association [0..1] to ZR_H2R_ACC_ACREQ as _ACCREQUEST on
  _ACCREQUEST.ACCREQUESTID = $projection.S____KEY1


{
  key MetaData.WorkflowId
  , MetaData._WF_INITIATOR AS S___WF_INITIATOR
  , MetaData._WF_PRIORITY AS S___WF_PRIORITY
  , MetaData._WF_VERSION AS S___WF_VERSION
  , __LEADING_OBJECT
  , _ACCREQUEST
  , MetaData.__KEY1 as S____KEY1 // ACCREQUEST.ACCREQUESTID
}
where MetaData.WorkflowId = $parameters.wf_id;
