@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accommodation: request e-mail object'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZC_H2R_ACC_ACREQ_MAIL
  as select from I_WorkflowTask           as _Workflowtask
    inner join   I_WorkflowTaskApplObject as _WorkflowTaskApplObject on  _WorkflowTaskApplObject.WorkflowTaskInternalID        = _Workflowtask.WorkflowTaskInternalID
                                                                     and _WorkflowTaskApplObject.TechnicalWrkflwObjectCategory = 'CL'
                                                                     and _WorkflowTaskApplObject.TechnicalWrkflwObjectType     = 'ZCL_H2R_ACC_ACREQ_WF'
  association [1..1] to ZI_H2R_ACC_ACREQ_MAIL as _AccRequest on _AccRequest.AccRequestID = _WorkflowTaskApplObject.TechnicalWrkflwObject
  association [1..1] to ZI_UserContactCard    as _Approver   on _Approver.ContactCardID = _Workflowtask.WorkflowTaskCurrentUser

{
  key _Workflowtask.WorkflowTaskInternalID                          as WorkflowTaskInternalID,

      _Workflowtask._WorkflowTaskResult.WorkflowTaskResultComment   as Comments,
      _Workflowtask.WorkflowTaskCurrentUser                         as Approver,
      _Approver.FullName                                            as ApproverFullName,
      _Approver.FirstName                                           as ApproverFirstName,
      _Approver.EmailAddress                                        as ApproverEmail,
      _AccRequest.AccRequestID                                      as AccRequestID,
      _AccRequest.AccStatus                                         as AccStatus,
      _AccRequest._AccStatus.StatusText                             as AccStatusText,
      _AccRequest._AccStatus.RequestText                            as AccRequestText,
      _AccRequest.AccUser,
      _AccRequest._Employee._HCM._PersonalData.HCMEmployeeFirstName as AccUserFirstName,
      _AccRequest._Employee.EmployeeFullName                        as AccUserFullName,
      _AccRequest.AccType                                           as AccType,
      _AccRequest._AccType.AccTypeText                              as AccTypeText,
      _AccRequest.AccBuild                                          as AccBuild,
      _AccRequest._AccBuild.AccBuildName                            as AccBuildName,
      _AccRequest.AccFloor                                          as AccFloor,
      _AccRequest.AccApart                                          as AccApart,
      _AccRequest.AccBed                                            as AccBed,
      case when _AccRequest.AccStatus >= '40' then _AccRequest.COutPersonNotes
        else case when _AccRequest.AccStatus >= '30' then _AccRequest.CInPersonNotes
          else _AccRequest.AccPersonNotes
        end
      end                                                           as AccEmpNotes,
      _AccRequest.AccBeginDate                                      as AccBeginDate,
      _AccRequest.AccEndDate                                        as AccEndDate,
      _AccRequest.CreateTmst                                        as CreateTmst,
      _AccRequest.CreateDate                                        as CreateDate,
      _AccRequest.CreateUser                                        as CreateUser,
      _AccRequest.ChangeTmst                                        as ChangeTmst,
      _AccRequest.ChangeUser                                        as ChangeUser
}
