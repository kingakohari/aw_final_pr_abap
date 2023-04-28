@AbapCatalog.sqlViewName: 'ZIVEGANVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vegan Value Help'

@ObjectModel.resultSet.sizeCategory: #XS
define view ZLHT_I_VEGAN_VH
  as select distinct from zevent_location
{   
      key dietvegan
}
