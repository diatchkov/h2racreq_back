@EndUserText.label: 'Accomodation bed'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_H2R_ACC_BED
  as select from zth2r_a_bed
  association to parent ZI_H2R_ACC_BED_S as _AccApartBedAll on $projection.SingletonID = _AccApartBedAll.SingletonID
{
  key build             as Build,
  key floor             as Floor,
  key apart             as Apart,
  key bed               as Bed,
      accid             as Accid,
      @Semantics.amount.currencyCode: 'Currency'
      amount            as Amount,
      currency          as Currency,
      @Semantics.user.createdBy: true
      create_user       as CreateUser,
      @Semantics.systemDateTime.createdAt: true
      create_tmst       as CreateTmst,
      @Semantics.user.lastChangedBy: true
      change_user       as ChangeUser,
      @Semantics.systemDateTime.lastChangedAt: true
      change_tmst       as ChangeTmst,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_change_tmst as LocalChangeTmst,
      1                 as SingletonID,
      _AccApartBedAll
}
