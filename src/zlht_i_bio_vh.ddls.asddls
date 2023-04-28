@AbapCatalog.sqlViewName: 'ZIBIOVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bio-Lebensmittel Value Help'

@ObjectModel.resultSet.sizeCategory: #XS
define view ZLHT_I_BIO_VH
  as select distinct from zevent_location
{
  key organic
}
