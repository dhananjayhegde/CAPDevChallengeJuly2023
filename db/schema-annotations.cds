using from './schema';

annotate golf.Round with {
    ID @title: 'Round ID';
    players @( title: 'Players CDS' );  
};

annotate golf.Holes with @(
    title: '{i18n>hole}',
    description: '{i18n>hole}'
){
    ID @(
        title: '{i18n>Hole}'
    );

    par @( 
        title:'{i18n>par}'
    );

    score @( 
        title:'{i18n>score}'
    );

    result @( 
        title:'{i18n>Result}'
    );
};


annotate golf.Shots with {
    shot_number @( 
        title : '{i18n>shots}',
    );

    distance_mtr @(
        title: '{i18n>distance}'
    );
};


annotate golf.Result with {
    code @( 
        Common.Text: name,
        title: '{i18n>Result}',
        Common.TextArrangement: #TextFirst
    );
    name @(title: '{i18n>ResultDescr}');
    descr @(title: '{i18n>ResultLongDescr}');
}

