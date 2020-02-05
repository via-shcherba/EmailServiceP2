trigger OpportunityTrigger on Opportunity (after insert) {    
    if (trigger.isAfter) {
        if (trigger.isInsert) {
            new OpportunityTriggerHelper(trigger.NewMap).run(); 
        }
    }
}