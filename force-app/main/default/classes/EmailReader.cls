public class EmailReader {

    public String fromName {get;set;}
    public String fromAddress {get;set;}
    public String subject {get;set;} 
    public String message {get;set;} 

    public EmailReader(Messaging.InboundEmail email) {
        fromName = email.fromName;
        fromAddress = email.fromAddress;
        subject = email.subject;
        message = email.htmlBody.stripHtmlTags();
    }

    public Time getMeetingTime() {
        Time meetingTime;
        Pattern patt = Pattern.compile('.*([1-9][0-2]?\\s[a,p]\\.m\\.?).*');
        Matcher match = patt.matcher(message);       
        if (match.find()) {	
            if (match.group(1).length() > 2) {
                Integer hour = Integer.valueOf(match.group(1).substring(0,1)); 
                String period = match.group(1).substring(1).replace('.','').trim();
                if (period == 'pm') {
                    hour += 12;
                }
                meetingTime = Time.newInstance(hour, 0, 0, 0);
            }
        } else {
            patt = Pattern.compile('.*([0-2][0-9]:[0-5][0-9]).*');
	        match = patt.matcher(message);
            if (match.find()) {              
                String[] timeArray = match.group(1).split(':'); 
                if (!timeArray.isEmpty()) {
                    Integer hours = Integer.valueOf(timeArray[0]);
                    Integer minutes = Integer.valueOf(timeArray[1]);
                    meetingTime = Time.newInstance(hours, minutes, 0, 0);
                }
            }
        }
        return meetingTime;
    }

    public Date getMeetingDate() {
        Date meetingDate;
        Date dateNow = Date.today();
        Pattern patt = Pattern.compile('.*([1-3][0-9].[0-5][0-9]).*');
        Matcher match = patt.matcher(message); 
        if (match.find()) {	
            String[] dateArray = match.group(1).split('\\.'); 
            if (!dateArray.isEmpty()) {
                Integer day = Integer.valueOf(dateArray[0]);
                Integer month = Integer.valueOf(dateArray[1]);
                meetingDate = Date.newInstance(dateNow.year(), month, day);
            }
        } else {
            patt = Pattern.compile('.*\\s([M-m,T-t,W-w,F-f,S-s][o,n,u,e,s,n,h,r,i,a,t,d]+day).*');
	        match = patt.matcher(message);
            if (match.find()) {
                String day = match.group(1); 
                if (day != null) {
                    Integer dayNumber = getNumberOfDay(day);    
                    Datetime dateTimeNow = (Datetime)dateNow;           
                    Integer dayNumberToDay = getNumberOfDay(dateTimeNow.format('EEEE'));
                    if (dayNumber > dayNumberToDay) {
                        meetingDate = dateNow.addDays(dayNumber - dayNumberToDay);
                    } else {
                        meetingDate = dateNow;
                    }                   
                }
            }
        }       
        return meetingDate;
    }

    public String getMeetingPlace() {
        String meetingPlace;
        Pattern patt = Pattern.compile('.*\\s([a-zA-Z]+\\s[o,O]ffice).*');
        Matcher match = patt.matcher(message); 
        if (match.find()) {	
            meetingPlace = match.group(1);            
        } else {
            patt = Pattern.compile('.*\\s([a-zA-Z]+\\s[h,H]ouse).*');
	        match = patt.matcher(message);
            if (match.find()) {
                meetingPlace = match.group(1); 
            }
        }       
        return meetingPlace;
    }

    private static Integer getNumberOfDay(String day) {
        Integer result;       
        for (DaysOfWeek__c dayOfWeek : DaysOfWeek__c.getAll().values()) {            
            if (dayOfWeek.Name.toLowerCase() == day.toLowerCase()) {
                result = Integer.valueOf(dayOfWeek.Num__c);
                break;
            }
        }
        return result;
    }

}