@EndUserText.label: 'Projection view for Event Location'
@AccessControl.authorizationCheck: #NOT_REQUIRED


@UI: {
 headerInfo: { typeName: 'Event Management',
               typeNamePlural: 'Event Liste',
               title: { type: #STANDARD,
                         value: 'locationname' },
               imageUrl: 'LocImageURL' } }


define root view entity zlht_c_el_proj
  as projection on zlht_r_el_root
{
      @UI.facet: [ { id:          'idInformationen',
                     type:            #COLLECTION,
                     label:           'Kontakt',
                     position:        10 
                     },

                           { id:'kontakt',
                             type: #IDENTIFICATION_REFERENCE,
                             label: 'Kontaktdaten',
                             parentId: 'idInformationen',
                             position: 10 },

                   { id:'idAngebot',
                     type: #COLLECTION,
                     label: 'Angebot',
                     position: 20},

                           { id:'angebot',
                             type: #FIELDGROUP_REFERENCE,
                             label: 'Angebotsinformation',
                             parentId: 'idAngebot',
                             targetQualifier: 'tqAngebot',
                             position: 20 },
                     
                   { id:'idSpeisekarte',
                     type: #COLLECTION,
                     label: 'Speisekarte',
                     position: 30},

                           { id:'speisen',
                             type: #FIELDGROUP_REFERENCE,
                             label: 'Speisen im Rahmen des Angebots',
                             parentId: 'idSpeisekarte',
                             targetQualifier: 'tqSpeise',
                             position: 30 }, 
                                            
                    { id:'idFeedback',
                      type: #COLLECTION,
                      label: 'Bewertungen',
                      position: 40}, 
  
                            { id:'feedback',
                              type: #FIELDGROUP_REFERENCE,
                              label: 'Externe Erfahrungen',
                              parentId: 'idFeedback',
                              targetQualifier: 'tqFeedback',
                              position: 40 }]                     


      @UI.hidden: true
          @UI: { lineItem: [ {position: 10,
                              importance: #HIGH },
                             {type: #FOR_ACTION,
                              dataAction: 'createVendor',
                              label: 'Kreditor anlegen' },
                             {type: #FOR_ACTION,
                              dataAction: 'createInternalOrder',
                              label: 'Innenauftrag anlegen' } ],
                 identification: [ {position: 10 } ],
                 selectionField: [{position: 10 }] }
      key mykey,

      @UI: { lineItem: [ {position: 10} ],
             identification: [ {position: 10} ],
             selectionField: [{position: 10}] }
      @Consumption.valueHelpDefinition: [{entity: 
                                            {element: 'locationname', 
                                             name: 'ZLHT_I_NAME_VH'} }]
      locationname,

      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZLHT_CL_PICT'
          virtual LocImageURL: abap.string( 256 ),      
      
      @UI: {
      //             lineItem: [ {
      //                 position: 110} ],
             identification: [ {position: 11} ] }
      streetname,

      @UI: {
      //              lineItem: [ {
      //                 position: 120} ],
             identification: [ {position: 12} ] }
      housenumber,

      @UI: {
      //             lineItem: [ {
      //                 position: 130} ],
             identification: [ {position: 13} ] }
      postcode,

      @UI: { identification: [ {position: 14} ] }
      city,

      @UI: { lineItem: [ {position: 80, 
                          url: 'contact', 
                          type: #WITH_URL} ],
             identification: [ {position: 20, 
                                url: 'contact', 
                                type: #WITH_URL} ] }

      contact,

      @UI: { lineItem: [ {position: 90} ],
             identification: [ {position: 22} ] }
      phone,

      @UI: { lineItem: [ {position: 70} ],
             identification: [ {position: 70} ]}
      openinghour,

      @UI: { lineItem: [ {position: 30} ],
//             identification: [ {position: 30} ],
             selectionField: [{position: 30 }] }
      @Consumption.valueHelpDefinition: [{entity: 
                                            {element: 'cuisine', 
                                             name: 'ZLHT_I_CUISINE_VH'} }]
      @UI.fieldGroup: [{ qualifier: 'tqAngebot', 
                         position: 30 }]
      cuisine,

      @UI: { lineItem: [ {position: 40} ],
//             identification: [ {position: 40} ],
             selectionField: [{position: 40 }] }
      @Consumption: {valueHelpDefinition: [{entity: 
                                            {element: 'dietvegan', 
                                             name: 'ZLHT_I_VEGAN_VH'} }],
            filter: { multipleSelections: false, 
                      selectionType: #SINGLE}}
      @UI.fieldGroup: [{ qualifier: 'tqAngebot', 
                         position: 32 }]
      dietvegan,

      @UI: { lineItem: [ { position: 50} ],
//             identification: [{ position: 50}],
             selectionField: [{ position: 50 }] }
      @Consumption: {valueHelpDefinition: [{entity: {
                                             element: 'dietvegetarian', 
                                             name: 'ZLHT_I_VEGET_VH'} }],
      filter: { multipleSelections: false, 
                selectionType: #SINGLE}}
      @UI.fieldGroup: [{ qualifier: 'tqAngebot', 
                         position: 33 }]
      dietvegetarian,

      @UI: { lineItem: [ { position: 60} ],
//             identification: [ { position: 60} ],
             selectionField: [{ position: 60 }] }
      @Consumption.valueHelpDefinition: [{entity: {
                                            element: 'organic', 
                                            name: 'ZLHT_I_BIO_VH'} }]
      @UI.fieldGroup: [{ qualifier: 'tqAngebot', 
                         position: 31 }]
      organic,

      @UI: { lineItem: [ { position: 100} ],
//             identification: [ { position: 100} ],
             selectionField: [{ position: 70 }] }
      @Consumption.valueHelpDefinition: [{entity: {
                                            element: 'wheelchair', 
                                            name: 'ZLHT_I_WHEEL_VH'} }]
      @UI.fieldGroup: [{ qualifier: 'tqAngebot', 
                         position: 30 }]
      wheelchair,
      

////  Make association public

      _Event_details,


      @UI: {
          lineItem:  [ { position: 150,
                         importance: #LOW } ],
          identification: [ { position: 21 } ]}
      email,

      @UI: {
          lineItem:   [ { position: 160,
                          importance: #LOW } ],
//          identification: [ { position: 160 } ],
          selectionField: [{ position: 80 }]}
      @UI.fieldGroup: [{ qualifier: 'tqAngebot', 
                         position: 10 }]
      minimum,

      @UI: { 
           lineItem:       [ { position: 170,
                               importance: #LOW } ],
//           identification: [ { position: 170 } ],
           selectionField: [{ position: 90 }]}
      @UI.fieldGroup: [{ qualifier: 'tqAngebot', 
                         position: 10 }]
      maximum,

//      @UI: {
//      ////          lineItem:       [ { position: 180,
//      ////                             importance: #LOW } ],
//            identification: [ { position: 180 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqAngebot', 
                         position: 10 }]            
      features,

//      @UI: {
//      //          lineItem:       [ { position: 190,
//      ////                             importance: #LOW } ],
//            identification: [ { position: 190 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqAngebot', 
                         position: 10 }]
      event_size,
      //
//      @UI: {
        //          lineItem:       [ { position: 200,
        //                             importance: #LOW } ],
//            identification: [ { position: 200 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqAngebot', 
                         position: 20 }]
      food_package,

//      @UI: {
      ////          lineItem:       [ { position: 220,
      ////                             importance: #LOW } ],
//            identification: [ { position: 220 } ]}
      //      @Consumption.valueHelpDefinition: [{
      //                              entity : {name: 'zlht_r_el_detail',
      //                              element: 'drink_package' }
      //                              }]
      //      @ObjectModel.text.element: ['drink_package']
      @UI.fieldGroup: [{ qualifier: 'tqAngebot', 
                         position: 20 }]
      drink_package,

//      @UI: {
//      ////          lineItem:       [ { position: 230,
//      ////                             importance: #LOW } ],
//            identification: [ { position: 230 } ]}

      @UI.fieldGroup: [{ qualifier: 'tqSpeise', 
                         position: 10 }]
      starter,

//      @UI: {
      ////          lineItem:       [ { position: 240,
      ////                             importance: #LOW } ],
//             identification: [ { position: 240 } ]}

      @UI.fieldGroup: [{ qualifier: 'tqSpeise', 
                         position: 20 }]
      meat,

//      @UI: {
      ////          lineItem:       [ { position: 250,
      ////                             importance: #LOW } ],
//             identification: [ { position: 250 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqSpeise', 
                         position: 30 }]
      fish,

//      @UI: {
      ////          lineItem:       [ { position: 260,
      ////                             importance: #LOW } ],
//             identification: [ { position: 260 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqSpeise', 
                         position: 40 }]
      vegan,   
      
//      @UI: {
      ////          lineItem:       [ { position: 270,
      ////                             importance: #LOW } ],
//             identification: [ { position: 270 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqSpeise', 
                         position: 50 }]
      dessert,

//      @UI: {
//      ////          lineItem:       [ { position: 280,
//      ////                             importance: #LOW } ],
//             identification: [ { position: 280 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqSpeise', 
                         position: 50 }]
      dessert_vegan,

//      @UI: {
//      ////          lineItem:       [ { position: 290,
//      ////                             importance: #LOW } ],
//             identification: [ { position: 290 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqFeedback', 
                         position: 10 }]             
      average_valuation,

//      @UI: {
//      ////          lineItem:       [ { position: 300,
//      ////                             importance: #LOW } ],
//             identification: [ { position: 300 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqFeedback', 
                         position: 20 }]
      valuation_details,

//      @UI: {
//      ////          lineItem:       [ { position: 310,
//      ////                             importance: #LOW } ],
//             identification: [ { position: 310 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqFeedback', 
                         position: 20 }]
      feedback_type,

//      @UI: {
//      ////          lineItem:       [ { position: 330,
//      ////                             importance: #LOW } ],
//             identification: [ { position: 330 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqFeedback', 
                         position: 20 }]
      feedback_date,

//      @UI: {
//      ////          lineItem:       [ { position: 340,
//      ////                             importance: #LOW } ],
//             identification: [ { position: 340 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqFeedback', 
                         position: 20 }]
      feedback_user,

//      @UI: {
//      ////          lineItem:       [ { position:350,
//      ////                             importance: #LOW } ],
//             identification: [ { position: 350 } ]}
      @UI.fieldGroup: [{ qualifier: 'tqFeedback', 
                         position: 30 }]
      feedback

}
