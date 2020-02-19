global class MyEmailServiceHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        if (result.success) {                                   
            EmailReader emailReader = new EmailReader(email);                                        
            Opportunity opp = new Opportunity();
            opp.Name = email.fromName;
            opp.NextStep = emailReader.getMeetingPlace(); 
            opp.CurrentGenerators__c = email.subject;              
            opp.CloseDate = emailReader.getMeetingDate(); 
            opp.MeetingTime__c = emailReader.getMeetingTime();                
            Schema.DescribeFieldResult oppStage = Opportunity.StageName.getDescribe();
			String stageValueProspecting = oppStage.getPicklistValues()[0].getValue();             
            opp.StageName = stageValueProspecting;            
            try {
                insert opp;
            } catch (Exception e) {
				//LogObject <-- e.getMessage();
            }
        }
               
        return result;
    }
}