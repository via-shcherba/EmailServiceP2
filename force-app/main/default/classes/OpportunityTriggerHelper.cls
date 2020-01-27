public class OpportunityTriggerHelper {
	
    private Map<Id, Opportunity> newRecords;
    
    public OpportunityTriggerHelper(Map<Id, Opportunity> newRecords) {
        this.newRecords = newRecords;
    }
    
    public void run() {        
        if (!newRecords.isEmpty()) {            
            Map<Id, Contact> contacts = new Map<Id, Contact>([SELECT Id FROM Contact LIMIT 10]); 
            List<OpportunityContactRole> newOppCntRoles = new List<OpportunityContactRole>();
            List<Id> contactIds = new List<Id>();
            List<Id> opportynityIds = new List<Id>();
            if (!contacts.isEmpty()) {
            	for (Id opportunityId : newRecords.keySet()) {            	
                	for (Contact contact : contacts.values()) {
                    	OpportunityContactRole newOppCntRole = new OpportunityContactRole();
                    	newOppCntRole.OpportunityId = opportunityId;
                    	newOppCntRole.ContactId = contact.Id;
                    	newOppCntRoles.add(newOppCntRole);
                        contactIds.add(contact.Id);
                    	opportynityIds.add(opportunityId);
                 	}	                       
            	}
            }
            if (!newOppCntRoles.isEmpty()) {                
            	insert newOppCntRoles;                      
                MeetingMassEmail.send(contactIds, opportynityIds);                
            }
            
        }
    }
    
}