public class MeetingMassEmail {
    public static Messaging.SendEmailResult[] send(List<Id> whomIds, List<Id> whatIds) {
        EmailTemplate template =  [SELECT Id FROM EmailTemplate WHERE Name = 'TemplateForMeeting' LIMIT 1];
        Messaging.MassEmailMessage emails = new Messaging.MassEmailMessage(); 
        emails.setTargetObjectIds(whomIds);
        emails.setWhatIds(whatIds);
        emails.setTemplateId(template.Id);       
        return Messaging.sendEmail(New Messaging.MassEmailMessage[]{ emails });        
    }
}