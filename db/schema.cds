using {
    managed, 
    cuid
} from '@sap/cds/common';

namespace golf;

entity Rounds: cuid, managed {
  title  : String(50);
  holes: Composition of  many Holes on holes.round = $self;
}

entity Holes: cuid {    
  par : Integer @assert.range: [3, 5];  
  score: Integer @assert.range: [3, 5];
  shots: Composition of many Shots on shots.hole = $self;
  round: Association to one Rounds;
  result: String;
}

entity Shots: cuid {
  shot_number: Integer @assert.range: [1, 100];
  distance_mtr: Decimal @assert.range: [0, 500];
  hole: Association to one Holes;
}