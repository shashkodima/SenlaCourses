public class EmailHelper {
    
    public static void sendEmail (Set<String> adresses, String subject, String textBody) {
        List<String> emailAdressesWitoutDuplicates = new List<String>(adresses); 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(emailAdressesWitoutDuplicates);
        mail.setSubject(subject);
        mail.setPlainTextBody(textBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    public static Set<String> getCustomMetadataAdresses(String settingsName) {
        Email_Setting__mdt [] mailSettings = [
            SELECT Email_adress__c 
            FROM Email_Setting__mdt 
            WHERE DeveloperName LIKE : settingsName
        ];
        Set<String> emailAdresses = new Set<String>();
        
        for (Email_Setting__mdt setting : mailSettings) {
            String emailAdress = setting.Email_adress__c;
            emailAdresses.add(emailAdress);
        }
        return emailAdresses;
    }
}