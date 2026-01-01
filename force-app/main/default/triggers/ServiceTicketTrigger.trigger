trigger ServiceTicketTrigger on Service_Ticket__c(before insert) {
  Set<Id> assetIds = new Set<Id>();

  for (Service_Ticket__c ticket : Trigger.new) {
    if (ticket.Related_Asset__c != null) {
      assetIds.add(ticket.Related_Asset__c);
    }
  }

  if (assetIds.isEmpty()) {
    return;
  }

  Map<Id, IT_Asset__c> assetMap = new Map<Id, IT_Asset__c>(
    [SELECT Id, Status__c, Name FROM IT_Asset__c WHERE Id IN :assetIds]
  );

  for (Service_Ticket__c ticket : Trigger.new) {
    if (ticket.Related_Asset__c != null) {
      IT_Asset__c relatedAsset = assetMap.get(ticket.Related_Asset__c);

      if (relatedAsset != null && relatedAsset.Status__c == 'Retired') {
        ticket.addError(
          'Cannot create a ticket for a retired asset: ' + relatedAsset.Name
        );
      }
    }
  }
}
