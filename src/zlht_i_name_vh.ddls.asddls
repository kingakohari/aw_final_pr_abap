@AbapCatalog.sqlViewName: 'ZINAMEVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Name Value Help'


define view ZLHT_I_NAME_VH
  as select from zevent_location
{
      @UI.hidden: true
  key mykey,
      @EndUserText.label: 'Restaurant'
      locationname
}
