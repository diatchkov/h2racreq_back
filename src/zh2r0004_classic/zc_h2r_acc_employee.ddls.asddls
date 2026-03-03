@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accommodation: employee'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_H2R_ACC_EMPLOYEE
  as select from ZR_H2R_ACC_EMPLOYEE     as _Employee
  association [0..1] to I_HCMOrganizationalUnitBasic as _DepUnitText on _DepUnitText.HCMOrganizationalUnit = $projection.EmployeeDepUnit
  association [0..1] to I_HCMOrganizationalUnitBasic as _OrgUnitText on _OrgUnitText.HCMOrganizationalUnit = $projection.EmployeeOrgUnit
{ 
  key _Employee.UserID,
      _Employee.Employee,
      _Employee.FirstName,
      _Employee.EmployeeFullName,

      EmployeePosition,
      _Employee._HCM._Position._Text[ Language = $session.system_language ].HCMPositionName                     as EmployeePositionName,

      EmployeeOrgUnit,
      _OrgUnitText[ Language = $session.system_language ].HCMOrganizationalUnitName                             as EmployeeOrgUnitName,

      EmployeeDepUnit,
      _DepUnitText[ Language = $session.system_language ].HCMOrganizationalUnitName                             as EmployeeDepUnitName,

      _Employee._HCM._HCMEmployeeGroup._Text[ Language = $session.system_language].HCMEmployeeGroupName         as EmployeeGroupName,
      _Employee._HCMPay.PayScaleGroup                                                                           as EmployeeGrade,

      /* Associations */
      _HCM,
      _HCMPay
}
