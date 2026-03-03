@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accommodation: employee'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_H2R_ACC_EMPLOYEE
  as select from ZI_H2R_ACC_EMPLOYEE     as _Employee
    join         I_HCMObjectRelationship as _Dep on  _Dep.HCMPlanVersion               = '01'
                                                 and _Dep.HCMObjectType                = 'O'
                                                 and _Dep.HCMObjectID                  = _Employee.EmployeeOrgUnit
                                                 and _Dep.HCMObjectRelshpSpecification = 'A'
                                                 and _Dep.HCMObjectRelationship        = '002'
                                                 and _Dep.StartDate                    <= $session.system_date
                                                 and _Dep.EndDate                      >= $session.system_date
{
  key _Employee.UserID,
      _Employee.Employee,
      _Employee.FirstName,
      _Employee.EmployeeFullName,

      _Employee._HCM.HCMPosition      as EmployeePosition,
      _Employee.EmployeeOrgUnit       as EmployeeOrgUnit,
      _Dep.HCMRelatedObjectID         as EmployeeDepUnit,
      _Employee._HCMPay.PayScaleGroup as EmployeeGrade,

      _Employee._HCM                  as _HCM,
      _Employee._HCMPay               as _HCMPay
}
