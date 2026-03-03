@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accomodation: request'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_H2R_ACC_ACREQ_EXT
  as select from zth2r_a_acreq as AccRequest
  association [1..1] to I_Employee    as _Employee on _Employee.UserID = $projection.AccUser
  association [1..1] to ZC_H2R_ACC_STATUSVH as _AccStatus on _AccStatus.Status = $projection.AccStatus
{
  key reqid              as AccRequestID,
      status             as AccStatus,
      acuser             as AccUser,
      _Employee.Employee as AccEmployeeID,
      actype             as AccType,
      build              as AccBuild,
      floor              as AccFloor,
      apart              as AccApart,
      bed                as AccBed,
      begda              as AccBeginDate,
      endda              as AccEndDate,
      emp_notes          as AccPersonNotes,
      fso_notes          as AccOfficerNotes,
      fsm_notes          as AccManagerNotes,

      @Semantics.systemDateTime.createdAt: true
      create_tmst        as CreateTmst,

      @Semantics.user.createdBy: true
      create_user        as CreateUser,

      @Semantics.systemDateTime.lastChangedAt: true
      change_tmst        as ChangeTmst,

      @Semantics.user.lastChangedBy: true
      change_user        as ChangeUser,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_change_tmst  as LocalChangeTmst,

      _Employee,
      _AccStatus
}
