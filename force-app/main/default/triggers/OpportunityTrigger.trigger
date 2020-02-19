trigger OpportunityTrigger on Opportunity (after insert) {       
    new OpportunityTriggerHelper(trigger.NewMap);    
}