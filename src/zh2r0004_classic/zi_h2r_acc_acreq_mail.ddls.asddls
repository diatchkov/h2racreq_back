@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accommodation: request e-mail object'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_H2R_ACC_ACREQ_MAIL
  as select from ZR_H2R_ACC_ACREQ
{
  key cast( bintohex(AccRequestID) as sibfboriid) as AccRequestID,
      AccStatus, 
      AccUser,
      AccType,
      AccBuild,
      AccFloor,
      AccApart,
      AccBed,
      AccBeginDate,
      AccEndDate,
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
      tstmp_to_dats(cast(CreateTmst as tzntstmps), abap_system_timezone( $session.client,'NULL' ), $session.client, 'NULL' ) as CreateDate,      
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
