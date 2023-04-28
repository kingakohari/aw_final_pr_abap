@AbapCatalog.sqlViewName: 'ZIWHEELVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Behindertengerecht Value Help'

@ObjectModel.resultSet.sizeCategory: #XS
define view ZLHT_I_WHEEL_VH
  as select distinct from zevent_location
{
  key wheelchair
}
