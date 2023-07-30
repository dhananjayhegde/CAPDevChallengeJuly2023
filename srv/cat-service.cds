using { golf } from '../db/schema';
using { RemoteService as external } from './external/RemoteService';

@impl: 'srv/cat-service.js'
service CatalogService @(path:'/browse') {
  @cds.odata.valuelist
  entity Players as projection on external.Players;
  
  @odata.draft.enabled
  @Capabilities.DeepInsertSupport: {
      $Type : 'Capabilities.DeepInsertSupportType',
      Supported,
      ContentIDSupported,
  }
  entity Rounds as projection on golf.Rounds;
  entity Holes as projection on golf.Holes;
  entity Shots as projection on golf.Shots;
}