@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Event details root zlht_eventdetail'
define root view entity zlht_r_el_detail 
    as select from zlht_eventdetail as Event_details
//composition of target_data_source_name as _association_name
{
      key mykey,   
      locationname as Location,  
      email,          
      //phone,       
      min_attendees,    
      max_attendees,  
      features,         
      feature_details,  
      website,         
      food_package,     
      drink_package,   
      starter,          
      meat,
      fish,           
      vegan,           
      dessert,         
      dessert_vegan,    
      average_valuation, 
      valuation_details, 
      feedback_type,    
      feedback_date,    
      feedback_user,    
      feedback     
          
 // Make association public
}
