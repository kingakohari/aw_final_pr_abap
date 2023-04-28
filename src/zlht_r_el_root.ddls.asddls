@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data root Definition for Event Location'

define root view entity zlht_r_el_root
  as select from zevent_location 
  //composition of target_data_source_name as _association_name

  // Associations
  
  association [1..1] to zlht_r_el_detail as _Event_details 
                        on $projection.locationname = _Event_details.Location

{

  key mykey,

      @EndUserText.label: 'Restaurant'
      locationname,

      @EndUserText.label: 'Straße'
      streetname,

      @EndUserText.label: 'HausNr'
      housenumber,

      @EndUserText.label: 'PLZ'
      postcode,

      @EndUserText.label: 'Stadt'
      city,

      @EndUserText.label: 'Webseite'
      contact,

      @EndUserText.label: 'TelNr'
      phone,

      @EndUserText.label: 'Öffnungszeiten'
      openinghour,

      @EndUserText.label: 'Küche'
      cuisine,

      @EndUserText.label: 'Vegan'
      dietvegan,

      @EndUserText.label: 'Vegetarisch'
      dietvegetarian,

      @EndUserText.label: 'Bio-Lebensmittel'
      organic,

      @EndUserText.label: 'Behindertengerecht'
      wheelchair,

      //  Make association public from
      _Event_details,

      //    for columns
      @EndUserText.label: 'Email'
      _Event_details.email as email,
//
//           @EndUserText.label: 'Telefon'
//            _Event_Details.phone as phone_event,
      
       @EndUserText.label: 'Anzahl Teilnehmer min'
        _Event_details.min_attendees as minimum,
  
       @EndUserText.label: 'Anzahl Teilnehmer max'
        _Event_details.max_attendees as maximum,
  
       @EndUserText.label: 'Austattung'
        _Event_details.features as features,
  
       @EndUserText.label: 'Aufnahme Größen'
        _Event_details.feature_details as event_size,
      
//           @EndUserText.label: 'Website'
//            _Event_details.website as website,
      
       @EndUserText.label: 'Speisenpacket'
        _Event_details.food_package as food_package,
  
       @EndUserText.label: 'Getränkepacket'
        _Event_details.drink_package as drink_package,
  
       @EndUserText.label: 'Vorspeisen'
        _Event_details.starter as starter,
  
       @EndUserText.label: 'Fleischgerichte'
        _Event_details.meat as meat,
  
       @EndUserText.label: 'Fishgerichte'
        _Event_details.fish as fish,
  
       @EndUserText.label: 'Vegan/Vegetarisch/Bio'
        _Event_details.vegan as vegan,
  
       @EndUserText.label: 'Nachtisch'
        _Event_details.dessert as dessert,
  
       @EndUserText.label: 'Nachtisch Vegan/Vegetarisch/Bio'
        _Event_details.dessert_vegan as dessert_vegan,
  
       @EndUserText.label: 'Bewertungsschnitt:'
        _Event_details.average_valuation as average_valuation,
  
       @EndUserText.label: 'Bewertungsmessungen'
        _Event_details.valuation_details as valuation_details,
  
       @EndUserText.label: 'Bewertung über'
        _Event_details.feedback_type as feedback_type,
  
       @EndUserText.label: 'Bewertungsdatum'
        _Event_details.feedback_date as feedback_date,
  
       @EndUserText.label: 'Bewertung von:'
        _Event_details.feedback_user as feedback_user,
  
       @EndUserText.label: 'Bewertung & Kommentare:'
        _Event_details.feedback as feedback

}
