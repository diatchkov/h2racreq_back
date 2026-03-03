@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accomodation: request'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_H2R_ACC_ACREQ
  as select from zth2r_a_acreq as _AccRequest
  association [0..1] to ZC_H2R_ACC_EMPLOYEE as _Employee on _Employee.UserID = $projection.AccUser
  association [1..1] to ZC_H2R_ACC_STATUSVH as _AccStatus   on  _AccStatus.Status = $projection.AccStatus
  association [1..1] to ZC_H2R_ACC_ACTYPEVH as _AccType     on  _AccType.AccType = $projection.AccType
  association [0..1] to ZC_H2R_ACC_BUILDVH  as _AccBuild    on  _AccBuild.AccBuild = $projection.AccBuild
  association [0..1] to ZC_H2R_ACC_FLOORVH  as _AccFloor    on  _AccFloor.AccBuild = $projection.AccBuild
                                                            and _AccFloor.AccFloor = $projection.AccFloor
  association [0..1] to ZC_H2R_ACC_APARTVH  as _AccApart    on  _AccApart.AccBuild = $projection.AccBuild
                                                            and _AccApart.AccFloor = $projection.AccFloor
                                                            and _AccApart.AccApart = $projection.AccApart
  association [0..1] to ZC_H2R_ACC_BEDVH    as _AccBed      on  _AccBed.AccBuild = $projection.AccBuild
                                                            and _AccBed.AccFloor = $projection.AccFloor
                                                            and _AccBed.AccApart = $projection.AccApart
                                                            and _AccBed.AccBed   = $projection.AccBed
{
  key _AccRequest.reqid             as AccRequestID,
      _AccRequest.status            as AccStatus,
      _AccRequest.acuser            as AccUser,
      _AccRequest.actype            as AccType,
      _AccRequest.build             as AccBuild,
      _AccRequest.floor             as AccFloor,
      _AccRequest.apart             as AccApart,
      _AccRequest.bed               as AccBed,
      
      _AccRequest.attachment        as AccAttachment,
      _AccRequest.mimetype          as AccMimeType, 
      _AccRequest.filename          as AccFileName, 
      
      _AccRequest.begda             as AccBeginDate,
      _AccRequest.endda             as AccEndDate,
      
      _AccRequest.emp_notes         as AccPersonNotes,
      _AccRequest.fso_notes         as AccOfficerNotes,
      _AccRequest.fsm_notes         as AccManagerNotes,

      _AccRequest.emp_in_notes      as CInPersonNotes,
      _AccRequest.fso_in_notes      as CInOfficerNotes,
      _AccRequest.fsm_in_notes      as CInManagerNotes,

      _AccRequest.emp_out_notes     as COutPersonNotes,
      _AccRequest.fso_out_notes     as COutOfficerNotes,
      _AccRequest.fsm_out_notes     as COutManagerNotes,

      @Semantics.systemDateTime.createdAt: true
      _AccRequest.create_tmst       as CreateTmst,

      @Semantics.user.createdBy: true
      _AccRequest.create_user       as CreateUser,

      @Semantics.systemDateTime.lastChangedAt: true
      _AccRequest.change_tmst       as ChangeTmst,

      @Semantics.user.lastChangedBy: true
      _AccRequest.change_user       as ChangeUser,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      _AccRequest.local_change_tmst as LocalChangeTmst,

      _AccType,
      _AccBuild,
      _AccFloor,
      _AccApart,
      _AccBed,
      _Employee,
      _AccStatus
}
