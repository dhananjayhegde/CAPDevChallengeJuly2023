using CatalogService from '../../srv/cat-service';

/**
 * Rounds - List Report
 */
annotate CatalogService.Rounds with @(
  UI: {
    SelectionFields: [ title ],
    LineItem: [
      {Value: ID},
      {Value: title, Label:'Title' }
    ]
  }
);

/**
 * Rounds - Obejct Page
 */

annotate CatalogService.Rounds with @(
    UI: {
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Round',
            TypeNamePlural : 'Rounds',
            Description: { Value: title }
        },
        Facets  : [
            {
                $Type: 'UI.ReferenceFacet',
                Label:' General Info',
                Target: '@UI.FieldGroup#General'
            },
            {
                $Type: 'UI.ReferenceFacet',
                Label : 'Holes',
                Target : 'holes/@UI.LineItem#HolesTable',
            },
            {
                $Type: 'UI.ReferenceFacet',
                Label : 'Players',
                Target : 'players/players/@UI.LineItem',
            }
        ],

        FieldGroup #General : {
            $Type : 'UI.FieldGroupType',
            Data : [
                { Value: title}
            ]            
        },
    }
);

/**
 * Holes Line Item Facets
 */
annotate CatalogService.Holes with @(
  UI: {
    LineItem #HolesTable: [
      {Value: par, Label:'Par'},
      {Value: score, Label:'Score' },
      {Value: result, Label:'Result' }
    ]
  }
);

/**
 * Holes Object Page
 */
annotate CatalogService.Holes with @(
    UI: {
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Hole',
            TypeNamePlural : 'Holes',
            Description: { Value: result }
        },
        
        Facets  : [
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'General Information',
                Target: '@UI.FieldGroup#General'
            },
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Shots',
                Target: 'shots/@UI.LineItem'
            }
        ],
        
        FieldGroup #General : {
            $Type : 'UI.FieldGroupType',
            Data : [
                { Value: par },
                { Value: score },
                { Value: result }
            ], 
            
        },
    }
);

/**
 * Shots Line item facet
 */
 annotate CatalogService.Shots with @(
    UI: {
        LineItem  : [
            { Value : shot_number},
            { Value : distance_mtr}
        ],
    }
  );

  /**
   * Player line item facet
   */
   annotate CatalogService.Players with @( 
     UI: {
        LineItem  : [
            { Value: name }
        ],
     }
   ) ;
   
 

