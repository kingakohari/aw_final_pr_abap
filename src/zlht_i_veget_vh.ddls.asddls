@AbapCatalog.sqlViewName: 'ZIVEGETVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vegetarisch Value Help'

@ObjectModel.resultSet.sizeCategory: #XS
define view ZLHT_I_VEGET_VH
  as select distinct from zevent_location
{
  key dietvegetarian
}
