global class MyEmailServiceHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        if (result.success) {
            try {                         
                EmailReader emailReader = new EmailReader(email.htmlBody.stripHtmlTags());                          
                
                Opportunity opp = new Opportunity();
                opp.Name = email.fromName;
                opp.NextStep = emailReader.getMeetingPlace(); 
                opp.CurrentGenerators__c = email.subject;
               
                opp.CloseDate = emailReader.getMeetingDate(); 
                opp.MeetingTime__c = emailReader.getMeetingTime(); 
                
                Schema.DescribeFieldResult oppStage = Opportunity.StageName.getDescribe();
				String stageValueProspecting = oppStage.getPicklistValues()[0].getValue();
                
                opp.StageName = stageValueProspecting;
                insert opp;

            } catch (Exception e) {
				System.debug(e.getMessage());
            }
        }
               
        return result;
    }
}