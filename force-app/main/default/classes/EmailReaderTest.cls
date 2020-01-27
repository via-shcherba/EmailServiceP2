@isTest
private class EmailReaderTest {
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
    }
    
    @isTest static void getNumberOfDayTest() {
        String str = 'Saturday';
        Test.startTest();
        Integer actual = EmailReader.getNumberOfDay(str);
        Test.stopTest();
        Integer expected = 5;
        System.assertEquals(expected, actual);
    }
    
    @isTest static void getMeetingTimeV12Test() {
        String str = 'I have meeting at 2 p.m. today';
        Test.startTest();
        EmailReader emr = new EmailReader(str);
        Time actual = emr.getMeetingTime();
        Test.stopTest();
        Time expected = Time.newInstance(14, 0, 0, 0);
        System.assertEquals(expected, actual);
    }
    
    @isTest static void getMeetingTimeV24Test() {
        String str = 'I have meeting at 18:15 today';
        Test.startTest();
        EmailReader emr = new EmailReader(str);
        Time actual = emr.getMeetingTime();
        Test.stopTest();
        Time expected = Time.newInstance(18, 15, 0, 0);
        System.assertEquals(expected, actual);
    }
    
    @isTest static void getMeetingDateWithTextTest() {
        String str = 'I have meeting on Friday at 1 p.m.';
        Test.startTest();
        EmailReader emr = new EmailReader(str);
        Date actual = emr.getMeetingDate();
        Test.stopTest();
        Date expected = Date.newInstance(2020, 1, 31);       
        System.assertEquals(expected, actual);
    }
    
    @isTest static void getMeetingDateWithDateTest() {
        String str = 'I have meeting on 31.01 at 1 p.m.';
        Test.startTest();
        EmailReader emr = new EmailReader(str);
        Date actual = emr.getMeetingDate();
        Test.stopTest();
        Date expected = Date.newInstance(2020, 1, 31);       
        System.assertEquals(expected, actual);
    }
    
    @isTest static void getMeetingPlaceWithOfficeTest() {
        String str = 'I have meeting on Saturday at 1 p.m. in Home office ';
        Test.startTest();
        EmailReader emr = new EmailReader(str);
        String actual = emr.getMeetingPlace();
        Test.stopTest();
        String expected = 'Home office';                
        System.assertEquals(expected, actual);
    }
    
    @isTest static void getMeetingPlaceWithHouseTest() {
        String str = 'I have meeting on Saturday at 1 p.m. in Home House ';
        Test.startTest();
        EmailReader emr = new EmailReader(str);
        String actual = emr.getMeetingPlace();
        Test.stopTest();
        String expected = 'Home House';                
        System.assertEquals(expected, actual);
    }
    
}