public class EmailHelper {
    
    public static void sendEmail (List<String> adresses, String subject, String textBody) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(adresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(textBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    public static List<String> getCustomMetadataAdresses(String label) {
        Email_Setting__mdt [] mailSettings = [SELECT Email_adress__c 
                                              FROM Email_Setting__mdt 
                                              WHERE MasterLabel LIKE : label
                                             ];
        List<String> emailAdresses = new List<String>();
        
        for (Email_Setting__mdt setting : mailSettings) {
            string emailAdress = setting.Email_adress__c;
            emailAdresses.add(emailAdress);
        }
        return emailAdresses;
    }
    
}