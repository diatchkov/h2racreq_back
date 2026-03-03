@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accommodation: request projection entity'
@Metadata.allowExtensions: true

@ObjectModel.semanticKey: [ 'AccRequestID' ]

define root view entity ZC_H2R_ACC_ACREQ
  provider contract transactional_query
  as projection on ZR_H2R_ACC_ACREQ
  association [0..1] to ZI_UserContactCard as _CreateUserContactCard on _CreateUserContactCard.ContactCardID = $projection.CreateUser
  association [0..1] to ZI_UserContactCard as _ChangeUserContactCard on _ChangeUserContactCard.ContactCardID = $projection.ChangeUser
{
  key     AccRequestID,

          @UI.textArrangement: #TEXT_ONLY
          @ObjectModel.text.element: [ 'AccStatusText' ]
          AccStatus,
          _AccStatus.StatusText          as AccStatusText,

          AccUser,

          _Employee.Employee             as AccEmployee,

          _Employee.EmployeeFullName     as AccEmployeeFullName,

          _Employee.EmployeePositionName as AccEmployeePositionName,

          _Employee.EmployeeOrgUnit      as AccEmployeeOrgUnit,

          _Employee.EmployeeOrgUnitName  as AccEmployeeOrgUnitName,

          _Employee.EmployeeDepUnit      as AccEmployeeDepUnit,

          _Employee.EmployeeDepUnitName  as AccEmployeeDepUnitName,

          _Employee.EmployeeGroupName    as AccEmployeeGroupName,

          _Employee.EmployeeGrade        as AccEmployeeGrade,


          @ObjectModel: {
             virtualElement: true,
             virtualElementCalculatedBy: 'ABAP:ZCL_H2R_ACC_ACREQ_CALC'
          }
  virtual AccEmployeeJoinDate     : datum,

          @ObjectModel: {
             virtualElement: true,
             virtualElementCalculatedBy: 'ABAP:ZCL_H2R_ACC_ACREQ_CALC'
          }
  virtual AccEmployeeProbationEnd : datum,

          @Consumption.valueHelpDefinition: [{
            entity: {
              name: 'ZC_H2R_ACC_ACTYPEVH',
              element: 'AccType'
            },
            distinctValues: true
          }]

          @ObjectModel.text.element: [ 'AccTypeText' ]
          @UI.textArrangement: #TEXT_FIRST
          AccType,

          _AccType.AccTypeText           as AccTypeText,

          @Consumption.valueHelpDefinition: [{
            entity: {
              name: 'ZC_H2R_ACC_BUILDVH',
              element: 'AccBuild'
             },
             distinctValues: true
          }]

          @ObjectModel.text.element: [ 'AccBuildName' ]
          @UI.textArrangement: #TEXT_FIRST
          AccBuild,

          _AccBuild.AccBuildName         as AccBuildName,

          @Consumption.valueHelpDefinition: [{
            entity: {
              name: 'ZC_H2R_ACC_FLOORVH',
              element: 'AccFloor'
             },
             distinctValues: true,

             additionalBinding: [{
               localElement: 'AccBuild',
               element: 'AccBuild',
               usage: #FILTER
             }]
          }]
          AccFloor,

          @Consumption.valueHelpDefinition: [{
            entity: {
              name: 'ZC_H2R_ACC_APARTVH',
              element: 'AccApart'
             },
             distinctValues: true,

             additionalBinding: [{
               localElement: 'AccBuild',
               element: 'AccBuild',
               usage: #FILTER
             }, {
               localElement: 'AccFloor',
               element: 'AccFloor',
               usage: #FILTER
             }]
          }]
          @ObjectModel.text.element: [ 'AccApartTypeText' ]
          @UI.textArrangement: #TEXT_FIRST
          AccApart,
          _AccApart.ApartTypeText        as AccApartTypeText,

          @Consumption.valueHelpDefinition: [{
            entity: {
              name: 'ZC_H2R_ACC_BEDVH',
              element: 'AccBed'
             },
             distinctValues: true,

             additionalBinding: [{
               localElement: 'AccBuild',
               element: 'AccBuild',
               usage: #FILTER
             }, {
               localElement: 'AccFloor',
               element: 'AccFloor',
               usage: #FILTER
             }, {
               localElement: 'AccApart',
               element: 'AccApart',
               usage: #FILTER
             }]
          }]
          AccBed,

          AccBeginDate,
          AccEndDate,

          @Semantics.largeObject: {
            mimeType: 'AccMimeType',
            fileName: 'AccFileName',
            contentDispositionPreference: #ATTACHMENT
          }
          @EndUserText.label: 'Attachment'
          AccAttachment,

          @Semantics.mimeType: true
          AccMimeType,
          AccFileName,

          AccPersonNotes,
          AccOfficerNotes,
          AccManagerNotes,

          CInPersonNotes,
          CInOfficerNotes,
          CInManagerNotes,

          COutPersonNotes,
          COutOfficerNotes,
          COutManagerNotes,

          CreateTmst,
          CreateUser,
          ChangeTmst,
          ChangeUser,
          LocalChangeTmst,

          _Employee,
          _AccStatus,
          _CreateUserContactCard,
          _ChangeUserContactCard
}
where
  AccUser = $session.user
