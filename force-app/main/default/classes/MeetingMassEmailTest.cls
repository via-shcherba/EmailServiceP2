@isTest
private class MeetingMassEmailTest {
	
    @isTest static void sendTest() {
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Opportunity1';
        opportunity.CloseDate = Date.today();
        opportunity.StageName = 'Prospecting';
        insert opportunity;
        Contact contact = new Contact();
        contact.LastName = 'Contact';
        contact.Email = 'test@test.com';
        insert contact;
        OpportunityContactRole opportunityContactRole = new OpportunityContactRole();
        opportunityContactRole.ContactId = contact.Id;
        opportunityContactRole.OpportunityId = opportunity.Id;
        insert opportunityContactRole;
        Test.startTest();
        Messaging.SendEmailResult[] actual = MeetingMassEmail.send(new List<Id>{contact.Id}, new List<Id>{opportunity.Id});
        Test.stopTest();
        System.assertEquals(true, actual[0].isSuccess());        
    }
    
}