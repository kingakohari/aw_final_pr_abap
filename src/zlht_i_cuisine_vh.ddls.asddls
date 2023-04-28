@AbapCatalog.sqlViewName: 'ZICUISINEVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Küche Value Help'
define view ZLHT_I_CUISINE_VH as select distinct from zevent_location
{
    
      @EndUserText.label: 'Küche'
      key cuisine
}
