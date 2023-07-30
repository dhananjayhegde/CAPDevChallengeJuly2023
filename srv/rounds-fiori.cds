using CatalogService from './cat-service';
using golf.Round2Players from '../db/schema';

/**
 * Rounds
 */
annotate CatalogService.Rounds with @(
    UI: {
        
        /**
         * Line item
         */
        SelectionFields: [ title, createdAt, createdBy, modifiedAt, modifiedBy ],        
        LineItem: [
            {Value: ID},
            {Value: title }
        ],
        
        /**
         * Object Page - Header
         */
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Round',
            TypeNamePlural : 'Rounds',
            Title: { Value: title },
            Description: { Value: ID }
        },
        HeaderFacets  : [
            {
                $Type : 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#AdminInfo'
            },
        ],
        
        /**
         * Object Page - Page level
         */        
        Facets  : [
            {
                $Type: 'UI.CollectionFacet',
                ID : 'idRoundsCFGenInfo',
                Facets : [
                    {
                        $Type: 'UI.ReferenceFacet',
                        Label:' Basic Data',
                        Target: '@UI.FieldGroup#General'
                    }, {
                        $Type: 'UI.ReferenceFacet',
                        Label:' Administrative Data',
                        Target: '@UI.FieldGroup#AdminInfo'
                    },
                ],
                Label : 'General Information',
            },
            {
                $Type: 'UI.ReferenceFacet',
                Label : 'Holes',
                Target : 'holes/@UI.LineItem#HolesTable',
            },
            {
                $Type: 'UI.ReferenceFacet',
                Label : 'Players',
                Target : 'players/@UI.PresentationVariant',
            }
        ],

        FieldGroup #General : {
            $Type : 'UI.FieldGroupType',
            Label: 'Basic Data',
            Data : [
                { Value: ID }, { Value: title }
            ]            
        },

        FieldGroup #AdminInfo : {
            $Type : 'UI.FieldGroupType',
            Data : [
                { Value: createdAt},
                { Value: createdBy},
                { Value: modifiedAt},
                { Value: modifiedBy},
            ]            
        },
    }
);
/**
 * Holes
 */
annotate CatalogService.Holes with @(
    UI: {
        /**
         * Line item
         */
        LineItem #HolesTable: [
            {Value: par, Label:'Par'},
            {Value: score, Label:'Score' },
            {Value: result, Label:'Result' }
        ],
        
        /**
         * Object Page
         */
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Hole',
            TypeNamePlural : 'Holes',
            Title: { Value : result },
            Description: { Value: ID }
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
 * Shots
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
   * Player
   */
   annotate Round2Players with @( 
     UI: {
        /**
         * Line item
         */
        PresentationVariant  : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        
        LineItem  : [
            { Value: players_name }
        ],

        /**
         * Object Page
         */
        Facets  : [
            {
                $Type : 'UI.CollectionFacet',
                ID: 'idPlayersCFGenInfo',
                Facets: [
                    {
                        $Type : 'UI.ReferenceFacet',
                        Target : '@UI.FieldGroup#General',
                    }
                ]
            },
        ],

        FieldGroup #General : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {Value: players_name }
            ],            
        },
     }
   ) ;
   
 

