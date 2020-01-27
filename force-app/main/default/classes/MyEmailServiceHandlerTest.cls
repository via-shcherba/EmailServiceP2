@isTest
private class MyEmailServiceHandlerTest {
	@testSetup static void setup() {
        List<DaysOfWeek__c> dowks = new List<DaysOfWeek__c>();
        DaysOfWeek__c dof1 = new DaysOfWeek__c();
        dof1.Num__c = 0;
        dof1.Name = 'Monday';
        dowks.add(dof1);
        DaysOfWeek__c dof2 = new DaysOfWeek__c();
        dof2.Num__c = 1;
        dof2.Name = 'Tuesday';
        dowks.add(dof2);
        DaysOfWeek__c dof3 = new DaysOfWeek__c();
        dof3.Num__c = 2;
        dof3.Name = 'Wednesday';
        dowks.add(dof3);
        DaysOfWeek__c dof4 = new DaysOfWeek__c();
        dof4.Num__c = 3;
        dof4.Name = 'Thusday';
        dowks.add(dof4);
        DaysOfWeek__c dof5 = new DaysOfWeek__c();
        dof5.Num__c = 4;
        dof5.Name = 'Friday';
        dowks.add(dof5);
        DaysOfWeek__c dof6 = new DaysOfWeek__c();
        dof6.Num__c = 5;
        dof6.Name = 'Saturday';
        dowks.add(dof6);
        DaysOfWeek__c dof7 = new DaysOfWeek__c();
        dof7.Num__c = 6;
        dof7.Name = 'Sunday';
        dowks.add(dof7);
        insert dowks;
        
        Contact contact = new Contact();
        contact.LastName = 'Contact';
        contact.Email = 'test@test.com';
        insert contact;
    }
    
    @isTest static void handleInboundEmailTestWIthTemp1() {
        Messaging.InboundEmail email = new Messaging.InboundEmail();
		Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
		email.subject = 'Subject';
		email.fromAddress = 'test@email.com';
		email.fromName = 'TestName';
        email.htmlBody = 'Hi Jon, It’s Denis from VRP Consulting. It was great to speak with you about our contract. Do you have time next week to set up a call or grab a quick coffee together? I prefer friday on 5 p.m.  I think Coffee House is great place for meeting.I promise not to take too much of your time. I really appreciate you taking your time to hear me out on this.';
        Test.startTest();
        myEmailServiceHandler emailHandler = new myEmailServiceHandler();
        emailHandler.handleInboundEmail(email, envelope);
        Test.stopTest();
        Integer actual = [SELECT Count()FROM Opportunity WHERE Name = 'TestName'];        
        System.assertEquals(1, actual);
    }
    
    @isTest static void handleInboundEmailTestWIthTemp2() {
        Messaging.InboundEmail email = new Messaging.InboundEmail();
		Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
		email.subject = 'Subject';
		email.fromAddress = 'test@email.com';
		email.fromName = 'TestName2';
        email.htmlBody = 'Dear Marketing Manager, Our company, Epam, would like to request a meeting with you to discuss the services that we can offer you. In 15:25 on 22.11, Grushavka office. Please contact me with an opening in your schedule so that we can arrange a meeting. Sincerely, HR manager Anna anna@epam.com';
        Test.startTest();
        myEmailServiceHandler emailHandler = new myEmailServiceHandler();
        emailHandler.handleInboundEmail(email, envelope);
        Test.stopTest();
        Integer actual = [SELECT Count()FROM Opportunity WHERE Name = 'TestName2'];        
        System.assertEquals(1, actual);
    }
}