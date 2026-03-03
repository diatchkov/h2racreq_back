@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accomodation: request root entity'
@ObjectModel.semanticKey: [ 'AccRequestID' ]
@Metadata.allowExtensions: true

define root view entity ZR_H2R_ACC_ACREQ
  as select from ZI_H2R_ACC_ACREQ
{
  key AccRequestID,
      AccStatus, 
      AccUser,
      AccType,
      AccBuild,
      AccFloor,
      AccApart,
      AccBed,
      AccBeginDate,
      AccEndDate,
      
      AccAttachment, 
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
      
      _AccType,
      _AccBuild,
      _AccFloor,
      _AccApart,
      _AccBed,
      _Employee,
      _AccStatus
}
