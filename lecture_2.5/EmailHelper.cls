public class EmailHelper {
    
    public static void sendEmail (Set<String> addresses, String subject, String textBody) {
        List<String> emailAddressesWithoutDuplicates = new List<String>(addresses); 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(emailAddressesWithoutDuplicates);
        mail.setSubject(subject);
        mail.setPlainTextBody(textBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    public static Set<String> getCustomMetadataAddresses(String settingsName) {
        Email_Setting__mdt [] mailSettings = [
            SELECT Email_adress__c 
            FROM Email_Setting__mdt 
            WHERE DeveloperName LIKE : settingsName
        ];
        Set<String> emailAddresses = new Set<String>();
        
        for (Email_Setting__mdt setting : mailSettings) {
            String emailAddress = setting.Email_Address__c;
            emailAddresses.add(emailAddress);
        }
        return emailAddresses;
    }
}