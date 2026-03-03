@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accommodation: employee'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_H2R_ACC_EMPLOYEE
  as select from I_Employee
  association [1..1] to I_HCMEmployee        as _HCM    on  _HCM.HCMPersonnelNumber = $projection.Employee
  association [1..1] to I_HCMCurrentBasicPay as _HCMPay on  _HCMPay.HCMPersonnelNumber = $projection.Employee
                                                        and _HCMPay.StartDate          <= $session.system_date
                                                        and _HCMPay.EndDate            >= $session.system_date
{
  key UserID,
      Employee,
      FormOfAddress,
      FamilyName,
      FirstName,
      GivenName,
      MiddleName,
      AdditionalFamilyName,
      AcademicTitle,
      FamilyNamePrefix,
      Initials,
      FullName,
      EmployeeFullName,
      CorrespondenceLanguage,
      GenderCode,
      BusinessPartnerRole,
      Person,
      BusinessPartnerUUID,
      BusinessUser,
      EmployeeImageURL,
      _HCM.HCMOrganizationalUnit as EmployeeOrgUnit,
      /* Associations */
      _HCM,
      _HCMPay
}
